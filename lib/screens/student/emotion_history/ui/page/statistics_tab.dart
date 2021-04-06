import 'package:emc/common_widget/emc_shimmer.dart';
import 'package:emc/screens/student/emotion_entry/constant.dart';
import 'package:emc/screens/student/emotion_history/model/view_model/emotion_history_model.dart';
import 'package:emc/screens/student/emotion_history/ui/widget/emotion_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StatisticsTab extends StatefulWidget {
  final EmotionHistoryModel emotionHistoryModel;
  StatisticsTab({this.emotionHistoryModel});

  @override
  _StatisticsTabState createState() => _StatisticsTabState();
}

class _StatisticsTabState extends State<StatisticsTab> with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController;
  Future _emotionRecords;

  void _onRefresh() async {
    _emotionRecords = widget.emotionHistoryModel.emotionRecordCountByEmotion;
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController(initialRefresh: false);
    _emotionRecords = widget.emotionHistoryModel.emotionRecordCountByEmotion;
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      onRefresh: _onRefresh,
      enablePullDown: true,
      child: FutureBuilder(
        future: _emotionRecords,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.data != null && snapshot.data is Map) {
              final Map<Emotion, dynamic> emotionCountMap = snapshot.data;
              final totalCount = emotionCountMap.values.fold(0, (previousValue, currentValue) => previousValue + currentValue);
              final happyEmotion = emotionCountMap[Emotion.happy];
              final sadEmotion = emotionCountMap[Emotion.sad];
              final angryEmotion = emotionCountMap[Emotion.angry];

              if (totalCount != 0) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      EmotionPieChart(
                        happyEmotion: happyEmotion,
                        sadEmotion: sadEmotion,
                        angryEmotion: angryEmotion,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.centerLeft,
                        child: Text("Total Record: $totalCount"),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                EMOTION_ICON_ASSET_MAP[Emotion.happy],
                                height: 50,
                              ),
                              SizedBox(height: 10),
                              Text("$happyEmotion (${(happyEmotion / totalCount).toStringAsFixed(1)}%)"),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                EMOTION_ICON_ASSET_MAP[Emotion.sad],
                                height: 50,
                              ),
                              SizedBox(height: 10),
                              Text("$sadEmotion (${(sadEmotion / totalCount).toStringAsFixed(1)}%)"),
                            ],
                          ),
                          Column(
                            children: [
                              Image.asset(
                                EMOTION_ICON_ASSET_MAP[Emotion.angry],
                                height: 50,
                              ),
                              SizedBox(height: 10),
                              Text("$angryEmotion (${(angryEmotion / totalCount).toStringAsFixed(1)}%)"),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }

              return Center(child: Text("No Statistics Available yet"));
            }
            return Center(child: Text("No Statistics Available yet"));
          }
          return EmcShimmerList();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
