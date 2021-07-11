import 'package:emc/screens/counsellor/profile/ui/page/counsellor_profile.dart';
import 'package:flutter/material.dart';

import 'appointment/ui/page/appointment_page.dart';
import 'connection/ui/page/connection_page.dart';
import 'home/ui/page/counsellor_home.dart';
import 'schedule/ui/page/schedule_page.dart';

class CounsellorHome extends StatefulWidget {
  @override
  _CounsellorHomeState createState() => _CounsellorHomeState();
}

class _CounsellorHomeState extends State<CounsellorHome> {
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
        children: [
          CounsellorHomePage(
            navigateToConnection: () => _onItemTapped(1),
            navigateToAppointment: () => _onItemTapped(2),
          ),
          ConnectionPage(),
          AppointmentPage(),
          SchedulePage(),
          CounsellorProfile(),
        ],
        index: _currentIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
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
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
