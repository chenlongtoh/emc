class Appointment {
  Counsellor counsellor;
  num endTime;
  String scheduleId;
  num startTime;
  String status;
  Student student;

  Appointment({
    this.counsellor,
    this.endTime,
    this.scheduleId,
    this.startTime,
    this.status,
    this.student,
  });

  Appointment.fromJson(Map<String, dynamic> json) {
    counsellor = json['counsellor'] != null ? new Counsellor.fromJson(json['counsellor']) : null;
    endTime = json['endTime'];
    scheduleId = json['scheduleId'];
    startTime = json['startTime'];
    status = json['status'];
    student = json['student'] != null ? new Student.fromJson(json['student']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.counsellor != null) {
      data['counsellor'] = this.counsellor.toJson();
    }
    data['endTime'] = this.endTime;
    data['scheduleId'] = this.scheduleId;
    data['startTime'] = this.startTime;
    data['status'] = this.status;
    if (this.student != null) {
      data['student'] = this.student.toJson();
    }
    return data;
  }
}

class Counsellor {
  String cid;
  String name;
  String profilePicture;
  String qualification;

  Counsellor({
    this.cid,
    this.name,
    this.profilePicture,
    this.qualification,
  });

  Counsellor.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    name = json['name'];
    profilePicture = json['profilePicture'];
    qualification = json['qualification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    data['qualification'] = this.qualification;
    return data;
  }
}

class Student {
  String sid;
  String name;
  String profilePicture;

  Student({
    this.sid,
    this.name,
    this.profilePicture,
  });

  Student.fromJson(Map<String, dynamic> json) {
    sid = json['sid'];
    name = json['name'];
    profilePicture = json['profilePicture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sid'] = this.sid;
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    return data;
  }
}
