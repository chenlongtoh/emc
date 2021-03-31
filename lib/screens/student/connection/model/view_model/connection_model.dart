import 'package:emc/screens/student/connection/model/entity/connection.dart';
import 'package:emc/screens/student/connection/service/connection_service.dart';
import 'package:flutter/cupertino.dart';


class ConnectionModel {
  @required
  final String uid;
  ConnectionModel({this.uid}):assert(uid != null);

  Future<List<Connection>> fetchConnections() async{
    List<Connection> connectionList = await ConnectionService.fetchConnectionByUid(uid);
    return connectionList;
  }
}