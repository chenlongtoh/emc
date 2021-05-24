import 'package:emc/auth/index.dart';
import 'package:emc/auth/ui/page/forgot_password_page.dart';
import 'package:emc/screens/counsellor/schedule/ui/page/schedule_page.dart';
import 'package:emc/screens/student/appointment/ui/page/counsellor_list_page.dart' as AppointmentCounsellorList;
import 'package:emc/screens/student/change_password/ui/page/change_password_page.dart';
import 'package:emc/screens/student/chatbot/ui/page/analysis_result_page.dart';
import 'package:emc/screens/student/connection/ui/page/counsellor_list_page.dart' as ConnectionCounsellorList;
import 'package:emc/screens/student/home.dart';
import 'package:emc/screens/student/profile/ui/student_profile.dart';
import 'package:emc/screens/student/profile/ui/update_profile.dart' as Student;
import 'package:emc/screens/counsellor/profile/ui/page/update_profile.dart' as Counsellor;
import 'package:emc/screens/student/registration/index.dart';
import 'package:flutter/material.dart';
import 'package:emc/screens/counsellor/profile/ui/page/counsellor_profile.dart';
import 'package:provider/provider.dart';

class EmcRouter {
  static final Function onGenerateRoute = (settings) {
    switch (settings?.name) {
      case StudentHome.routeName:
        return MaterialPageRoute(builder: (_) => StudentHome());
      case RegisterScreen.routeName:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case ForgotPasswordPage.routeName:
        return MaterialPageRoute(builder: (_) => ForgotPasswordPage());
      case ChangePasswordPage.routeName:
        return MaterialPageRoute(builder: (_) => ChangePasswordPage());
      case ConnectionCounsellorList.CounsellorListPage.routeName:
        final ConnectionCounsellorList.CounsellorListPageArgs args = settings.arguments;
        return MaterialPageRoute(builder: (_) => ConnectionCounsellorList.CounsellorListPage(args: args));
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
      case AppointmentCounsellorList.CounsellorListPage.routeName:
        final AppointmentCounsellorList.CounsellorListPageArgs args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: args.appointmentModel,
            child: AppointmentCounsellorList.CounsellorListPage(),
          ),
        );
      case Student.UpdateProfilePage.routeName:
        return MaterialPageRoute(builder: (_) => Student.UpdateProfilePage());
      case Counsellor.UpdateProfilePage.routeName:
        return MaterialPageRoute(builder: (_) => Counsellor.UpdateProfilePage());
      case AnalysisResultPage.routeName:
        final AnalysisResultPageArgs args = settings.arguments;
        return MaterialPageRoute(builder: (_) => AnalysisResultPage(args: args));
      default:
        return MaterialPageRoute(builder: (_) => LoginScreen());
    }
  };
}
