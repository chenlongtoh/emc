import 'package:emc/screens/student/chatbot/constant.dart';
import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget {
  final String message;
  final bool isBotMessage;
  ChatBox({this.message, this.isBotMessage = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Align(
        alignment: isBotMessage ? Alignment.centerLeft : Alignment.centerRight,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isBotMessage ? Colors.white : CHAT_BOX_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: Text(
            message ?? "-",
            style: isBotMessage ? null : TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
