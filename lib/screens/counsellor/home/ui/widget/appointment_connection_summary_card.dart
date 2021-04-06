import 'package:flutter/material.dart';
import '../../../../../constant.dart';
import '../../constant.dart';

enum CardType { appointment, connection }

class AppointmentConnectionSummaryCard extends StatelessWidget {
  final CardType cardType;
  AppointmentConnectionSummaryCard({this.cardType});

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
                              Text("12"),
                              Text("July"),
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
                            Text("Sunday"),
                            Text("8am to 10am"),
                          ],
                        ),
                      )
                    ],
                  )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Conected Since"),
                      Text("12/10/2018"),
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
                  backgroundImage: AssetImage("assets/images/default_avatar.png"),
                ),
              ),
              Expanded(
                flex: 7,
                child: Center(
                  child: Text("Karl Simpson"),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
