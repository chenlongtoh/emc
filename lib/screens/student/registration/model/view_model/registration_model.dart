import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emc/screens/student/registration/service/registration_service.dart';
import 'package:emc/util/navigation_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class RegistrationModel {
  Future register({String email, String password, String name, String matric, File profilePicture}) async {
    EasyLoading.show();
    bool success = await RegistrationService.register({
      "email": email,
      "password": password,
      "name": name,
      "matric": matric,
      "profilePicture": profilePicture,
    });
    if (success) {
      EasyLoading.showSuccess("Account Registered Successfully").then((value) => NavigationService.instance.navigationKey.currentState.pop());
    }
    EasyLoading.dismiss();
  }
}
