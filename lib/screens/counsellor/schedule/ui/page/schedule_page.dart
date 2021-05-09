import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/screens/counsellor/schedule/model/view_model/schedule_model.dart';
import 'package:emc/screens/counsellor/schedule/ui/widget/schedule.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class SchedulePageArgs {
  final String counsellorId;
  final bool allowMakeAppointment;
  SchedulePageArgs({this.counsellorId, this.allowMakeAppointment = false});
}

class SchedulePage extends StatefulWidget {
  static const routeName = "/schedulePage";
  final SchedulePageArgs args;
  SchedulePage({this.args});

  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  ScheduleModel _model;
  DateTime _focusedDay;
  DateTime _selectedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    final AuthModel authModel = Provider.of<AuthModel>(context, listen: false);
    _model = new ScheduleModel(authModel: authModel, counsellorId: widget.args?.counsellorId);
    _model.onDateChanged(_selectedDay);
  }

  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      appBar: AppBar(
        title: Text(
          "Schedule",
        ),
      ),
      body: Column(
        children: [
          TableCalendar(
            headerStyle: HeaderStyle(formatButtonVisible: false),
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(DateTime.now().year, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.twoWeeks,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              if (!isSameDay(_selectedDay, selectedDay)) {
                _model.onDateChanged(selectedDay);
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Expanded(
            child: ChangeNotifierProvider.value(
              value: _model,
              builder: (context, child) {
                return Schedule(allowMakeAppointment: widget.args?.allowMakeAppointment);
              },
            ),
          ),
        ],
      ),
    );
  }
}
