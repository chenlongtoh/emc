import 'dart:developer';

import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/screens/counsellor/profile/service/profile_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ProfileModel extends ChangeNotifier {
  EmcUser counsellor;
  String cid;
  bool isLoading = false;

  ProfileModel({this.cid});

  Future init() async {
    setLoading();
    try {
      final response = await ProfileService.getCounsellorById(cid);
      EmcUser emcUser;
      if (response != null) {
        emcUser = EmcUser.fromJson(response);
        emcUser.uid = cid;
      }
      counsellor = emcUser;
    } catch (e) {
      log("getCounsellorDetailsById Error => $e");
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
