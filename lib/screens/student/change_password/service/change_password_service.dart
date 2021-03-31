import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ChangePasswordService {
  static Future changePassword(String oldPassword, String newPassword) async {
    bool success = false;
    try {
      User user = FirebaseAuth.instance.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(email: user.email, password: oldPassword);
      await user.reauthenticateWithCredential(credential).then((value) async => await user.updatePassword(newPassword));
      success = true;
    } on FirebaseAuthException catch (fe) {
      EasyLoading.showError(fe.message);
    } catch (e) {
      log("Error @ changePassword => $e");
    }
    return success;
  }

  static Future validateOldPassword(String oldPassword) async {
    bool success = false;
    try {
      User user = FirebaseAuth.instance.currentUser;
      AuthCredential credential = EmailAuthProvider.credential(email: user.email, password: oldPassword);
      await user.reauthenticateWithCredential(credential);
      success = true;
    } catch (e) {
      log("Error @ changePassword => $e");
    }
    return success;
  }
}
