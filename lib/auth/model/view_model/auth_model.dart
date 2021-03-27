import 'package:emc/auth/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class AuthModel with ChangeNotifier {
  User user;
  bool hasLogin = false;
  bool isStudent = false;

  static final AuthModel _singleton = AuthModel._internal();

  factory AuthModel() {
    return _singleton;
  }

  AuthModel._internal();

  Future login({String email, String password}) async {
    EasyLoading.show();
    await AuthService.login(email: email, password: password).then((_user) async {
      user = _user;
      isStudent = await AuthService.checkIsStudent(_user.uid);
      print("then async");
    });
    hasLogin = true;
    EasyLoading.dismiss();
    notifyListeners();
    return user;
  }

  Future register({String email, String password}) async {
    user = await AuthService.login(email: email, password: password);
    hasLogin = true;
    return user;
  }

  Future logout() async {
    await AuthService.logout();
    hasLogin = false;
    notifyListeners();
  }

  @override
  String toString() {
    return "hasLogin => $hasLogin, $isStudent => $isStudent";
  }
}
