import 'package:emc/screens/counsellor/connection/model/entity/connection.dart';
import 'package:emc/screens/counsellor/home/constant.dart';
import 'package:emc/screens/student/profile/ui/student_profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ConnectionDetailsCard extends StatelessWidget {
  final Connection connection;
  final Function onAccept;
  final Function onDecline;
  ConnectionDetailsCard({this.connection, this.onAccept, this.onDecline});

  Widget _buildDate() {
    if (connection?.date == null) return Text("-");
    final DateTime date = new DateTime.fromMillisecondsSinceEpoch(connection.date);
    String datetimeStr = DateFormat("dd MMM yyyy hh:mm a").format(date);
    return Text(
      datetimeStr,
      style: TextStyle(color: Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: CARD_RADIUS, topRight: CARD_RADIUS),
              color: Colors.blue,
            ),
            // padding: const EdgeInsets.symmetric(horizontal: 25),
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
                        backgroundImage: connection?.connectedStudent?.profilePicture?.isEmpty ?? true
                            ? AssetImage("assets/images/default_avatar.png")
                            : NetworkImage(connection?.connectedStudent?.profilePicture),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          connection?.connectedStudent?.name ?? "-",
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 10),
                      GestureDetector(
                        child: Icon(
                          Icons.info_outline,
                          color: Colors.blue,
                        ),
                        onTap: () => Navigator.pushNamed(
                          context,
                          StudentProfile.routeName,
                          arguments: StudentProfilePageArgs(studentId: connection?.connectedStudent?.sid),
                        ),
                      ),
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
