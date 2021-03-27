import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/screens/student/connection/ui/widgets/lecturer_item.dart';
import 'package:flutter/material.dart';

class CounsellorList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      appBar: AppBar(
        title: Text("Select a Counsellor"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          children: [LecturerItem(), SizedBox(height: 5), LecturerItem()],
        ),
      ),
    );
  }
}
