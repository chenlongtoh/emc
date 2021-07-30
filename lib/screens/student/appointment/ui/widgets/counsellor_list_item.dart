import 'package:emc/screens/counsellor/schedule/ui/page/schedule_page.dart';
import 'package:emc/screens/student/appointment/model/entity/appointment.dart';
import 'package:flutter/material.dart';

import '../../../../../constant.dart';

class CounsellorListItem extends StatelessWidget {
  final Counsellor counsellor;
  CounsellorListItem({this.counsellor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage:
                counsellor?.profilePicture?.isNotEmpty ?? false ? NetworkImage(counsellor.profilePicture) : AssetImage("assets/images/default_avatar.png"),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    counsellor?.name ?? "-",
                    style: EmcTextStyle.listTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 3),
                  Text(
                    counsellor?.qualification ?? "N/A",
                    overflow: TextOverflow.ellipsis,
                    style: EmcTextStyle.listSubtitle,
                  ),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pushNamed(
              context,
              SchedulePage.routeName,
              arguments: SchedulePageArgs(
                allowMakeAppointment: true,
                counsellorId: counsellor?.cid ?? "-",
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Select",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: Colors.black),
                ),
              ),
              backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
            ),
          ),
        ],
      ),
    );
  }
}
