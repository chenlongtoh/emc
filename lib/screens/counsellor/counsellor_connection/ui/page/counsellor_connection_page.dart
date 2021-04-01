import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/screens/counsellor/counsellor_home/ui/widget/appointment_connection_summary_card.dart';
import 'package:emc/screens/student/emotion_entry/ui/widgets/profile_button.dart';
import 'package:flutter/material.dart';

import '../../../../../constant.dart';

class CounsellorConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      appBar: AppBar(
        title: Text(
          "Connections",
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 10),
            child: Text(
              "Request(s)",
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
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Connected Student(s)",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 15),
          Flexible(
            child: ListView(
              physics: BouncingScrollPhysics(),
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
        ],
      ),
    );
  }
}
