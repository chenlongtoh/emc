import 'package:emc/auth/index.dart';
import 'package:emc/screens/student/home.dart';
import 'package:emc/screens/student/registration/index.dart';
import 'package:flutter/material.dart';

class EmcRouter {
  static final Function onGenerateRoute = (settings) {
    switch (settings?.name) {
      case EmcRoutes.studentHome:
        return MaterialPageRoute(builder: (_) => StudentHome());
      case EmcRoutes.registerScreen:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case EmcRoutes.loginScreen:
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  };
}

class EmcRoutes{
  static const String loginScreen = "loginScreen";
  static const String registerScreen = "registerScreen";
  static const String studentHome = "studentHome";
}
