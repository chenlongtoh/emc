import 'package:emc/common_widget/emc_button.dart';
import 'package:emc/constant.dart';
import 'package:emc/screens/student/connection/ui/widgets/lecturer_item.dart';
import 'package:flutter/material.dart';
import 'package:emc/common_widget/emc_scaffold.dart';

class Connection extends StatefulWidget {
  @override
  _ConnectionState createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      appBar: AppBar(
        title: Text("Connections"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [LecturerItem(), SizedBox(height: 5), LecturerItem()],
        ),
      ),
      floatingActionButton: FloatingActionButton(
      child: Icon(
        Icons.add,
        color: EmcColors.lightPink,
      ),
      backgroundColor: Colors.white,
      onPressed: () => null,
      shape: CircleBorder(
        side: BorderSide(
          color: EmcColors.lightPink,
          width: 1.0,
        ),
      ),
    ),
    );
  }
}
