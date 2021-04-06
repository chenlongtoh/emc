import 'dart:developer';

import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/screens/counsellor/profile/service/profile_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProfileModel {
  String cid;

  ProfileModel({this.cid});

  Future getCounsellorDetailsById() async {
    try {
      final response = await ProfileService.getCounsellorById(cid);
      EmcUser emcUser;
      if (response != null) {
        emcUser = EmcUser.fromJson(response);
        emcUser.uid = cid;
      }
      return emcUser;
    } catch (e) {
      log("getCounsellorDetailsById Error => $e");
      EasyLoading.showError("Error => $e");
    }
    return null;
  }
}
