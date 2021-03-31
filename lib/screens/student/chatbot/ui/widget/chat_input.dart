import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../constant.dart';

class ChatInput extends StatefulWidget {
  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0x4abfbbbb),
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                isDense: true,
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(27),
                  borderSide: new BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                hintText: "Chat here...",
              ),
              maxLines: 3,
              minLines: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              icon: Icon(
                Icons.send,
                color: CHAT_BOX_COLOR,
                size: 30,
              ),
              onPressed: () => null,
            ),
          ),
        ],
      ),
    );
  }
}
