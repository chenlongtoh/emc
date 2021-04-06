import 'package:emc/auth/index.dart';
import 'package:emc/screens/counsellor/schedule/ui/page/schedule_page.dart';
import 'package:emc/screens/student/change_password/ui/page/change_password_page.dart';
import 'package:emc/screens/student/connection/ui/page/counsellor_list.dart';
import 'package:emc/screens/student/home.dart';
import 'package:emc/screens/student/profile/ui/student_profile.dart';
import 'package:emc/screens/student/registration/index.dart';
import 'package:flutter/material.dart';
import 'package:emc/screens/counsellor/profile/ui/page/counsellor_profile.dart';

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
      case CounsellorList.routeName:
        final CounsellorListPageArgs args = settings.arguments;
        return MaterialPageRoute(builder: (_) => CounsellorList(args: args));
      case SchedulePage.routeName:
        final SchedulePageArgs args = settings.arguments;
        return MaterialPageRoute(builder: (_) => SchedulePage(args: args));
      case CounsellorProfile.routeName:
        final CounsellorProfilePageArgs args = settings.arguments;
        return MaterialPageRoute(builder: (_) => CounsellorProfile(args: args));
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
