import 'package:emc/screens/counsellor/counsellor_profile.dart';
import 'package:emc/screens/student/appointment/index.dart';
import 'package:flutter/material.dart';
import 'package:emc/screens/student/emotion_entry/index.dart';
import 'package:emc/screens/student/connection/index.dart';

class StudentHome extends StatefulWidget {
  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  static final _pageList = [
    EmotionEntry(),
    Connection(),
    CounsellorProfile(), // temp
    Appointment(),
  ];

  int _selectedIndex = 3;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: _pageList[_selectedIndex],
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
                icon: Icon(Icons.message),
                label: 'Chatbot',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.today),
                label: 'History',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        );
  }
}
