import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/constant.dart';
import 'package:emc/screens/student/appointment/model/view_model/appointment_model.dart';
import 'package:emc/screens/student/appointment/ui/page/appointment_tab.dart';
import 'package:emc/screens/student/appointment/ui/widgets/accepted_appointment_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'counsellor_list_page.dart';

class Appointment extends StatefulWidget {
  @override
  _AppointmentState createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  AppointmentModel _model;
  AuthModel authModel;

  @override
  void initState() {
    super.initState();
    authModel = Provider.of(context, listen: false);
    _model = new AppointmentModel(authModel: authModel);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _model.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: EmcScaffold(
        appBar: AppBar(
          title: Text('Appointments'),
          bottom: TabBar(
            isScrollable: true,
            tabs: [
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.2),
                child: Tab(text: "Accepted"),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.2),
                child: Tab(text: "Pending"),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(minWidth: MediaQuery.of(context).size.width * 0.2),
                child: Tab(text: "Rejected/Expired"),
              ),
            ],
          ),
        ),
        body: ChangeNotifierProvider.value(
          value: _model,
          builder: (context, child) => child,
          child: TabBarView(
            children: [
              AppointmentTab.accepted(),
              AppointmentTab.pending(),
              AppointmentTab.declined(),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          heroTag: UniqueKey(),
          child: Icon(
            Icons.add,
            color: EmcColors.lightPink,
          ),
          backgroundColor: Colors.white,
          onPressed: () async {
            await Navigator.pushNamed(
              context,
              CounsellorListPage.routeName,
              arguments: CounsellorListPageArgs(appointmentModel: _model),
            );
            _model.init();
          },
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
