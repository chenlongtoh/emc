import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emc/screens/counsellor/schedule/model/entity/schedule.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ScheduleService {
  static Future fetchScheduleByDate(DateTime date, String counsellorId) async {
    log("now is sumthing => ${date.toString()}");
    num currentDateTimestamp = new DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
    num nextDayDateTimestamp = new DateTime(date.year, date.month, date.day + 1).millisecondsSinceEpoch;
    try {
      CollectionReference schedule = FirebaseFirestore.instance.collection("schedule");
      QuerySnapshot snapshot = await schedule
          .where("counsellorId", isEqualTo: counsellorId)
          .where("date", isGreaterThanOrEqualTo: currentDateTimestamp)
          .where("date", isLessThanOrEqualTo: nextDayDateTimestamp)
          .get();
      log("Snapshot => ${snapshot.docs.length > 0 ? snapshot.docs.first.data() : snapshot.docs.length} & $counsellorId  ${currentDateTimestamp.toString()} ${nextDayDateTimestamp.toString()}");
      if (snapshot.docs.length > 0) {
        return Schedule.fromJson({
          ...snapshot.docs.first.data(),
          "docId": snapshot.docs.first.id,
        });
      }
    } catch (error) {
      log("Error @ fetchScheduleByDate => $error");
      EasyLoading.showError("Error: $error");
    }
    return null;
  }

  static Future blockSlots(String scheduleId, Map<String, dynamic> blockedSlot, String message) async {
    bool success = false;
    try {
      CollectionReference schedule = FirebaseFirestore.instance.collection("schedule");
      await schedule.doc(scheduleId).update({"blockedSlot": blockedSlot});
      success = true;
    } catch (error) {
      log("Error @ blockSlots => $error");
      EasyLoading.showError("Error: $error");
    }
    return success;
  }

  static Future openSlots(String scheduleId, Map<String, dynamic> blockedSlot) async {
    bool success = false;
    try {
      CollectionReference schedule = FirebaseFirestore.instance.collection("schedule");
      await schedule.doc(scheduleId).update({"blockedSlot": blockedSlot});
      success = true;
    } catch (error) {
      log("Error @ blockSlots => $error");
      EasyLoading.showError("Error: $error");
    }
    return success;
  }

  static Future createSchedule(Map<String, dynamic> data) async {
    bool success = false;
    try {
      CollectionReference schedule = FirebaseFirestore.instance.collection("schedule");
      await schedule.doc().set(data);
      success = true;
    } catch (error) {
      log("Error @ createSchedule => $error");
      EasyLoading.showError("Error: $error");
    }
    return success;
  }
}
