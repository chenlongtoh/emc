import 'dart:developer';

import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  static Future login({String email, String password}) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential?.user;
    } on FirebaseAuthException catch (e) {
      log("Error @ login => $e");
      if (e.code == 'user-not-found') {
        EasyLoading.showError("No user found, please try again");
      } else if (e.code == 'wrong-password') {
        EasyLoading.showError("Wrong password, please try again");
      } else if (e.code == 'network-request-failed') {
        EasyLoading.showError("There may be a problem with your network, please try again");
      } else {
        EasyLoading.showError(e.message);
      }
    }
    return null;
  }

  static Future getEmcUser(String uid) async {
    try {
      CollectionReference users = await FirebaseFirestore.instance.collection("users");
      final doc = await users?.doc(uid)?.get();
      if (doc?.data() != null) {
        return EmcUser.fromJson(doc.data());
      }
    } on FirebaseException catch (error) {
      EasyLoading.showError(error.message);
    }
    return null;
  }

  static Future logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } on FirebaseException catch (error) {
      EasyLoading.showError(error.message);
    }
    return false;
  }
}
