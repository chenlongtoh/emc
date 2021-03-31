import 'dart:developer';

import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/screens/student/profile/service/student_profile_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class StudentProfileModel {
  final String uid;
  EmcUser user;

  StudentProfileModel({this.uid});

  Future getStudentProfile() async {
    try {
      final response = await StudentProfileService.getStudentDetailsById(uid);
      if (response != null) {
        user = EmcUser.fromJson(response);
      }
      return user;
    } catch (e) {
      log("Error @ getStudentProfile => $e");
      EasyLoading.showError("Error => $e");
    }
    return null;
  }
}
