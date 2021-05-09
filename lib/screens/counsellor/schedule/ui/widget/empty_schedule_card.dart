import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

import '../../constant.dart';

const double STROKE_WIDTH = 2;

class EmptyScheduleCard extends StatelessWidget {
  final bool selected;
  final String text;
  final Color onSelectColor;

  EmptyScheduleCard({this.selected = false, this.text, this.onSelectColor = Colors.red});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      color: selected ? onSelectColor : Colors.white,
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
              selected ? "Selected" : text ?? "-",
              style: TextStyle(
                color: selected ? onSelectColor : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
