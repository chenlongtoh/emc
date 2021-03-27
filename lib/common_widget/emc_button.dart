import 'package:emc/constant.dart';
import 'package:flutter/material.dart';

class EmcButton extends StatelessWidget {
  final Function onPressed;
  final String text;

  EmcButton({this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)),
      child: Text(
        text ?? "-",
        style: TextStyle(color: Colors.black),
      ),
      onPressed: onPressed,
    );
  }
}