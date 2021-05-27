import 'dart:developer';

import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/common_widget/emc_shimmer.dart';
import 'package:emc/screens/counsellor/appointment/model/entity/appointment.dart';
import 'package:emc/screens/counsellor/appointment/model/view_model/appointment_model.dart';
import 'package:emc/screens/counsellor/appointment/ui/widget/appointment_details_card.dart';
import 'package:emc/screens/counsellor/appointment/ui/widget/upcoming_appointment_card.dart';
import 'package:emc/screens/counsellor/home/ui/widget/appointment_connection_summary_card.dart';
import 'package:emc/util/form_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class AppointmentPage extends StatefulWidget {
  @override
  _AppointmentPageState createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  AppointmentModel _model;
  RefreshController _refreshController;
  GlobalKey<FormBuilderState> _fbKey = new GlobalKey<FormBuilderState>();

  @override
  void initState() {
    super.initState();
    final AuthModel authModel = Provider.of<AuthModel>(context, listen: false);
    _model = new AppointmentModel(authModel: authModel);
    _refreshController = new RefreshController(initialRefresh: false);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _model.init();
    });
  }

  void _onRefresh() async {
    await _model?.init();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  void _onDeclineConnection(AppointmentModel model, Appointment appointment) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Decline Message'),
          content: SingleChildScrollView(
            child: FormBuilder(
              key: _fbKey,
              child: FormBuilderTextField(
                decoration: InputDecoration(
                  hintText: "Optional",
                ),
                name: "declineMessage",
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () async {
                _fbKey.currentState.saveAndValidate();
                final String message = FormUtil.getFormValue(_fbKey, "declineMessage");
                await model.declineAppointment(appointment, message);
                setState(() {});
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _model,
      child: EmcScaffold(
        appBar: AppBar(
          title: Text(
            "Appointments",
          ),
        ),
        body: SmartRefresher(
          controller: _refreshController,
          onRefresh: _onRefresh,
          enablePullDown: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  "Request(s)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10),
              LimitedBox(
                maxHeight: 200,
                child: Center(
                  child: Consumer<AppointmentModel>(
                    builder: (context, model, child) {
                      if (model.isLoading) return EmcShimmerList();
                      List<Appointment> pendingAppointmentList = model.pendingAppointmentList;

                      return pendingAppointmentList.length == 0
                          ? Text("No Pending Request Found")
                          : ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              itemCount: pendingAppointmentList.length,
                              separatorBuilder: (_, __) => SizedBox(width: 20),
                              itemBuilder: (context, index) {
                                return AppointmentDetailsCard(
                                  appointment: pendingAppointmentList[index],
                                  onAccept: () => model.acceptAppointment(pendingAppointmentList[index]?.appointmentId),
                                  onDecline: () => _onDeclineConnection(model, pendingAppointmentList[index]),
                                );
                              },
                            );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Text(
                  "Upcoming Appointment(s)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Flexible(
                child: Consumer<AppointmentModel>(
                  builder: (context, model, child) {
                    if (model.isLoading) return EmcShimmerList();
                    List<Appointment> upcomingAppointmentList = model.upcomingAppointmentList;

                    return upcomingAppointmentList.length == 0
                        ? Center(child: Text("No Upcoming Appointment Found"))
                        : ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            itemCount: upcomingAppointmentList.length,
                            separatorBuilder: (_, __) => SizedBox(height: 10),
                            itemBuilder: (context, index) {
                              return UpcomingAppointmentCard(
                                appointment: upcomingAppointmentList[index],
                              );
                            },
                          );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
