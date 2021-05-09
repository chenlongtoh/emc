import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/screens/student/connection/model/entity/connection.dart';
import 'package:emc/screens/student/connection/service/connection_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ConnectionModel {
  @required
  final AuthModel authModel;
  List<Connection> connectionList;

  ConnectionModel({this.authModel}) : assert(authModel != null);

  Future<List<Connection>> fetchConnections() async {
    connectionList = await ConnectionService.fetchConnectionByUid(authModel?.user?.uid ?? "");
    return connectionList;
  }

  Future<List<EmcUser>> getNonConnectedCounsellors() async {
    return await ConnectionService.getCounsellorsExcept(
      connectionList == null || connectionList.length == 0
          ? null
          : connectionList.map((connection) => connection?.connectedCounsellor?.cid ?? "").toList(),
    );
  }

  Future connectToCounsellor(EmcUser counsellor) async {
    EasyLoading.show();
    Map<String, dynamic> data = {
      "counsellor": {
        "cid": counsellor?.uid ?? "-",
        "name": counsellor?.name ?? "-",
        "profilePicture": counsellor?.profilePicture,
        "qualification": counsellor?.qualification ?? "-",
      },
      "date": DateTime.now().millisecondsSinceEpoch,
      "status": "pending",
      "student": {
        "sid": authModel?.user?.uid ?? "-",
        "name": authModel?.emcUser?.name ?? "-",
        "profilePicture": authModel?.emcUser?.profilePicture,
      }
    };
    bool success = await ConnectionService.createConnection(data);
    success
        ? EasyLoading.showSuccess("Connection Added Successfully")
        : EasyLoading.showError("Error occured while making a connection to the counsellor, please try again later");
    return success;
  }
}
