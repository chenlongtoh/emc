import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/screens/counsellor/counsellor_schedule/ui/widget/schedule.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../constant.dart';

class SchedulePage extends StatefulWidget {
  @override
  _SchedulePageState createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime _focusedDay;
  DateTime _selectedDay;
  List<_DeliveryProcess> _processess = [];

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    _processess = [
      _DeliveryProcess(
        '09:00',
        messages: [
          _DeliveryMessage('8:30am', 'Package received by driver'),
          _DeliveryMessage('11:30am', 'Reached halfway mark'),
        ],
      ),
      _DeliveryProcess(
        '10:00',
        messages: [
          _DeliveryMessage('13:00pm', 'Driver arrived at destination'),
          _DeliveryMessage('11:35am', 'Package delivered by m.vassiliades'),
        ],
      ),
      _DeliveryProcess(
        '11:00',
        messages: [
          _DeliveryMessage('8:30am', 'Package received by driver'),
          _DeliveryMessage('11:30am', 'Reached halfway mark'),
        ],
      ),
      _DeliveryProcess(
        '12:00',
        messages: [
          _DeliveryMessage('13:00pm', 'Driver arrived at destination'),
          _DeliveryMessage('11:35am', 'Package delivered by m.vassiliades'),
        ],
      ),
      _DeliveryProcess(
        '13:00',
        messages: [
          _DeliveryMessage('8:30am', 'Package received by driver'),
          _DeliveryMessage('11:30am', 'Reached halfway mark'),
        ],
      ),
      _DeliveryProcess(
        'In Transit',
        messages: [
          _DeliveryMessage('13:00pm', 'Driver arrived at destination'),
          _DeliveryMessage('11:35am', 'Package delivered by m.vassiliades'),
        ],
      ),
      _DeliveryProcess(
        'Package Process',
        messages: [
          _DeliveryMessage('8:30am', 'Package received by driver'),
          _DeliveryMessage('11:30am', 'Reached halfway mark'),
        ],
      ),
      _DeliveryProcess(
        'In Transit',
        messages: [
          _DeliveryMessage('13:00pm', 'Driver arrived at destination'),
          _DeliveryMessage('11:35am', 'Package delivered by m.vassiliades'),
        ],
      ),
      _DeliveryProcess.complete(),
    ];
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
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                Schedule(
                  processes: _processess,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeliveryProcess {
  const _DeliveryProcess(
    this.name, {
    this.messages = const [],
  });

  const _DeliveryProcess.complete()
      : this.name = 'Done',
        this.messages = const [];

  final String name;
  final List<_DeliveryMessage> messages;

  bool get isCompleted => name == 'Done';
}

class _DeliveryMessage {
  const _DeliveryMessage(this.createdAt, this.message);

  final String createdAt; // final DateTime createdAt;
  final String message;

  @override
  String toString() {
    return '$createdAt $message';
  }
}

