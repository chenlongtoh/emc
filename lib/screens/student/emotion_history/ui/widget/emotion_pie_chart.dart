import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class EmotionPieChart extends StatelessWidget {
  final int happyEmotion;
  final int sadEmotion;
  final int angryEmotion;
  EmotionPieChart({this.happyEmotion, this.sadEmotion, this.angryEmotion});

  List<Color> colorList = [
    Color(0xffed1c24),
    Color(0xff55acee),
    Color(0xffff7f27),
  ];

  @override
  Widget build(BuildContext context) {
    return PieChart(
      dataMap: {
        "Angriness": angryEmotion.toDouble(),
        "Sadness": sadEmotion.toDouble(),
        "Happiness": happyEmotion.toDouble(),
      },
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 20,
      chartRadius: MediaQuery.of(context).size.width * 0.6,
      colorList: colorList,
      initialAngleInDegree: 0,
      chartType: ChartType.disc,
      legendOptions: LegendOptions(
        showLegendsInRow: true,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendShape: BoxShape.rectangle,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        decimalPlaces: 1,
      ),
    );
  }
}
