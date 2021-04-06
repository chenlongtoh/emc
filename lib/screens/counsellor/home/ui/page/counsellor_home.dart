import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/screens/counsellor/home/ui/widget/appointment_connection_summary_card.dart';
import 'package:emc/screens/counsellor/profile/ui/page/counsellor_profile.dart';
import 'package:emc/screens/student/emotion_entry/ui/widgets/profile_button.dart';
import 'package:flutter/material.dart';

import '../../../../../constant.dart';

class CounsellorHomePage extends StatelessWidget {
  final Function navigateToConnection;
  final Function navigateToAppointment;
  CounsellorHomePage({this.navigateToConnection, this.navigateToAppointment});

  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      appBar: AppBar(
        backgroundColor: EmcColors.whiteOverlay,
        title: Text(
          "Welcome Back!",
          style: TextStyle(
            color: EmcColors.grey,
            fontSize: 15,
          ),
        ),
        actions: [
          ProfileButton(darkStyle: true, onTap: () => Navigator.pushNamed(context, CounsellorProfile.routeName)),
          SizedBox(width: 10),
        ],
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Dr Rajesh",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Appointment(s)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 15),
          LimitedBox(
            maxHeight: 150,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: 20,
                ),
                AppointmentConnectionSummaryCard(cardType: CardType.appointment),
                SizedBox(
                  width: 20,
                ),
                AppointmentConnectionSummaryCard(cardType: CardType.appointment),
                SizedBox(
                  width: 20,
                ),
                AppointmentConnectionSummaryCard(cardType: CardType.appointment),
                SizedBox(
                  width: 20,
                ),
                AppointmentConnectionSummaryCard(cardType: CardType.appointment),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: navigateToAppointment,
                    child: Text(
                      "Manage Appointment",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Connection(s)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 15),
          LimitedBox(
            maxHeight: 150,
            child: ListView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(
                  width: 20,
                ),
                AppointmentConnectionSummaryCard(cardType: CardType.connection),
                SizedBox(
                  width: 20,
                ),
                AppointmentConnectionSummaryCard(cardType: CardType.connection),
                SizedBox(
                  width: 20,
                ),
                AppointmentConnectionSummaryCard(cardType: CardType.connection),
                SizedBox(
                  width: 20,
                ),
                AppointmentConnectionSummaryCard(cardType: CardType.connection),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: navigateToConnection,
                    child: Text(
                      "Manage Connection",
                      style: TextStyle(color: Colors.black),
                    ),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.black,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
