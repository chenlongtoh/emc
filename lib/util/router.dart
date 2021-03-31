import 'package:emc/auth/index.dart';
import 'package:emc/screens/student/change_password/ui/page/change_password_page.dart';
import 'package:emc/screens/student/home.dart';
import 'package:emc/screens/student/profile/ui/student_profile.dart';
import 'package:emc/screens/student/registration/index.dart';
import 'package:flutter/material.dart';
import 'package:emc/screens/counsellor/counsellor_profile/ui/page/counsellor_profile.dart';

class EmcRouter {
  static final Function onGenerateRoute = (settings) {
    switch (settings?.name) {
      case StudentHome.routeName:
        return MaterialPageRoute(builder: (_) => StudentHome());
      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case ChangePasswordPage.routeName:
        return MaterialPageRoute(builder: (_) => ChangePasswordPage());
      case CounsellorProfile.routeName:
        final CounsellorProfilePageArgs args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => CounsellorProfile(
            counsellorId: args?.counsellorId,
          ),
        );
      case StudentProfile.routeName:
        final StudentProfilePageArgs args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => StudentProfile(
            uid: args?.studentId,
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  };
}