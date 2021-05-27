import 'dart:convert';
import 'dart:developer';

import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/common_widget/emc_shimmer.dart';
import 'package:emc/screens/counsellor/connection/model/view_model/connection_model.dart';
import 'package:emc/screens/counsellor/connection/ui/widget/connected_student_card.dart';
import 'package:emc/screens/counsellor/connection/ui/widget/connection_details_card.dart';
import 'package:emc/screens/counsellor/connection/model/entity/connection.dart';
import 'package:emc/screens/student/profile/ui/student_profile.dart';
import 'package:emc/util/form_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      appBar: AppBar(
        title: Text(
          "Connections",
        ),
      ),
      body: ConnectionBody(),
    );
  }
}

class ConnectionBody extends StatefulWidget {
  @override
  _ConnectionBodyState createState() => _ConnectionBodyState();
}

class _ConnectionBodyState extends State<ConnectionBody> {
  final GlobalKey<FormBuilderState> _fbKey = new GlobalKey<FormBuilderState>();

  ConnectionModel model;
  RefreshController _refreshController;
  Future _connection;

  void _onRefresh() async {
    _connection = model.getConnections();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    final authModel = Provider.of<AuthModel>(context, listen: false);
    model = new ConnectionModel(authModel: authModel);
    _refreshController = new RefreshController(initialRefresh: false);
    _connection = model.getConnections();
  }

  Future<void> _onAcceptConnection(Connection connection) async {
    if (connection?.connectionId?.isEmpty ?? true) return;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirmation'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Would you like to connect to this student?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () async {
                await model.confirmConection(connection.connectionId);
                _connection = model.getConnections();
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _onDeclineConnection(Connection connection) async {
    if (connection?.connectionId?.isEmpty ?? true ) return;
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
                await model.declineConnection(connection.connectionId, message, connection.connectedStudent?.sid);
                _connection = model.getConnections();
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
    return FutureBuilder(
        future: _connection,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final bool dataReady = snapshot.data != null && snapshot.data is List && snapshot.data.length > 0;
            if (dataReady) {
              final List<Connection> allConnection = snapshot.data;
              final List<Connection> connectionRequestList = allConnection.where((connection) => connection.status == "pending").toList();
              final List<Connection> connectedConnectionList = allConnection.where((connection) => connection.status == "connected").toList();
              return SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                enablePullDown: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
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
                          Flexible(
                            child: connectionRequestList.isEmpty
                                ? Center(child: Text("No Connection Request Found"))
                                : ListView.separated(
                                    physics: BouncingScrollPhysics(),
                                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                    scrollDirection: Axis.horizontal,
                                    separatorBuilder: (_, __) => SizedBox(width: 20),
                                    itemCount: connectionRequestList.length,
                                    itemBuilder: (context, index) {
                                      final Connection connection = connectionRequestList[index];
                                      return ConnectionDetailsCard(
                                        connection: connection,
                                        onAccept: () async => _onAcceptConnection(connection),
                                        onDecline: () async => _onDeclineConnection(connection),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, bottom: 15),
                            child: Text(
                              "Connected Student(s)",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Flexible(
                            child: connectedConnectionList.isEmpty
                                ? Center(
                                    child: Text("No Connected Students Found"),
                                  )
                                : ListView.separated(
                                    padding: const EdgeInsets.only(top: 15, left: 20, right:20),
                                    physics: BouncingScrollPhysics(),
                                    separatorBuilder: (_, __) => SizedBox(height: 10),
                                    itemCount: connectedConnectionList.length,
                                    itemBuilder: (context, index) {
                                      final Connection connection = connectedConnectionList[index];
                                      return ConnectedStudentCard(
                                        connectedTimestamp: connection?.date,
                                        imageUri: connection?.connectedStudent?.profilePicture,
                                        name: connection?.connectedStudent?.name,
                                        onIconTap: () => Navigator.pushNamed(
                                          context,
                                          StudentProfile.routeName,
                                          arguments: StudentProfilePageArgs(
                                            studentId: connection?.connectedStudent?.sid,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Center(
              child: Text("No Connections Found"),
            );
          }
          return EmcShimmerList();
        });
  }
}
