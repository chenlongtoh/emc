import 'package:flutter/material.dart';

import '../../constant.dart';

class ScheduleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: SizedBox(
        height: CARD_HEIGHT,
        width: CARD_WIDTH,
        child: Stack(
          children: [
            Container(color: Colors.red),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: CARD_HEIGHT,
                width: CARD_WIDTH * 0.95 ,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
