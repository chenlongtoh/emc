import 'package:emc/screens/counsellor/appointment/model/entity/appointment.dart';
import 'package:emc/screens/counsellor/connection/model/entity/connection.dart';
import 'package:emc/screens/counsellor/home/constant.dart';
import 'package:emc/screens/student/profile/ui/student_profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../constant.dart';

class UpcomingAppointmentCard extends StatelessWidget {
  final Appointment appointment;
  UpcomingAppointmentCard({this.appointment});

  Widget _buildDate() {
    if (appointment?.startTime == null) return Text("-");
    final DateTime startDate = new DateTime.fromMillisecondsSinceEpoch(appointment.startTime);
    final DateTime endDate = new DateTime.fromMillisecondsSinceEpoch(appointment.endTime);
    final String datetimeStr = "${DateFormat("ha").format(startDate)} to ${DateFormat("ha").format(endDate)}";

    return Text(datetimeStr);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(CARD_RADIUS),
        color: Colors.white,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 15,
        horizontal: 15,
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: appointment?.student?.profilePicture?.isEmpty ?? true
                ? AssetImage("assets/images/default_avatar.png")
                : NetworkImage(appointment?.student?.profilePicture),
          ),
          Spacer(flex: 1),
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  appointment?.student?.name ?? "-",
                  style: EmcTextStyle.listTitle,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 3),
                _buildDate(),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: EmcColors.grey,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(DateTime.fromMillisecondsSinceEpoch(appointment?.startTime)?.day?.toString() ?? "-"),
                    Text(DateFormat.MMM().format(DateTime.fromMillisecondsSinceEpoch(appointment?.startTime)) ?? "-"),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
