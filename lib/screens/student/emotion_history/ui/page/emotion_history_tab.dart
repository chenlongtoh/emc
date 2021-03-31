import 'package:flutter/material.dart';
import 'package:emc/screens/student/emotion_history/model/view_model/emotion_history_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:emc/screens/student/emotion_history/ui/widget/history_section.dart';

class EmotionHistoryTab extends StatefulWidget {
  final EmotionHistoryModel emotionHistoryModel;
  EmotionHistoryTab({this.emotionHistoryModel});

  @override
  _EmotionHistoryTabState createState() => _EmotionHistoryTabState();
}

class _EmotionHistoryTabState extends State<EmotionHistoryTab> with AutomaticKeepAliveClientMixin {
  DateTime _focusedDay;
  DateTime _selectedDay;
  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _selectedDay = DateTime.now();
    widget.emotionHistoryModel.setDate(_selectedDay);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
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
                  widget.emotionHistoryModel.setDate(selectedDay);
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          Expanded(
            child: HistorySection(model: widget.emotionHistoryModel),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
