import 'package:emc/screens/counsellor/appointment/model/entity/appointment.dart';
import 'package:emc/screens/counsellor/home/constant.dart';
import 'package:emc/screens/student/profile/ui/student_profile.dart';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppointmentDetailsCard extends StatelessWidget {
  final Appointment appointment;
  final Function onAccept;
  final Function onDecline;
  AppointmentDetailsCard({this.appointment, this.onAccept, this.onDecline});

  Widget _buildDate() {
    if (appointment?.startTime == null) return Text("-");
    final DateTime startDate = new DateTime.fromMillisecondsSinceEpoch(appointment.startTime);
    final DateTime endDate = new DateTime.fromMillisecondsSinceEpoch(appointment.endTime);
    final String datetimeStr = "${DateFormat("dd MMM yyyy ha").format(startDate)} - ${DateFormat("ha").format(endDate)}";

    return Text(
      datetimeStr,
      style: TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    log("appointment?.student?.profilePicture => ${appointment?.student?.profilePicture == null}");
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: CARD_RADIUS, topRight: CARD_RADIUS),
              color: Colors.blue,
            ),
            width: 230,
            height: CARD_HEIGHT,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Date Requested",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time,
                      color: Colors.white,
                    ),
                    SizedBox(width: 3),
                    _buildDate(),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: CARD_RADIUS, bottomRight: CARD_RADIUS),
              color: Colors.white,
            ),
            // padding: const EdgeInsets.symmetric(horizontal: 25),
            width: 230,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: appointment?.student?.profilePicture?.isEmpty ?? true
                            ? AssetImage("assets/images/default_avatar.png")
                            : NetworkImage(appointment?.student?.profilePicture),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          appointment?.student?.name ?? "-",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        icon: Icon(Icons.info_outline),
                        onPressed: () => Navigator.pushNamed(
                          context,
                          StudentProfile.routeName,
                          arguments: StudentProfilePageArgs(studentId: appointment?.student?.sid),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 3),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          "Accept",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      ),
                      onPressed: onAccept,
                    ),
                    SizedBox(width: 10),
                    TextButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          "Decline",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                            side: BorderSide(color: Colors.blue),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFECF0FD)),
                      ),
                      onPressed: onDecline,
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
