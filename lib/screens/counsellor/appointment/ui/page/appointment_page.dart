import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/screens/counsellor/appointment/ui/widget/appointment_details_card.dart';
import 'package:emc/screens/counsellor/home/ui/widget/appointment_connection_summary_card.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      appBar: AppBar(
        title: Text(
          "Appointments",
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
          SizedBox(height: 10),
          LimitedBox(
            maxHeight: 200,
            child: Center(
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  AppointmentDetailsCard(),
                  SizedBox(
                    width: 20,
                  ),
                  AppointmentDetailsCard(),
                  SizedBox(
                    width: 20,
                  ),
                  AppointmentDetailsCard(),
                  SizedBox(
                    width: 20,
                  ),
                  AppointmentDetailsCard(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "Upcoming Appointment(s)",
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
                AppointmentConnectionSummaryCard(),
                SizedBox(
                  width: 20,
                ),
                AppointmentConnectionSummaryCard(),
                SizedBox(
                  width: 20,
                ),
                AppointmentConnectionSummaryCard(),
                SizedBox(
                  width: 20,
                ),
                AppointmentConnectionSummaryCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
