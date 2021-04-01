import 'dart:developer';

import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_shimmer.dart';
import 'package:emc/constant.dart';
import 'package:emc/screens/counsellor/counsellor_profile/ui/page/counsellor_profile.dart';
import 'package:emc/screens/student/connection/model/entity/connection.dart';
import 'package:emc/screens/student/connection/model/view_model/connection_model.dart';
import 'package:emc/screens/student/connection/ui/widgets/lecturer_item.dart';
import 'package:emc/util/router.dart';
import 'package:flutter/material.dart';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ConnectionPage extends StatefulWidget {
  @override
  _ConnectionPageState createState() => _ConnectionPageState();
}

class _ConnectionPageState extends State<ConnectionPage> {
  ConnectionModel _connectionModel;
  RefreshController _refreshController;
  Future<List<Connection>> _connections;

  void _onRefresh() async {
    _connections = _connectionModel.fetchConnections();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    final authModel = Provider.of<AuthModel>(context, listen: false);
    _connectionModel = new ConnectionModel(uid: authModel?.user?.uid);
    _refreshController = new RefreshController(initialRefresh: false);
    _connections = _connectionModel.fetchConnections();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _connections,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          final bool dataReady = snapshot?.data != null && (snapshot.data is List && !snapshot.data.isEmpty);
          if (dataReady) {
            final List<Connection> connectionList = snapshot.data;
            return EmcScaffold(
              appBar: AppBar(
                title: Text("Connections"),
              ),
              body: SmartRefresher(
                controller: _refreshController,
                onRefresh: _onRefresh,
                enablePullDown: true,
                child: ListView.separated(
                  separatorBuilder: (_, __) => SizedBox(height: 5),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  itemCount: connectionList.length,
                  itemBuilder: (context, index) {
                    final connection = connectionList[index];
                    final bool connected = connection?.status == "connected";
                    return LecturerItem(
                      imageUri: connection?.connectedCounsellor?.profilePicture,
                      name: connection?.connectedCounsellor?.name ?? "-",
                      qualification: connection?.connectedCounsellor?.qualification ?? "-",
                      trailingWidget: Text(
                        !connected ? "Connected" : "Pending",
                        style: !connected
                            ? TextStyle(
                                color: Colors.green,
                              )
                            : null,
                      ),
                      onTap: () => Navigator.pushNamed(
                        context,
                        CounsellorProfile.routeName,
                        arguments: new CounsellorProfilePageArgs(
                          counsellorId: connection?.connectedCounsellor?.cid,
                        ),
                      ),
                    );
                  },
                ),
              ),
              floatingActionButton: FloatingActionButton(
                heroTag: UniqueKey(),
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
          } else {
            return Center(
              child: Text("No Connections Found"),
            );
          }
        }
        return EmcScaffold(
          appBar: AppBar(
            title: Text("Connections"),
          ),
          body: EmcShimmerList(),
        );
      },
    );
  }
}
