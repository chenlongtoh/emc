import 'package:flutter/material.dart';
import 'package:emc/screens/student/appointment/index.dart';
import 'package:emc/screens/student/emotion_entry/index.dart';
import 'package:emc/screens/student/connection/index.dart';
import 'chatbot/ui/page/chatbot_page.dart';
import 'emotion_history/ui/page/emotion_history.dart';

class StudentHome extends StatefulWidget {
  static const String routeName = "/studentHome";
  @override
  _StudentHomeState createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  static final _pageList = [
    EmotionEntry(),
    ConnectionPage(),
    Appointment(),
    ChatbotPage(),
    EmotionHistory(),
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
      body: IndexedStack(
        children: _pageList,
        index: _currentIndex
      ),
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
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
