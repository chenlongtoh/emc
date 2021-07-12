import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:path/path.dart' as Path;

class StudentProfileService {
  static Future getStudentDetailsById(String sid) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection("users");
      DocumentSnapshot snapshot = await users.doc(sid).get();
      return snapshot.data();
    } catch (e) {
      log("Error on getStudentDetailsById => $e");
      EasyLoading.showError("Error => $e");
    }
    return null;
  }

  static Future updateProfile(AuthModel authModel, String name, String matric, File profilePicture) async {
    bool success = false;
    final String sid = authModel.user.uid;
    try {
      Map<String, dynamic> data = {
        "name": name,
        "matric": matric,
      };

      if (profilePicture != null) {
        Reference storageReference = FirebaseStorage.instance.ref().child("images/$sid/profile_pic/").child("${Path.basename(profilePicture.path)}");
        await storageReference.putFile(profilePicture).then((value) {
          storageReference.getDownloadURL().then((fileUrl) async {
            print("getDownloadUrl.then $fileUrl");
            data["profilePicture"] = fileUrl;
          });
        });
      }

      CollectionReference users = FirebaseFirestore.instance.collection("users");
      await users.doc(sid).update(data);

      data.remove("matric");

      CollectionReference appointment = FirebaseFirestore.instance.collection("appointment");
      QuerySnapshot snapshot = await appointment.where("student.sid", isEqualTo: sid).get();

      snapshot.docs.forEach((doc) async {
        final tmp = {
          ...data,
          "sid": sid,
        };
        if (tmp["profilePicture"] == null) {
          tmp["profilePicture"] = doc.data()["student"]["profilePicture"];
        }
        await doc.reference.update({"student": tmp});
      });

      CollectionReference connection = FirebaseFirestore.instance.collection("connection");
      snapshot = await connection.where("student.sid", isEqualTo: sid).get();

      snapshot.docs.forEach((doc) async {
        final tmp = {
          ...data,
          "sid": sid,
        };
        if (tmp["profilePicture"] == null) {
          tmp["profilePicture"] = doc.data()["student"]["profilePicture"];
        }
        await doc.reference.update({"student": tmp});
      });

      CollectionReference schedule = FirebaseFirestore.instance.collection("schedule");
      snapshot = await schedule.where("studentList.$sid.exist", isEqualTo: true).get();

      snapshot.docs.forEach((doc) async {
        final tmp = {
          ...data,
          "exist": true,
        };
        if (tmp["profilePicture"] == null) {
          tmp["profilePicture"] = doc.data()["studentList"][sid]["profilePicture"];
        }
        await doc.reference.update({"studentList.$sid": tmp});
      });

      authModel.emcUser.name = name;
      authModel.emcUser.matric = matric;
      if (profilePicture != null) authModel.emcUser.profilePicture = data["profilePicture"];

      success = true;
    } on FirebaseException catch (e) {
      log("Error @ updateProfile => ${e.message}");
      EasyLoading.showError("Error => $e");
    } catch (e) {
      log("Error @ updateProfile => $e");
    }
    return success;
  }
}
