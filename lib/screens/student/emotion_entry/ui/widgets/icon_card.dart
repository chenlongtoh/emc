import 'package:flutter/material.dart';
import 'package:emc/screens/student/emotion_entry/constant.dart';

class IconCard extends StatelessWidget {
  final Emotion emotion;
  final bool selected;
  IconCard({this.emotion, this.selected});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: selected ? Colors.white : Colors.white70,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 20,
        ),
        child: Column(
          children: [
            Image.asset(
              emotion.emotionIconAssetPath,
              fit: BoxFit.contain,
              height: 80,
            ),
            SizedBox(height: 8),
            Center(
              child: Text(emotion.emotionString),
            ),
          ],
        ),
      ),
    );
    // return InkWell(
    //   splashColor: Colors.red[400],
    //   onTap: onTap != null ? onTap : null,
    //   borderRadius: BorderRadius.circular(20),
    //   child:
    // );
  }
}
