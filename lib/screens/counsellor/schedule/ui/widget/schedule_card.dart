import 'package:dotted_border/dotted_border.dart';
import 'package:emc/constant.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

const double STROKE_WIDTH = 4;

class ScheduleCard extends StatelessWidget {
  final ScheduleStatus status;
  final String studentProfilePicture;
  final String studentName;
  final String message;
  final bool disabled;
  final bool selected;

  const ScheduleCard({
    this.status,
    this.studentProfilePicture,
    this.studentName,
    this.message,
    this.disabled,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CARD_HEIGHT,
      width: CARD_WIDTH,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: Container(
          foregroundDecoration: disabled
              ? BoxDecoration(
                  color: Color(0x7F000000),
                )
              : null,
          child: Stack(
            children: [
              Container(
                color: status == ScheduleStatus.blocked
                    ? Colors.red
                    : status == ScheduleStatus.booked
                        ? Colors.green
                        : Colors.grey,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  height: CARD_HEIGHT,
                  width: CARD_WIDTH * 0.95,
                  color: Colors.white,
                  padding: const EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        status == ScheduleStatus.booked ? "Appointment with:" : "Blocked for:",
                        style: TextStyle(
                          color: EmcColors.grey,
                          fontSize: EmcFontSize.subtitle10,
                        ),
                      ),
                      Expanded(
                        child: status == ScheduleStatus.booked
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: (studentProfilePicture?.isEmpty ?? true)
                                        ? AssetImage("assets/images/default_avatar.png")
                                        : NetworkImage(studentProfilePicture),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    flex: 8,
                                    child: Text(
                                      (studentName?.isNotEmpty ?? false) ? studentName : "-",
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              )
                            : Center(
                                child: Text(
                                  (message?.isNotEmpty ?? false) ? message : "-",
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
              if (selected)
                DottedBorder(
                  color: Colors.green[400],
                  dashPattern: [6],
                  borderType: BorderType.RRect,
                  radius: Radius.circular(5),
                  strokeWidth: STROKE_WIDTH,
                  child: Center(
                    child: SizedBox(
                      height: CARD_HEIGHT - 2 * STROKE_WIDTH,
                      width: CARD_WIDTH - 2 * STROKE_WIDTH,
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
