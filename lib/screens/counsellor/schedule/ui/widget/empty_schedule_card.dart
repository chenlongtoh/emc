import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

const double STROKE_WIDTH = 2;

class EmptyScheduleCard extends StatelessWidget {
  final bool selected;
  EmptyScheduleCard({this.selected = false});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: selected ? Colors.red : Colors.white,
      dashPattern: [6],
      borderType: BorderType.RRect,
      radius: Radius.circular(15),
      strokeWidth: STROKE_WIDTH,
      child: SizedBox(
        height: CARD_HEIGHT - 2 * STROKE_WIDTH,
        width: CARD_WIDTH - 2 * STROKE_WIDTH,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          child: Container(
            alignment: Alignment.center,
            color: selected ? Colors.white : null,
            child: Text(
              selected ? "Selected" : "Open",
              style: TextStyle(
                color: selected ? Colors.red : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
