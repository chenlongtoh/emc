import 'dart:developer';

import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/screens/counsellor/counsellor_profile/service/counsellor_profile_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class CounsellorProfileModel {
  String cid;

  CounsellorProfileModel({this.cid});

  Future getCounsellorDetailsById() async {
    try {
      final response = await CounsellorProfileService.getCounsellorById(cid);
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
