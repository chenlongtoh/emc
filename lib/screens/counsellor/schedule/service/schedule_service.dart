import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/screens/counsellor/schedule/model/entity/schedule.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ScheduleService {
  static Future fetchScheduleByDate(DateTime date, String counsellorId) async {
    num currentDateTimestamp = new DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
    num nextDayDateTimestamp = new DateTime(date.year, date.month, date.day + 1).millisecondsSinceEpoch;
    try {
      CollectionReference schedule = FirebaseFirestore.instance.collection("schedule");
      QuerySnapshot snapshot = await schedule
          .where("counsellorId", isEqualTo: counsellorId)
          .where("date", isGreaterThanOrEqualTo: currentDateTimestamp)
          .where("date", isLessThanOrEqualTo: nextDayDateTimestamp)
          .get();
      if (snapshot.docs.length > 0) {
        return Schedule.fromJson({
          ...snapshot.docs.first.data(),
          "docId": snapshot.docs.first.id,
        });
      }
    } on FirebaseException catch (error) {
      log("Error @ fetchScheduleByDate => ${error.message}");
      EasyLoading.showError("Error: ${error.message}");
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
    } on FirebaseException catch (error) {
      log("Error @ blockSlots => ${error.message}");
      EasyLoading.showError("Error: ${error.message}");
    } catch (error) {
      log("Error @ blockSlots => $error");
      EasyLoading.showError("Error: $error");
    }
    return success;
  }

  static Future openSlots(String scheduleId, Map<String, dynamic> blockedSlot) async {
    bool success = false;
    try {
      log("scheduleId => $scheduleId");
      CollectionReference schedule = FirebaseFirestore.instance.collection("schedule");
      await schedule.doc(scheduleId).update({"blockedSlot": blockedSlot});
      success = true;
    } on FirebaseException catch (error) {
      log("Error @ openSlots => ${error.message}");
      EasyLoading.showError("Error: ${error.message}");
    } catch (error) {
      log("Error @ openSlots => $error");
      EasyLoading.showError("Error: $error");
    }
    return success;
  }

  static Future bookSlot(String scheduleId, Map<String, dynamic> data) async {
    bool success = false;
    try {
      CollectionReference schedule = FirebaseFirestore.instance.collection("schedule");
      await schedule.doc(scheduleId).update(data);
      success = true;
    } on FirebaseException catch (error) {
      log("Error @ bookSlot => ${error.message}");
      EasyLoading.showError("Error: ${error.message}");
    } catch (error) {
      log("Error @ bookSlot => $error");
      EasyLoading.showError("Error: $error");
    }
    return success;
  }

  static Future createSchedule(Map<String, dynamic> data) async {
    try {
      CollectionReference schedule = FirebaseFirestore.instance.collection("schedule");
      DocumentReference doc = await schedule.add(data);
      return doc.id;
    } on FirebaseException catch (error) {
      log("Error @ createSchedule => ${error.message}");
      EasyLoading.showError("Error: ${error.message}");
    } catch (error) {
      log("Error @ createSchedule => $error");
      EasyLoading.showError("Error: $error");
    }
    return null;
  }

   static Future getCounsellorById(String uid) async {
    try {
      CollectionReference users = FirebaseFirestore.instance.collection("users");
      DocumentSnapshot snapshot = await users.doc(uid).get();
      return EmcUser.fromJson({
        ...snapshot.data(),
        "uid": uid,
      });
    } on FirebaseException catch (error) {
      log("Error @ getCounsellorById => ${error.message}");
      EasyLoading.showError("Error: ${error.message}");
    } catch (error) {
      log("Error @ getCounsellorById => $error");
      EasyLoading.showError("Error => $error");
    }
    return null;
  }

  static Future updateBookedSlotStatus(String slotId, String status, num slot) async {
    try {
      CollectionReference schedule = FirebaseFirestore.instance.collection("schedule");
      await schedule.doc(slotId).update({ "bookedSlot.$slot.status": status});
      // return EmcUser.fromJson({
      //   ...snapshot.data(),
      //   "uid": uid,
      // });
      return true;
    } on FirebaseException catch (error) {
      log("Error @ getCounsellorById => ${error.message}");
      EasyLoading.showError("Error: ${error.message}");
    } catch (error) {
      log("Error @ getCounsellorById => $error");
      EasyLoading.showError("Error => $error");
    }
    return false;
  }
}
