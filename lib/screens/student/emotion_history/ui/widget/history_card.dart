import 'package:emc/screens/student/emotion_entry/constant.dart';
import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  final String timeString;
  final Emotion emotion;
  final String notes;

  HistoryCard({this.timeString, this.emotion, this.notes}) : assert(emotion != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white70,
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Text("Recorded Time : ${timeString ?? '-'}"),
          SizedBox(height: 5),
          if (emotion != null) ...[
            Image.asset(
              emotion.emotionIconAssetPath,
              fit: BoxFit.cover,
              height: 80,
            ),
            SizedBox(height: 5)
          ],
          Align(
            alignment: Alignment.centerLeft,
            child: Text("Description : "),
          ),
          SizedBox(height: 2),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 1),
              color: Colors.white,
            ),
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 25),
            child: Text((notes != null && notes.isNotEmpty) ? notes : "-"),
          ),
        ],
      ),
    );
  }
}
