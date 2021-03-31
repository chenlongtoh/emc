import 'dart:developer';

import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/auth/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuthModel with ChangeNotifier {
  User user;
  EmcUser emcUser;

  static final AuthModel _singleton = AuthModel._internal();

  factory AuthModel() {
    return _singleton;
  }

  AuthModel._internal();

  Future login({String email, String password}) async {
    EasyLoading.show();
    try {
      await AuthService.login(email: email, password: password).then((_user) async {
        user = _user;
        if (_user != null) {
          emcUser = await AuthService.getEmcUser(_user.uid);
          if (emcUser != null) {
            emcUser.uid = user?.uid;
          }
        }
      });
    } catch (e) {
      log("Error @ login => $e");
    }
    notifyListeners();
  }

  Future logout() async {
    EasyLoading.show();
    bool success = await AuthService.logout();
    if (success) {
      emcUser = null;
      log("emcUser = null");
    }
    notifyListeners();
  }

  bool get isStudent => emcUser?.isStudent ?? false;
}
