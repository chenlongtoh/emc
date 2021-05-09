import 'dart:developer';

import 'package:emc/constant.dart';
import 'package:emc/screens/student/appointment/model/entity/appointment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AcceptedItem extends StatelessWidget {
  final Appointment appointment;
  AcceptedItem({this.appointment});

  Widget _buildDayTimeText(DateTime startDate, DateTime endDate) {
    final String dayString = DateFormat.EEEE().format(startDate);
    final String startHourString = DateFormat('ha').format(startDate);
    final String endHourString = DateFormat('ha').format(endDate);
    return Text(
      "$dayString, $startHourString to $endHourString",
      style: EmcTextStyle.listTitle,
      overflow: TextOverflow.ellipsis,
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateTime startDate = DateTime.fromMillisecondsSinceEpoch(appointment.startTime);
    final DateTime endDate = DateTime.fromMillisecondsSinceEpoch(appointment.endTime);
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: EmcColors.grey,
        ),
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 15,
        ),
        child: Row(
          children: [
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
                      Text(startDate?.day?.toString() ?? "-"),
                      Text(DateFormat.MMM().format(startDate) ?? "-"),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDayTimeText(startDate, endDate),
                    SizedBox(height: 3),
                    Text(
                      (appointment?.counsellor?.name?.isNotEmpty ?? false) ? "with ${appointment.counsellor.name}" : '-',
                      overflow: TextOverflow.ellipsis,
                      style: EmcTextStyle.listSubtitle,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: CircleAvatar(
                radius: 30,
                backgroundImage: (appointment?.counsellor?.profilePicture?.isNotEmpty ?? false)
                    ? NetworkImage(appointment.counsellor.profilePicture)
                    : AssetImage("assets/images/default_avatar.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
