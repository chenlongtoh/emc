import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emc/screens/student/emotion_entry/model/entity/emotion_entry.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EmotionHistoryService {
  static Future getHistoryByDate(DateTime date, String uid) async {
    try {
      num currentDateTimestamp = new DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
      num nextDayDateTimestamp = new DateTime(date.year, date.month, date.day + 1).millisecondsSinceEpoch;

      CollectionReference emotionRecord = FirebaseFirestore.instance.collection("emotionRecord");
      QuerySnapshot snapshot = await emotionRecord
          .where("uid", isEqualTo: uid)
          .where("timestamp", isGreaterThanOrEqualTo: currentDateTimestamp)
          .where("timestamp", isLessThan: nextDayDateTimestamp)
          .get();
      return snapshot.docs.map((doc) => EmotionEntry.fromJson(doc.data())).toList();
    } on FirebaseException catch (e) {
      log("Error => $e");
      EasyLoading.showError("Error => $e");
    }
    return [];
  }

  static Future getEmotionRecordCountByEmotion(String uid) async {
    try {

      CollectionReference emotionRecord = FirebaseFirestore.instance.collection("emotionRecord");
      QuerySnapshot snapshot = await emotionRecord
          .where("uid", isEqualTo: uid)
          .get();
      return snapshot.docs.map((doc) => EmotionEntry.fromJson(doc.data())).toList();
    } on FirebaseException catch (e) {
      log("Error => $e");
      EasyLoading.showError("Error => $e");
    }
    return [];
  }
}
