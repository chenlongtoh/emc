import 'package:emc/screens/student/emotion_entry/constant.dart';
import 'package:emc/screens/student/emotion_entry/model/entity/emotion_entry.dart';
import 'package:emc/screens/student/emotion_history/service/emotion_history_service.dart';

class EmotionHistoryModel{
  String uid;
  DateTime date;
  
  EmotionHistoryModel({this.date, this.uid});

  void setDate(DateTime newDate) => this.date = newDate;

  Future get dataList async {
    List<EmotionEntry> emotionEntryList = await EmotionHistoryService.getHistoryByDate(date, uid);
    emotionEntryList.sort((EmotionEntry a, EmotionEntry b) => a.timestamp.compareTo(b.timestamp));
    return emotionEntryList;
  }

  Future get emotionRecordCountByEmotion async {
    List<EmotionEntry> emotionEntryList = await EmotionHistoryService.getEmotionRecordCountByEmotion(uid);
    return {
      Emotion.happy: emotionEntryList.where((emotionEntry) => emotionEntry.emotion == Emotion.happy.emotionString).toList().length,
      Emotion.sad: emotionEntryList.where((emotionEntry) => emotionEntry.emotion == Emotion.sad.emotionString).toList().length,
      Emotion.angry: emotionEntryList.where((emotionEntry) => emotionEntry.emotion == Emotion.angry.emotionString).toList().length,
    };
  }
}