import 'package:flutter/material.dart';

class EmcColors {
  static final Color pink = Color(0xffc6359b);
  static final Color whiteOverlay = Colors.white54;
  static final Color grey = Color(0xffbbbbbb);
  static final Color lightGrey = Color(0xff999898);
  static final Color lightPink = Color(0xffe09eb5);
}

class EmcTextStyle{
  static final TextStyle listSubtitle = TextStyle(
    fontSize: EmcFontSize.subtitle10,
    color: EmcColors.lightGrey,
  );

  static final TextStyle listTitle = TextStyle(
    fontSize: EmcFontSize.title13,
    fontWeight: FontWeight.bold,
  );

  static final TextStyle quote = TextStyle(
    fontSize: EmcFontSize.title13,
    fontWeight: FontWeight.bold,
    
  );
}

class EmcFontSize {
  static final double title13 = 13; 
  static final double subtitle10 = 10; 
}