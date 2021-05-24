import 'package:flutter/material.dart';

class EmcColors {
  static const Color pink = Color(0xffc6359b);
  static const Color whiteOverlay = Colors.white54;
  static const Color grey = Color(0xffbbbbbb);
  static const Color lightGrey = Color(0xff999898);
  static const Color lightPink = Color(0xffe09eb5);
}

class EmcTextStyle{
  static const TextStyle listSubtitle = TextStyle(
    fontSize: EmcFontSize.subtitle10,
    color: EmcColors.lightGrey,
  );

  static const TextStyle listTitle = TextStyle(
    fontSize: EmcFontSize.title13,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle quote = TextStyle(
    fontSize: EmcFontSize.title13,
    fontWeight: FontWeight.bold,
    
  );
}

class EmcFontSize {
  static const double title13 = 13; 
  static const double subtitle10 = 10; 
}