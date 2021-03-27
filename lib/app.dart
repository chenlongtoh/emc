import 'package:flutter/material.dart';
import 'package:emc/screens/student/home.dart';
import 'package:emc/auth/ui/page/login.dart';
import 'package:emc/screens/student/registration/ui/page/register.dart';
import 'package:provider/provider.dart';

import 'auth/model/view_model/auth_model.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("App rebuilt");
    return Consumer<AuthModel>(
      builder: (context, authModel, child) {
        // return StudentHome();
        print("Consumer<AuthModel> rebuilt ${authModel}");
        return authModel?.hasLogin ?? false
            ? authModel?.isStudent ?? false
                ? StudentHome()
                : LoginScreen()
            : LoginScreen();
      },
    );
  }
}
