import 'dart:developer';

import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/screens/student/chatbot/model/view_model/chat_model.dart';
import 'package:emc/screens/student/chatbot/model/entity/sentiment_analyzer.dart';
import 'package:emc/screens/student/chatbot/ui/widget/chat_input.dart';
import 'package:emc/screens/student/chatbot/ui/widget/chat_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  ChatModel model = new ChatModel();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await model.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              "assets/images/logo.png",
              height: 40,
            ),
            SizedBox(width: 10),
            Text("Chatbot"),
          ],
        ),
      ),
      body: ChangeNotifierProvider.value(
        value: model,
        builder: (context, child) {
          return Column(
            children: [
              Expanded(
                child: ChatWindow(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ChatInput(),
              )
            ],
          );
        },
      ),
    );
  }
}
