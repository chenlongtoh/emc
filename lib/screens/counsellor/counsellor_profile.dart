import 'package:emc/common_widget/emc_button.dart';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/constant.dart';
import 'package:flutter/material.dart';

const double avatarRadius = 60;
const double topPadding = 10;
const double contentHorizontalPadding = 60;

class CounsellorProfile extends StatelessWidget {
  String _getQuoteString() {
    String quote =
        "Some quote shitSome quote shitSome quote shitSome quote shitSome quote shitSome quote shitSome quote shitSome quote shitSome quote shitSome quote shitSome quote shitSome quote shit";
    return '\"$quote\"';
  }

  Widget _buildButton() {
    return Center(
      child: EmcButton(
        onPressed: () => print("Stuff"),
        text: "View Schedule",
      ),
    );
  }

  Widget _buildQuote() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20,
          horizontal: contentHorizontalPadding,
        ),
        child: Text(
          _getQuoteString(),
          style: TextStyle(
            fontStyle: FontStyle.italic,
          ),
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
        ),
      ),
    );
  }

  Widget _buildProfileDetails() {
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
                  "Master of Psychological Medicine (Harvard University)",
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
                  "rajesh@qtpie.com",
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
                  "06-22356789",
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: topPadding + avatarRadius),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: ListView(
                children: [
                  SizedBox(height: avatarRadius + topPadding),
                  Center(
                    child: Text(
                      "Dr Rajesh",
                      style: EmcTextStyle.listTitle,
                    ),
                  ),
                  SizedBox(height: 2),
                  Center(
                    child: Text(
                      "PhD in Psychology",
                      style: EmcTextStyle.listSubtitle,
                    ),
                  ),
                  _buildQuote(),
                  _buildProfileDetails(),
                  _buildButton(),
                  SizedBox(height: topPadding),
                ],
              ),
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
                  backgroundImage: AssetImage("assets/images/default_avatar.png"),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
