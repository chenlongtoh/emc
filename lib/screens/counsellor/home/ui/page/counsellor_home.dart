import 'dart:developer';

import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/common_widget/emc_shimmer.dart';
import 'package:emc/screens/counsellor/appointment/model/entity/appointment.dart';
import 'package:emc/screens/counsellor/connection/model/entity/connection.dart';
import 'package:emc/screens/counsellor/home/service/home_service.dart';
import 'package:emc/screens/counsellor/home/ui/widget/appointment_connection_summary_card.dart';
import 'package:emc/screens/counsellor/profile/ui/page/counsellor_profile.dart';
import 'package:emc/screens/student/emotion_entry/ui/widgets/profile_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../constant.dart';

class CounsellorHomePage extends StatefulWidget {
  final Function navigateToConnection;
  final Function navigateToAppointment;
  CounsellorHomePage({this.navigateToConnection, this.navigateToAppointment});

  @override
  _CounsellorHomePageState createState() => _CounsellorHomePageState();
}

class _CounsellorHomePageState extends State<CounsellorHomePage> {
  AuthModel _authModel;
  RefreshController _refreshController;
  Future _data;

  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController(initialRefresh: false);
    _authModel = Provider.of<AuthModel>(context, listen: false);
    _data = HomeService.getConnectionsAndAppointments(_authModel?.user?.uid);
  }

  void _onRefresh() async {
    _data = HomeService.getConnectionsAndAppointments(_authModel?.user?.uid);
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      appBar: AppBar(
        backgroundColor: EmcColors.whiteOverlay,
        title: Text(
          "Welcome Back!",
          style: TextStyle(
            color: EmcColors.grey,
            fontSize: 15,
          ),
        ),
      ),
      body: FutureBuilder(
          future: _data,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              List data = snapshot.data;
              List<Connection> connectionList = data[0];
              List<Appointment> appointmentList = data[1];

              List<Connection> connectedConnections = connectionList.where((connection) => connection.status == "connected").toList();
              List<Appointment> acceptedAppointments = appointmentList.where((appointment) => appointment.status == "accepted").toList();
              List<Connection> connectionRequests = connectionList.where((connection) => connection.status == "pending").toList();
              List<Appointment> pendingAppointments = appointmentList.where((appointment) => appointment.status == "pending").toList();
              return SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                enablePullDown: true,
                child: ListView(
                  physics: BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        _authModel?.emcUser?.name ?? "N/A",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Appointment(s)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    LimitedBox(
                      maxHeight: 150,
                      child: acceptedAppointments.length == 0
                          ? Center(child: Text("No Appointments Found"))
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              separatorBuilder: (_, __) => SizedBox(width: 20),
                              itemCount: acceptedAppointments.length,
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                Appointment appointment = acceptedAppointments[index];
                                return AppointmentConnectionSummaryCard(
                                  cardType: CardType.appointment,
                                  startDate: appointment.getStartTimeAsDate,
                                  endDate: appointment.getendTimeAsDate,
                                  name: appointment.student.name,
                                  profilePictureUrl: appointment.student.profilePicture,
                                );
                              },
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Appointment Request(s): ${pendingAppointments.length}",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => null,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: widget.navigateToAppointment,
                              child: Text(
                                "Manage Appointment",
                                style: TextStyle(color: Colors.black),
                              ),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Connection(s)",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),
                    LimitedBox(
                      maxHeight: 150,
                      child: connectedConnections.length == 0
                          ? Center(child: Text("No Connections Found"))
                          : ListView.separated(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              separatorBuilder: (_, __) => SizedBox(width: 20),
                              itemCount: connectedConnections.length,
                              itemBuilder: (context, index) {
                                Connection connection = connectedConnections[index];

                                return AppointmentConnectionSummaryCard(
                                  cardType: CardType.connection,
                                  startDate: connection.getDate,
                                  name: connection.connectedStudent.name,
                                  profilePictureUrl: connection.connectedStudent.profilePicture,
                                );
                              },
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        "Connection Request(s): ${connectionRequests.length}",
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () => null,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextButton(
                              onPressed: widget.navigateToConnection,
                              child: Text(
                                "Manage Connection",
                                style: TextStyle(color: Colors.black),
                              ),
                              style: TextButton.styleFrom(
                                padding: const EdgeInsets.all(0),
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                visualDensity: VisualDensity.compact,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
            return EmcShimmerList();
          }),
    );
  }
}
