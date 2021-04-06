import 'dart:developer';

import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/screens/counsellor/schedule/model/entity/schedule.dart';
import 'package:emc/screens/counsellor/schedule/service/schedule_service.dart';
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
        counsellorId: authModel?.user?.uid ?? "-",
        date: date.millisecondsSinceEpoch,
      );
    }
    log("prolly has data => $schedule");
    log("schedule => $schedule");
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
      success = await ScheduleService.createSchedule(_tmpSchedule.toJson());
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
    bool success = await ScheduleService.openSlots(schedule?.docId, tmpBlockedSlot);
    if (success) {
      schedule.blockedSlot = tmpBlockedSlot;
      this.clearSlots();
      this.editMode = ScheduleEditMode.none;
      EasyLoading.showSuccess("Slots are now opened");
    }
    notifyListeners();
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
