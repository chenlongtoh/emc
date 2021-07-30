import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_button.dart';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/common_widget/emc_shimmer.dart';
import 'package:emc/constant.dart';
import 'package:emc/screens/counsellor/profile/model/view_model.dart/profile_model.dart';
import 'package:emc/screens/counsellor/schedule/ui/page/schedule_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:emc/screens/counsellor/profile/ui/page/update_profile.dart';
import '../../constant.dart';
import 'package:emc/auth/ui/page/change_password_page.dart';

class CounsellorProfilePageArgs {
  final String counsellorId;
  CounsellorProfilePageArgs({this.counsellorId});
}

class CounsellorProfile extends StatefulWidget {
  static const String routeName = "/counsellorProfile";
  final CounsellorProfilePageArgs args;
  CounsellorProfile({this.args});

  @override
  _CounsellorProfileState createState() => _CounsellorProfileState();
}

class _CounsellorProfileState extends State<CounsellorProfile> {
  AuthModel authModel;

  ProfileModel counsellorProfileModel;
  @override
  void initState() {
    super.initState();
    counsellorProfileModel = new ProfileModel(cid: widget?.args?.counsellorId);
    authModel = Provider.of<AuthModel>(context, listen: false);
  }

  Future<EmcUser> _getCounsellorProfile() async {
    if (authModel.isStudent) {
      var x = await counsellorProfileModel.getCounsellorDetailsById();
      return x;
    } else {
      return authModel.emcUser;
    }
  }

  Widget _buildQuote(String quote) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: CONTENT_HORIZONTAL_PADDING,
        ),
        child: Text(
          quote ?? "-",
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }

  Widget _buildProfileDetails(String qualification, String email, String officeNumber) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: CONTENT_HORIZONTAL_PADDING,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.school,
                color: EmcColors.lightGrey,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  qualification ?? "-",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: EmcColors.lightGrey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.mail_outline,
                color: EmcColors.lightGrey,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  email ?? "-",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: EmcColors.lightGrey,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.phone,
                color: EmcColors.lightGrey,
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(
                  officeNumber ?? "-",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: EmcColors.lightGrey,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      maskBackground: false,
      appBar: AppBar(
        title: Text('Counsellor Profile'),
      ),
      body: FutureBuilder(
        future: _getCounsellorProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final EmcUser counsellor = snapshot.data;
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: TOP_PADDING + AVATAR_RADIUS),
                  child: Container(
                    color: Colors.white,
                    child: Stack(
                      children: [
                        ListView(
                          physics: BouncingScrollPhysics(),
                          padding: const EdgeInsets.only(top: AVATAR_RADIUS + TOP_PADDING, bottom: 110),
                          children: [
                            _buildQuote(counsellor?.favouriteQuote),
                            _buildProfileDetails(counsellor?.qualification, counsellor?.email, counsellor?.officeNumber),
                          ],
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (authModel.isStudent)
                                  EmcButton(
                                    onPressed: () => Navigator.pushNamed(
                                      context,
                                      SchedulePage.routeName,
                                      arguments: SchedulePageArgs(counsellorId: counsellor?.uid),
                                    ),
                                    text: "View Schedule",
                                  ),
                                if (!authModel.isStudent) ...[
                                  EmcButton(
                                    onPressed: () => Navigator.pushNamed(context, UpdateProfilePage.routeName),
                                    text: "Update Profile",
                                  ),
                                  EmcButton(
                                    onPressed: () => Navigator.pushNamed(context, ChangePasswordPage.routeName),
                                    text: "Change Password",
                                  ),
                                ],
                                if (!authModel.isStudent)
                                  EmcButton(
                                    onPressed: () async {
                                      await authModel.logout().then((_) => Navigator.popUntil(context, (route) => route.isFirst));
                                    },
                                    text: "Log Out",
                                  ),
                              ],
                            ),
                          ),
                        ),
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
                            backgroundImage: counsellor?.profilePicture?.isNotEmpty ?? false
                                ? NetworkImage(counsellor?.profilePicture)
                                : AssetImage("assets/images/default_avatar.png"),
                          ),
                        ),
                        Center(
                          child: Text(
                            counsellor?.name ?? "-",
                            style: EmcTextStyle.listTitle,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return EmcShimmerList();
        },
      ),
    );
  }
}
