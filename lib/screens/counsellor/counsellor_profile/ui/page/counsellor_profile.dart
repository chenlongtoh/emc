import 'dart:convert';
import 'dart:developer';

import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_button.dart';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/common_widget/emc_shimmer.dart';
import 'package:emc/constant.dart';
import 'package:emc/screens/counsellor/counsellor_profile/model/view_model.dart/counsellor_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const double avatarRadius = 60;
const double topPadding = 10;
const double contentHorizontalPadding = 60;

class CounsellorProfilePageArgs {
  final String counsellorId;
  CounsellorProfilePageArgs({this.counsellorId});
}

class CounsellorProfile extends StatefulWidget {
  static const String routeName = "/counsellorProfile";
  final String counsellorId;
  CounsellorProfile({this.counsellorId});

  @override
  _CounsellorProfileState createState() => _CounsellorProfileState();
}

class _CounsellorProfileState extends State<CounsellorProfile> {
  CounsellorProfileModel counsellorProfileModel;
  @override
  void initState() {
    super.initState();
    counsellorProfileModel = new CounsellorProfileModel(cid: widget?.counsellorId);
  }

  Future<EmcUser> _getCounsellorProfile() async {
    final authModel = Provider.of<AuthModel>(context, listen: false);
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
          horizontal: contentHorizontalPadding,
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
        horizontal: contentHorizontalPadding,
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
                  padding: const EdgeInsets.only(top: topPadding + avatarRadius),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(children: [
                      Expanded(
                        child: ListView(
                          children: [
                            SizedBox(height: avatarRadius + topPadding),
                            Center(
                              child: Text(
                                counsellor?.name ?? "-",
                                style: EmcTextStyle.listTitle,
                              ),
                            ),
                            SizedBox(height: 2),
                            _buildQuote(counsellor?.favouriteQuote),
                            _buildProfileDetails(counsellor?.qualification, counsellor?.email, counsellor?.officeNumber),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: topPadding),
                        child: Center(
                          child: EmcButton(
                            onPressed: () => print("Stuff"),
                            text: "View Schedule",
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: topPadding),
                    child: CircleAvatar(
                      radius: avatarRadius + 3,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: avatarRadius,
                        backgroundImage: counsellor?.profilePicture != null
                            ? NetworkImage(counsellor?.profilePicture)
                            : AssetImage("assets/images/default_avatar.png"),
                      ),
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
