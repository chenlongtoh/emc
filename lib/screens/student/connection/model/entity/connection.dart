import 'package:emc/screens/student/connection/model/entity/connected_counsellor.dart';

class Connection {
  num date;
  String message;
  String status;
  ConnectedCounsellor connectedCounsellor;

  Connection({this.date, this.message, this.status, this.connectedCounsellor});

  Connection.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    message = json['message'];
    status = json['status'];
    connectedCounsellor = ConnectedCounsellor.fromJson(json['counsellor']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['message'] = this.message;
    data['status'] = this.status;
    data['counsellor'] = this.connectedCounsellor.toJson();
    return data;
  }
}
