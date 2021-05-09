import 'dart:developer';

import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_shimmer.dart';
import 'package:emc/screens/counsellor/schedule/model/view_model/schedule_model.dart';
import 'package:emc/screens/counsellor/schedule/ui/widget/empty_schedule_card.dart';
import 'package:emc/screens/counsellor/schedule/ui/widget/schedule_card.dart';
import 'package:emc/util/form_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';
import 'line.dart';

class Schedule extends StatelessWidget {
  final bool allowMakeAppointment;
  Schedule({this.allowMakeAppointment = false});

  final GlobalKey<FormBuilderState> _fbKey = new GlobalKey<FormBuilderState>();

  bool _timeAvailable(ScheduleModel model, String index) {
    if(model.isAfterToday) return true;
    try {
      final int indexInt = int.parse(index);
      final String timeStr = SCHEDULE_LABELS[indexInt].split(":")[0];
      int timeStrInt = int.parse(timeStr);
      if (timeStrInt <= 5) timeStrInt += 12;
      DateTime now = DateTime.now();
      return timeStrInt > now.hour;
    } catch (error) {
      log("Parsing Exception:: error => $error");
    }
    return false;
  }

  void _onBookSlot(BuildContext context, ScheduleModel model, String index) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Slot Booking Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Book this slot with the cousellor?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () async {
                await model.bookSlot(index);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onOpenBlockButtonPressed(BuildContext context, ScheduleModel model) async {
    if (model.slotCount > 0) {
      if (model?.editMode == ScheduleEditMode.blockSlot) {
        return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Block Notes'),
              content: SingleChildScrollView(
                child: FormBuilder(
                  key: _fbKey,
                  child: FormBuilderTextField(
                    decoration: InputDecoration(
                      hintText: "Eg: Reason for blocking slot",
                    ),
                    validator: FormBuilderValidators.compose(
                      [FormBuilderValidators.required(context)],
                    ),
                    name: "blockNotes",
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text("Cancel"),
                  onPressed: () => Navigator.pop(context),
                ),
                TextButton(
                  child: Text('Save'),
                  onPressed: () async {
                    if (_fbKey.currentState.saveAndValidate()) {
                      final String message = FormUtil.getFormValue(_fbKey, "blockNotes");
                      await model?.blockSlots(message);
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            );
          },
        );
      } else if (model?.editMode == ScheduleEditMode.openSlot) {
        return showDialog<void>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Confirmation'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('Would you like to open up the selected time slots?'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text('Confirm'),
                  onPressed: () async {
                    await model.openSlots();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  Widget _getScheduleCard(BuildContext context, ScheduleModel model, AuthModel authModel, String index) {
    if (model.schedule?.bookedSlot?.containsKey(index) ?? false) {
      final Map bookingData = (model.schedule?.bookedSlot[index] ?? const {});
      final String sid = bookingData["sid"];
      final String status = bookingData["status"];
      final Map studentData = (model.schedule?.studentList ?? const {})[sid] ?? const {};
      return ScheduleCard(
        status: ScheduleStatus.booked,
        studentProfilePicture: studentData["profilePicture"],
        studentName: studentData["name"],
        disabled: model?.editMode != ScheduleEditMode.none,
        shouldMaskDetails: authModel.isStudent,
        bookedBySelf: sid == authModel?.user?.uid,
        isPending: status == "pending",
      );
    } else if (model.schedule?.blockedSlot?.containsKey(index) ?? false) {
      return model?.editMode == ScheduleEditMode.openSlot
          ? GestureDetector(
              onTap: () => (model?.slots?.contains(index) ?? false) ? model?.removeSlot(index) : model?.addSlot(index),
              child: ScheduleCard(
                status: ScheduleStatus.blocked,
                message: model.schedule.blockedSlot[index],
                disabled: false,
                selected: model?.slots?.contains(index) ?? false,
              ),
            )
          : ScheduleCard(
              status: ScheduleStatus.blocked,
              message: model.schedule.blockedSlot[index],
              disabled: model?.editMode == ScheduleEditMode.blockSlot,
            );
    }
    if (authModel.isStudent && model.isTodayOrAfter && (allowMakeAppointment ?? false) && _timeAvailable(model, index)) {
      return GestureDetector(
        onTap: () => _onBookSlot(context, model, index),
        child: EmptyScheduleCard(
          text: "Tap to Make an Appointment",
          onSelectColor: Colors.green[400],
        ),
      );
    } else if (model?.editMode == ScheduleEditMode.blockSlot) {
      return GestureDetector(
        onTap: () => (model?.slots?.contains(index) ?? false) ? model?.removeSlot(index) : model?.addSlot(index),
        child: EmptyScheduleCard(
          selected: model?.slots?.contains(index) ?? false,
          text: "Open Slot",
          onSelectColor: Colors.red,
        ),
      );
    } else {
      return SizedBox(
        height: CARD_HEIGHT,
        width: CARD_WIDTH,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<ScheduleModel, AuthModel>(
      builder: (context, model, authModel, child) {
        if (model.isLoading) {
          return EmcShimmerList();
        }
        return Stack(
          children: [
            ListView.builder(
              cacheExtent: MediaQuery.of(context).size.height,
              physics: new BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(40, 10, 40, 50),
              itemCount: 8,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      SCHEDULE_LABELS[index],
                      style: DefaultTextStyle.of(context).style.copyWith(
                            fontSize: 18.0,
                          ),
                    ),
                    if (index != 7)
                      Row(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 50,
                            child: CustomPaint(
                              painter: Line(),
                            ),
                          ),
                          SizedBox(width: 30),
                          _getScheduleCard(context, model, authModel, index.toString()),
                        ],
                      ),
                  ],
                );
              },
            ),
            if (!authModel.isStudent && model.isTodayOrAfter)
              Align(
                alignment: Alignment.bottomCenter,
                child: model?.editMode == ScheduleEditMode.none
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => model?.editMode = ScheduleEditMode.openSlot,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Open Slots",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: Colors.green),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            ),
                          ),
                          SizedBox(width: 15),
                          TextButton(
                            onPressed: () => model?.editMode = ScheduleEditMode.blockSlot,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                "Block Slots",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  side: BorderSide(color: Colors.red),
                                ),
                              ),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            ),
                          ),
                        ],
                      )
                    : Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () {
                              model.clearSlots();
                              model?.editMode = ScheduleEditMode.none;
                            },
                            icon: Icon(Icons.close),
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                        SizedBox(width: 10),
                        TextButton(
                          onPressed: () => _onOpenBlockButtonPressed(context, model),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "${model?.editMode == ScheduleEditMode.openSlot ? "Open" : "Block "} (${model?.slotCount ?? '-'})",
                              style: TextStyle(
                                color: model?.editMode == ScheduleEditMode.openSlot ? Colors.green : Colors.red,
                              ),
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: model?.editMode == ScheduleEditMode.openSlot ? Colors.green : Colors.red,
                                ),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          ),
                        ),
                      ]),
              ),
          ],
        );
      },
    );
  }
}
