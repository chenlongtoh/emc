//import 'package:emc/pages/authentication/login.dart';
import 'package:emc/util/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:emc/app.dart';
import 'package:emc/constant.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:emc/util/router.dart';

import 'auth/model/view_model/auth_model.dart';
// import 'package:emc/pages/authentication/animation.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  configLoading();
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..maskType = EasyLoadingMaskType.black;
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: EmcColors.pink,
        scaffoldBackgroundColor: Colors.transparent,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: EmcColors.pink,
          unselectedItemColor: Colors.black,
          elevation: 1,
        ),
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0, // This removes the shadow from all App Bars.
        ),
      ),
      navigatorKey: NavigationService.instance.navigationKey,
      onGenerateRoute: EmcRouter.onGenerateRoute,
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthModel>(create: (_) => AuthModel()),
        ],
        child: FutureBuilder(
          future: _initialization,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              EasyLoading.dismiss();
              return App();
            } else {
              EasyLoading.show();
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/background-2.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            }
          },
        ),
      ),
      builder: EasyLoading.init(),
    );
  }
}
