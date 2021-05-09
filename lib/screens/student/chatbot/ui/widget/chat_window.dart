import 'dart:developer';

import 'package:emc/screens/student/chatbot/model/entity/chat.dart';
import 'package:emc/screens/student/chatbot/model/view_model/chat_model.dart';
import 'package:emc/screens/student/chatbot/ui/page/analysis_result_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'chat_box.dart';

class ChatWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatModel>(
      builder: (context, model, child) {
        List chatList = model.chatList.reversed.toList();
        log("model.analysisResult => ${model.analysisResult}");
        return Stack(
          children: [
            Container(
              child: ListView.separated(
                reverse: true,
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 50),
                itemCount: chatList.length ?? 0,
                separatorBuilder: (_, __) => SizedBox(height: 4),
                itemBuilder: (context, index) {
                  final Chat chat = chatList[index];
                  return ChatBox(
                    isBotMessage: chat.chatType == ChatType.bot,
                    message: chat.text,
                  );
                },
              ),
            ),
            if (model?.analysisResult != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ),
                    ),
                  ),
                  child: Text("View Analysis Result"),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      AnalysisResultPage.routeName,
                      arguments: AnalysisResultPageArgs(analysisResult: model.analysisResult),
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}
