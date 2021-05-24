import 'dart:developer';

import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/screens/counsellor/schedule/constant.dart';
import 'package:emc/screens/counsellor/schedule/model/entity/schedule.dart';
import 'package:emc/screens/counsellor/schedule/service/schedule_service.dart';
import 'package:emc/screens/student/appointment/model/entity/appointment.dart';
import 'package:emc/screens/student/appointment/service/appointment_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

enum ScheduleEditMode {
  openSlot,
  blockSlot,
  none,
}

class ScheduleModel with ChangeNotifier {
  final String counsellorId;
  final AuthModel authModel;
  Schedule schedule;
  bool isLoading = false;
  List<String> _slotHolder = [];
  ScheduleEditMode _editMode = ScheduleEditMode.none;

  ScheduleModel({this.authModel, this.counsellorId}) : assert(!authModel.isStudent || counsellorId != null);

  int get slotCount => _slotHolder.length;

  List<String> get slots => _slotHolder;

  void addSlot(dynamic slot) {
    _slotHolder.add((slot is String) ? slot : slot.toString());
    notifyListeners();
  }

  void removeSlot(dynamic slot) {
    String _string = (slot is String) ? slot : slot.toString();
    if (_slotHolder.contains(_string)) {
      _slotHolder.remove(_string);
    }
    notifyListeners();
  }

  void clearSlots() => _slotHolder.clear();

  ScheduleEditMode get editMode => _editMode;

  set editMode(ScheduleEditMode mode) {
    _editMode = mode;
    notifyListeners();
  }

  onDateChanged(DateTime date) async {
    setLoading();
    if (slotCount > 0) {
      this.clearSlots();
    }
    _editMode = ScheduleEditMode.none;

    schedule = await ScheduleService.fetchScheduleByDate(
      date,
      (authModel?.isStudent ?? false) ? counsellorId : authModel.user?.uid,
    );
    if (schedule == null) {
      schedule = new Schedule(
        counsellorId: (authModel?.isStudent ?? false) ? counsellorId : authModel.user?.uid,
        date: date.millisecondsSinceEpoch,
      );
    }
    setIdle();
  }

  Future blockSlots(String message) async {
    EasyLoading.show();
    final Map<String, dynamic> _newBlockedSlots = Map.fromIterable(_slotHolder, key: (index) => index, value: (_) => message ?? "-");
    final Map<String, dynamic> tmpBlockedSlot = schedule?.blockedSlot ?? {};
    tmpBlockedSlot.addAll(_newBlockedSlots);
    bool success = false;
    if (schedule?.docId == null) {
      Schedule _tmpSchedule = Schedule.copyFrom(schedule);
      _tmpSchedule.blockedSlot = tmpBlockedSlot;
      final String scheduleId = await ScheduleService.createSchedule(_tmpSchedule.toJson());
      if (scheduleId != null) {
        success = true;
        _tmpSchedule.docId = scheduleId;
        schedule = _tmpSchedule;
      }
    } else {
      success = await ScheduleService.blockSlots(schedule?.docId, tmpBlockedSlot, message);
    }
    if (success) {
      schedule.blockedSlot = tmpBlockedSlot;
      this.clearSlots();
      this.editMode = ScheduleEditMode.none;
      EasyLoading.showSuccess("Slots are now blocked");
    }
    notifyListeners();
  }

  Future openSlots() async {
    EasyLoading.show();
    final Map<String, dynamic> tmpBlockedSlot = schedule?.blockedSlot ?? {};
    _slotHolder.forEach((key) {
      tmpBlockedSlot.remove(key);
    });
    bool success = false;
    success = await ScheduleService.openSlots(schedule?.docId, tmpBlockedSlot);
    if (success) {
      schedule.blockedSlot = tmpBlockedSlot;
      this.clearSlots();
      this.editMode = ScheduleEditMode.none;
      EasyLoading.showSuccess("Slots are now opened");
    }
    notifyListeners();
  }

  Future bookSlot(String slotIndex) async {
    EasyLoading.show();
    final String uid = authModel.user.uid;
    final Map<String, dynamic> tmpBookedSlot = schedule?.bookedSlot ?? {};
    tmpBookedSlot.addAll({
      slotIndex: {
        "sid": uid,
        "status": "pending",
      }
    });

    final Map<String, dynamic> tmpStudentList = schedule?.studentList ?? {};
    if (!(tmpStudentList?.keys?.contains(uid) ?? false)) {
      tmpStudentList.addAll({
        uid: {
          "name": authModel?.emcUser?.name,
          "profilePicture": authModel?.emcUser?.profilePicture,
          "exist": true,
        }
      });
    }
    bool success = false;
    if (schedule?.docId == null) {
      Schedule _tmpSchedule = Schedule.copyFrom(schedule);
      _tmpSchedule.bookedSlot = tmpBookedSlot;
      _tmpSchedule.studentList = tmpStudentList;
      final String scheduleId = await ScheduleService.createSchedule(_tmpSchedule.toJson());
      if (scheduleId != null) {
        success = true;
        _tmpSchedule.docId = scheduleId;
      }
    } else {
      Map<String, dynamic> data = {
        "bookedSlot": tmpBookedSlot,
        "studentList": tmpStudentList,
      };
      success = await ScheduleService.bookSlot(schedule?.docId, data);
    }
    if (success) {
      final Map<String, dynamic> studentData = {
        "name": authModel?.emcUser?.name ?? "",
        "profilePicture": authModel?.emcUser?.profilePicture ?? "",
        "sid": authModel?.user?.uid,
      };

      final EmcUser counsellor = await ScheduleService.getCounsellorById(counsellorId);
      final String hourStr = SCHEDULE_LABELS[int.parse(slotIndex)].split(":")[0];
      int hour = int.parse(hourStr);
      if (hour <= 5) hour += 12;
      final DateTime scheduleDate = DateTime.fromMillisecondsSinceEpoch(schedule.date);
      final DateTime startDate = DateTime(scheduleDate.year, scheduleDate.month, scheduleDate.day, hour);
      final DateTime endDate = DateTime(scheduleDate.year, scheduleDate.month, scheduleDate.day, hour + 1);
      final Map<String, dynamic> appointmentData = {
        "counsellor": {
          "cid": counsellorId,
          "name": counsellor.name,
          "profilePicture": counsellor.profilePicture,
          "qualification": counsellor.qualification,
        },
        "startTime": startDate.millisecondsSinceEpoch,
        "endTime": endDate.millisecondsSinceEpoch,
        "status": "pending",
        "student": studentData,
      };
      await AppointmentService.insertAppointment(appointmentData);
      schedule.bookedSlot = tmpBookedSlot;
      this.clearSlots();
      this.editMode = ScheduleEditMode.none;
      EasyLoading.showSuccess("Slots Booked Successfully");
    }
    notifyListeners();
  }

  bool get isTodayOrAfter {
    final DateTime now = DateTime.now();
    final DateTime scheduleDate = DateTime.fromMillisecondsSinceEpoch(schedule.date);
    return (scheduleDate.day == now.day || this.isAfterToday);
  }

  bool get isAfterToday {
    final DateTime now = DateTime.now();
    final DateTime scheduleDate = DateTime.fromMillisecondsSinceEpoch(schedule.date);
    if (scheduleDate.year < now.year) return false;
    if (scheduleDate.year > now.year) return true;
    if (scheduleDate.month > now.month) return true;
    if (scheduleDate.month < now.month) return false;
    if (scheduleDate.day > now.day) return true;
    return false;
  }

  setLoading() {
    isLoading = true;
    notifyListeners();
  }

  setIdle() {
    isLoading = false;
    notifyListeners();
  }
}
