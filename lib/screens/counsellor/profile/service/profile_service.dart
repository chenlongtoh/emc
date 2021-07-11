import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path/path.dart' as Path;

class ProfileService {
  static Future getCounsellorById(String uid) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection("users");
      DocumentSnapshot snapshot = await users.doc(uid)?.get();
      return snapshot?.data();
    } on FirebaseException catch (e) {
      EasyLoading.showError("Error => ${e.message}");
      log("Error @ getCounsellorById => ${e.message}");
    } catch (e) {
      EasyLoading.showError("Error => $e");
      log("Error @ getCounsellorById => $e");
    }
    return null;
  }

  static Future updateProfile({AuthModel authModel, String name, File profilePicture, String qualification, String officeNo, String quote}) async {
    bool success = false;
    final String cid = authModel.user.uid;
    try {
      final Map<String, dynamic> data = {
        "favouriteQuote": quote,
        "name": name,
        "officeNumber": officeNo,
        "qualification": qualification,
      };

      if (profilePicture != null) {
        Reference storageReference = FirebaseStorage.instance.ref().child("images/$cid/profile_pic/").child("${Path.basename(profilePicture.path)}");
        await storageReference.putFile(profilePicture).then((value) {
          storageReference.getDownloadURL().then((fileUrl) async {
            print("getDownloadUrl.then $fileUrl");
            data["profilePicture"] = fileUrl;
          });
        });
      } else {
        data["profilePicture"] = authModel?.emcUser?.profilePicture;
      }

      CollectionReference users = FirebaseFirestore.instance.collection("users");
      await users.doc(cid).update(data);

      data.remove("officeNumber");
      data.remove("favouriteQuote");
      data["cid"] = cid;

      CollectionReference appointment = FirebaseFirestore.instance.collection("appointment");
      QuerySnapshot snapshot = await appointment.where("counsellor.cid", isEqualTo: cid).get();
      snapshot.docs.forEach((doc) async {
        await doc.reference.update({"counsellor": data});
      });

      CollectionReference connection = FirebaseFirestore.instance.collection("connection");
      snapshot = await connection.where("counsellor.cid", isEqualTo: cid).get();
      snapshot.docs.forEach((doc) async {
        await doc.reference.update({"counsellor": data});
      });

      authModel.name = name;
      authModel.officeNumber = officeNo;
      authModel.favouriteQuote = quote;
      authModel.qualification = qualification;
      if (profilePicture != null) authModel.profilePicture = data["profilePicture"];

      success = true;
    } on FirebaseException catch (e) {
      EasyLoading.showError("Error => ${e.message}");
      log("Error @ updateProfile => ${e.message}");
    } catch (e) {
      EasyLoading.showError("Error => $e");
      log("Error @ updateProfile => $e");
    }
    return success;
  }
}
