import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as Path;

class RegistrationService {
  static Future register(Map<String, dynamic> data) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: data["email"], password: data["password"])
          .then((UserCredential credential) async {
        CollectionReference users = FirebaseFirestore.instance.collection('users');

        if (data["profilePic"] != null) {
          await users.doc(credential?.user?.uid ?? "").set({
            "name": data["name"],
            "matric": data["matric"],
            "email": data["email"],
            "isStudent": true,
          }).then((value) async {
            Reference storageReference = FirebaseStorage.instance
                .ref()
                .child("images/${credential?.user?.uid}/profile_pic/")
                .child("${Path.basename(data["profilePic"]?.path)}");
            await storageReference.putFile(data["profilePicture"]).then((value) {
              print("StorageReference.putFile.then $value");
              storageReference.getDownloadURL().then((fileUrl) async {
                print("getDownloadUrl.then $fileUrl");
                await users.doc(credential?.user?.uid).update({"profilePicture": fileUrl});
              });
            });
          });
        } else {
          await users.doc(credential?.user?.uid ?? "").set({
            "name": data["name"],
            "matric": data["matric"],
            "isStudent": true,
            "email": data["email"],
            "profilePicture": null,
          });
        }
      });
      return true;
    } on FirebaseException catch (e) {
      EasyLoading.showError("Error => $e");
    }
    return false;
  }
}
