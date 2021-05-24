import 'package:emc/screens/student/chatbot/constant.dart';
import 'package:emc/screens/student/chatbot/model/entity/chat.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget {
  final Chat chat;
  ChatBox({this.chat});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Align(
        alignment: chat.chatType == ChatType.user ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: chat.chatType == ChatType.user ? CHAT_BOX_COLOR : Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(12)),
          ),
          child: chat.chatType == ChatType.user
              ? Text(
                  chat.text ?? "-",
                  style: TextStyle(color: Colors.white),
                )
              : chat.chatType == ChatType.bot
                  ? Text(chat.text ?? "-")
                  : SizedBox(
                    // height: 20,
                    width: 25,
                    child: JumpingDotsProgressIndicator(
                      fontSize: 12,
                    ),
                  ),
        ),
      ),
    );
  }
}
