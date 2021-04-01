import 'dart:convert';
import 'dart:developer';

import 'package:emc/screens/counsellor/home.dart';
import 'package:flutter/material.dart';
import 'package:emc/screens/student/home.dart';
import 'package:emc/auth/ui/page/login.dart';
import 'package:provider/provider.dart';

import 'auth/model/view_model/auth_model.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("App rebuilt");
    return Consumer<AuthModel>(
      builder: (context, authModel, child) {
        // return StudentHome();
        log("AuthModel => ${json.encode(authModel.emcUser)}");
        return authModel?.user == null
            ? LoginScreen()
            : authModel?.emcUser?.isStudent ?? false
                ? StudentHome()
                : CounsellorHome();
      },
    );
  }
}
