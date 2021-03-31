import 'package:flutter/material.dart';

import 'chat_box.dart';

class ChatWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        children: [
          ChatBox(
            isBotMessage: true,
          ),
          SizedBox(height: 4),
          ChatBox(
            isBotMessage: true,
          ),
          SizedBox(height: 8),
          ChatBox(
            isBotMessage: false,
          ),
          SizedBox(height: 8),
          ChatBox(
            isBotMessage: true,
          ),
          SizedBox(height: 4),
          ChatBox(
            isBotMessage: true,
          ),
          SizedBox(height: 4),
          ChatBox(
            isBotMessage: true,
          ),
          SizedBox(height: 8),
          ChatBox(
            isBotMessage: false,
          ),
          SizedBox(height: 8),
          ChatBox(
            isBotMessage: true,
          ),
          SizedBox(height: 4),
          ChatBox(
            isBotMessage: true,
          ),
          SizedBox(height: 4),
          ChatBox(
            isBotMessage: true,
          ),
          SizedBox(height: 8),
          ChatBox(
            isBotMessage: false,
          ),
          SizedBox(height: 8),
          ChatBox(
            isBotMessage: true,
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
