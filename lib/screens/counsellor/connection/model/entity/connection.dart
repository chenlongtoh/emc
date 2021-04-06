
import 'connected_student.dart';

class Connection {
  String connectionId;
  num date;
  String message;
  String status;
  ConnectedStudent connectedStudent;

  Connection({this.connectionId, this.date, this.message, this.status, this.connectedStudent});

  Connection.fromJson(Map<String, dynamic> json) {
    connectionId = json['connectionId'];
    date = json['date'];
    message = json['message'];
    status = json['status'];
    connectedStudent = ConnectedStudent.fromJson(json['student']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['connectionId'] = this.connectionId;
    data['date'] = this.date;
    data['message'] = this.message;
    data['status'] = this.status;
    data['student'] = this.connectedStudent.toJson();
    return data;
  }
}
