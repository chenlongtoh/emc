import 'package:emc/screens/student/connection/model/entity/connected_counsellor.dart';

class Connection {
  String counsellorId;
  String date;
  String message;
  String status;
  ConnectedCounsellor connectedCounsellor;

  Connection({this.counsellorId, this.date, this.message, this.status, this.connectedCounsellor});

  Connection.fromJson(Map<String, dynamic> json) {
    counsellorId = json['counsellorId'];
    date = json['date'];
    message = json['message'];
    status = json['status'];
    connectedCounsellor = ConnectedCounsellor.fromJson(json['counsellor']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counsellorId'] = this.counsellorId;
    data['date'] = this.date;
    data['message'] = this.message;
    data['status'] = this.status;
    data['counsellor'] = this.connectedCounsellor.toJson();
    return data;
  }
}
