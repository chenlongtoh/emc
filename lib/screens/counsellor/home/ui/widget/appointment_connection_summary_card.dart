import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../../constant.dart';
import '../../constant.dart';

enum CardType { appointment, connection }

class AppointmentConnectionSummaryCard extends StatelessWidget {
  final CardType cardType;
  final DateTime startDate;
  final DateTime endDate;
  final String name;
  final String profilePictureUrl;

  AppointmentConnectionSummaryCard({this.cardType, this.startDate, this.name, this.profilePictureUrl, this.endDate});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: CARD_RADIUS,
              topRight: CARD_RADIUS,
            ),
            color: Colors.blue,
          ),
          width: CARD_WIDTH,
          height: CARD_HEIGHT,
          child: Padding(
            padding: INNER_PADDING,
            child: cardType == CardType.appointment
                ? Row(
                    children: [
                      AspectRatio(
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
                              Text(
                                startDate != null ? startDate.day.toString() : "-",
                              ),
                              Text(
                                startDate != null ? DateFormat.MMM().format(startDate) : "-",
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text("Sunday"),
                            Text(
                              startDate != null ? DateFormat.EEEE().format(startDate) : "-",
                            ),
                            Text(
                              (startDate != null && endDate != null)
                                  ? "${DateFormat("ha").format(startDate)} to ${DateFormat("ha").format(endDate)}"
                                  : "-",
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Conected Since"),
                      Text(
                        startDate != null ? DateFormat("dd/MM/yyyy").format(startDate) : "-",
                      ),
                    ],
                  ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: CARD_RADIUS,
              bottomRight: CARD_RADIUS,
            ),
            color: Colors.white,
          ),
          width: CARD_WIDTH,
          height: CARD_HEIGHT,
          padding: INNER_PADDING,
          child: Row(
            children: [
              Expanded(
                flex: 3,
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage:
                      (profilePictureUrl?.isEmpty ?? true) ? AssetImage("assets/images/default_avatar.png") : NetworkImage(profilePictureUrl),
                ),
              ),
              Expanded(
                flex: 7,
                child: Center(
                  child: Text(name ?? "-"),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
