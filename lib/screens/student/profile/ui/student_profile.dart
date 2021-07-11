import 'dart:convert';
import 'dart:developer';

import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_button.dart';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/common_widget/emc_shimmer.dart';
import 'package:emc/constant.dart';
import 'package:emc/auth/ui/page/change_password_page.dart';
import 'package:emc/screens/student/profile/model/student_profile_model.dart';
import 'package:emc/screens/student/profile/ui/update_profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constant.dart';

class StudentProfilePageArgs {
  final String studentId;
  StudentProfilePageArgs({this.studentId});
}

class StudentProfile extends StatefulWidget {
  static const String routeName = "/studentProfile";
  final String uid;
  StudentProfile({this.uid});

  @override
  StudentProfileState createState() => StudentProfileState();
}

class StudentProfileState extends State<StudentProfile> {
  StudentProfileModel model;
  AuthModel authModel;
  @override
  void initState() {
    super.initState();
    authModel = Provider.of<AuthModel>(context, listen: false);
    model = new StudentProfileModel(uid: widget?.uid);
    if (!authModel.isStudent) {
      model.init();
    }
  }

  Widget _buildProfileDetails(String matric, String name, String email) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: CONTENT_HORIZONTAL_PADDING,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Matric",
            style: TextStyle(color: EmcColors.lightGrey),
          ),
          SizedBox(height: 3),
          Text(
            matric ?? "-",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Name",
            style: TextStyle(color: EmcColors.lightGrey),
          ),
          SizedBox(height: 3),
          Text(
            name ?? "-",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          SizedBox(height: 5),
          Text(
            "Email",
            style: TextStyle(color: EmcColors.lightGrey),
          ),
          SizedBox(height: 3),
          Text(
            email ?? "-",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StudentProfileModel>.value(
      value: model,
      child: EmcScaffold(
        maskBackground: false,
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Consumer2<AuthModel, StudentProfileModel>(
          builder: (context, authModel, studentProfileModel, child) {
            if (studentProfileModel.isLoading) return EmcShimmerList();

            var student = authModel.isStudent ? authModel.emcUser : studentProfileModel.student;
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: TOP_PADDING + AVATAR_RADIUS),
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: TOP_PADDING),
                    child: ListView(
                      physics: new BouncingScrollPhysics(),
                      children: [
                        SizedBox(height: AVATAR_RADIUS),
                        _buildProfileDetails(student?.matric, student?.name, student?.email),
                        if (authModel?.isStudent) ...[
                          Center(
                            child: EmcButton(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                UpdateProfilePage.routeName,
                              ),
                              text: "Update Profile",
                            ),
                          ),
                          Center(
                            child: EmcButton(
                              onPressed: () => Navigator.pushNamed(context, ChangePasswordPage.routeName),
                              text: "Change Password",
                            ),
                          ),
                          Center(
                            child: EmcButton(
                              onPressed: () async {
                                await authModel.logout().then((_) => Navigator.popUntil(context, (route) => route.isFirst));
                              },
                              text: "Logout",
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: TOP_PADDING),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: AVATAR_RADIUS + 3,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: AVATAR_RADIUS,
                            backgroundImage: student?.profilePicture != null
                                ? NetworkImage(student?.profilePicture)
                                : AssetImage("assets/images/default_avatar.png"),
                          ),
                        ),
                        Center(
                          child: Text(
                            student?.name ?? "-",
                            maxLines: 3,
                            style: EmcTextStyle.listTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
