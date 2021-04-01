import 'package:flutter/material.dart';

import 'counsellor_appointment/ui/page/counsellor_appointment_page.dart';
import 'counsellor_connection/ui/page/counsellor_connection_page.dart';
import 'counsellor_home/ui/page/counsellor_home.dart';
import 'counsellor_schedule/ui/page/schedule_page.dart';

class CounsellorHome extends StatefulWidget {
  @override
  _CounsellorHomeState createState() => _CounsellorHomeState();
}

class _CounsellorHomeState extends State<CounsellorHome> {
  static final _pageList = [
    CounsellorHomePage(),
    CounsellorConnectionPage(),
    CounsellorAppointmentPage(),
    SchedulePage(),
  ];

  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(children: _pageList, index: _currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.link),
            label: 'Connection',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event_available),
            label: 'Appointment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: 'History',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
