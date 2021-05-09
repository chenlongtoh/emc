import 'dart:math';

import 'package:emc/screens/student/chatbot/model/entity/quote.dart';
import 'package:emc/screens/student/emotion_entry/constant.dart';

class AnalysisResult {
  final double happiness;
  final double sadness;
  final double angriness;
  final Emotion emotionDetected;
  final Quote randomQuote;

  AnalysisResult({this.happiness, this.sadness, this.angriness, this.emotionDetected, this.randomQuote});

  double get highestPrediction => max(happiness, max(sadness, angriness));

  double get happinessInHundreds => happiness * 100;
  double get sadnessInHundreds => sadness * 100;
  double get angrinessInHundreds => angriness * 100;
}
