
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/screens/counsellor/counsellor_home/ui/widget/appointment_connection_summary_card.dart';
import 'package:emc/screens/student/emotion_entry/ui/widgets/profile_button.dart';
import 'package:flutter/material.dart';

import '../../../../../constant.dart';

class CounsellorHomePage extends StatelessWidget {
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
          ProfileButton(
            darkStyle: true,
            onTap: () => null,
          ),
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
                AppointmentSummaryConnectionCard(),
                SizedBox(
                  width: 20,
                ),
                AppointmentSummaryConnectionCard(),
                SizedBox(
                  width: 20,
                ),
                AppointmentSummaryConnectionCard(),
                SizedBox(
                  width: 20,
                ),
                AppointmentSummaryConnectionCard(),
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
                  Text(
                    "Manage Appointment",
                    style: TextStyle(color: Colors.black),
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
                AppointmentSummaryConnectionCard(),
                SizedBox(
                  width: 20,
                ),
                AppointmentSummaryConnectionCard(),
                SizedBox(
                  width: 20,
                ),
                AppointmentSummaryConnectionCard(),
                SizedBox(
                  width: 20,
                ),
                AppointmentSummaryConnectionCard(),
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
                  Text(
                    "Manage Appointment",
                    style: TextStyle(color: Colors.black),
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