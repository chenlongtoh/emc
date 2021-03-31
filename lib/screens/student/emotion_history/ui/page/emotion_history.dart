import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/screens/student/emotion_history/model/view_model/emotion_history_model.dart';
import 'package:emc/screens/student/emotion_history/ui/page/emotion_history_tab.dart';
import 'package:emc/screens/student/emotion_history/ui/page/statistics_tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmotionHistory extends StatefulWidget {
  @override
  _EmotionHistoryState createState() => _EmotionHistoryState();
}

class _EmotionHistoryState extends State<EmotionHistory> {
  EmotionHistoryModel emotionHistoryModel;
  @override
  void initState() {
    super.initState();
    final authModel = Provider.of<AuthModel>(context, listen: false);
    emotionHistoryModel = new EmotionHistoryModel(
      uid: authModel?.user?.uid ?? "",
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: EmcScaffold(
        appBar: AppBar(
          title: Text("Emotion History"),
          bottom: TabBar(
            tabs: [
              Tab(text: "History"),
              Tab(text: "Statistics"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            EmotionHistoryTab(
              emotionHistoryModel: emotionHistoryModel,
            ),
            StatisticsTab(
              emotionHistoryModel: emotionHistoryModel,
            ),
          ],
        ),
      ),
    );
  }
}
