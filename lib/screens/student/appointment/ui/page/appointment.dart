import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/constant.dart';
import 'package:emc/screens/student/appointment/ui/widgets/accepted_appointment_item.dart';
import 'package:flutter/material.dart';

class Appointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: EmcScaffold(
        appBar: AppBar(
          title: Text('Appointments'),
          bottom: TabBar(
            tabs: [
              Tab(text: "Accepted"),
              Tab(text: "Pending"),
              Tab(text: "Rejected"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                children: [AcceptedItem(), SizedBox(height: 5), AcceptedItem()],
              ),
            ),
            Center(child: Text("Pending")),
            Center(child: Text("Rejected")),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: EmcColors.lightPink,
          ),
          backgroundColor: Colors.white,
          onPressed: () => NullThrownError,
          shape: CircleBorder(
            side: BorderSide(
              color: EmcColors.lightPink,
              width: 1.0,
            ),
          ),
        ),
      ),
    );
  }
}
