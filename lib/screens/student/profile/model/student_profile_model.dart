import 'dart:developer';
import 'dart:io';

import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/screens/student/profile/service/student_profile_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class StudentProfileModel extends ChangeNotifier {
  EmcUser student;
  final String uid;
  bool isLoading = false;

  StudentProfileModel({this.uid});

  Future init() async {
    setLoading();
    try {
      final response = await StudentProfileService.getStudentDetailsById(uid);
      if (response != null) {
        student = EmcUser.fromJson(response);
      }
    } catch (e) {
      log("Error @ getStudentProfile => $e");
      EasyLoading.showError("Error => $e");
    }
    setIdle();
  }

  setLoading() {
    isLoading = true;
    notifyListeners();
  }

  setIdle() {
    isLoading = false;
    notifyListeners();
  }
}
