import 'dart:developer';

import 'package:emc/common_widget/emc_shimmer.dart';
import 'package:emc/screens/student/emotion_entry/constant.dart';
import 'package:emc/screens/student/emotion_entry/model/entity/emotion_entry.dart';
import 'package:emc/screens/student/emotion_history/model/view_model/emotion_history_model.dart';
import 'package:emc/screens/student/emotion_history/ui/widget/history_card.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

const contentPadding = const EdgeInsets.symmetric(
  horizontal: 15,
  vertical: 15,
);

class HistorySection extends StatefulWidget {
  final EmotionHistoryModel model;
  HistorySection({this.model});

  @override
  _HistorySectionState createState() => _HistorySectionState();
}

class _HistorySectionState extends State<HistorySection> with AutomaticKeepAliveClientMixin {
  RefreshController _refreshController;
  Future _dataList;
  void _onRefresh() async {
    _dataList = _getDataListWithDelay();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController(initialRefresh: false);
    _dataList = _getDataListWithDelay();
  }

  Future _getDataListWithDelay() async {
    final futures = await Future.wait([
      widget.model.dataList,
      Future.delayed(Duration(milliseconds: 300)),
    ]);
    return futures[0];
  }

  String _getTimeString(num timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String meridiem = date.hour <= 12 ? "a.m." : "p.m.";
    String formattedHour = date.hour <= 12 ? "${date.hour}" : "${date.hour - 12}";
    return "${formattedHour.padLeft(2, '0')}:${'${date.minute}'.padLeft(2, '0')} $meridiem";
  }

  Emotion _getEmotionFromString(String value) => EMOTION_STRING_MAP.keys.firstWhere((k) => EMOTION_STRING_MAP[k] == value, orElse: () => null);

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
            child: Text(
              "Recorded Emotion :",
            ),
          ),
          Expanded(
            child: SmartRefresher(
              controller: _refreshController,
              onRefresh: _onRefresh,
              enablePullDown: true,
              child: FutureBuilder(
                future: _dataList,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data != null && (snapshot.data is List && snapshot.data.isNotEmpty)) {
                      List<EmotionEntry> emotionEntryList = snapshot.data;
                      return ListView.separated(
                        physics: new BouncingScrollPhysics(),
                        padding: contentPadding,
                        shrinkWrap: true,
                        itemCount: emotionEntryList.length,
                        separatorBuilder: (context, index) => SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final emotionEntry = emotionEntryList[index];
                          return HistoryCard(
                            timeString: _getTimeString(emotionEntry?.timestamp),
                            emotion: _getEmotionFromString(emotionEntry.emotion),
                            notes: emotionEntry?.notes,
                          );
                        },
                      );
                    }
                    return Center(
                      child: Text("No Emotion Recorded on the Selected Day"),
                    );
                  }
                  return EmcShimmerList();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
