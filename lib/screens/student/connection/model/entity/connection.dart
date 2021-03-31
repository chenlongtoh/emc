import 'package:emc/screens/student/connection/model/entity/connected_counsellor.dart';

class Connection {
  String counsellorId;
  String date;
  String message;
  bool connected;
  ConnectedCounsellor connectedCounsellor;

  Connection({this.counsellorId, this.date, this.message, this.connected, this.connectedCounsellor});

  Connection.fromJson(Map<String, dynamic> json) {
    counsellorId = json['counsellorId'];
    date = json['date'];
    message = json['message'];
    connected = json['connected'];
    connectedCounsellor = ConnectedCounsellor.fromJson(json['counsellor']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['counsellorId'] = this.counsellorId;
    data['date'] = this.date;
    data['message'] = this.message;
    data['connected'] = this.connected;
    data['counsellor'] = this.connectedCounsellor.toJson();
    return data;
  }
}
