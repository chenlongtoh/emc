import 'package:emc/screens/student/chatbot/model/entity/analysis_result.dart';
import 'package:flutter/material.dart';

class EmotionAnalysisResultCard extends StatelessWidget {
  final AnalysisResult result;

  const EmotionAnalysisResultCard({this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      width: 300,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
        color: Colors.grey[350].withAlpha(190),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Emotion Analysis Result", style: TextStyle(fontSize: 20)),
          SizedBox(height: 5),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Image.asset(
                    "assets/images/happy.png",
                    fit: BoxFit.cover,
                    height: 50,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Text("Happiness: ${result?.happinessInHundreds?.toStringAsFixed(2) ?? '-'}%"),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Image.asset(
                    "assets/images/sad.png",
                    fit: BoxFit.cover,
                    height: 50,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Sadness: ${result?.sadnessInHundreds?.toStringAsFixed(2) ?? '-'}%",
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Center(
                  child: Image.asset(
                    "assets/images/angry.png",
                    fit: BoxFit.cover,
                    height: 50,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  "Angriness: ${result?.angrinessInHundreds?.toStringAsFixed(2) ?? '-'}%",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
