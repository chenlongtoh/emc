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
        return authModel?.user == null
            ? LoginScreen()
            : authModel?.emcUser?.isStudent ?? false
                ? StudentHome()
                : LoginScreen();
      },
    );
  }
}
