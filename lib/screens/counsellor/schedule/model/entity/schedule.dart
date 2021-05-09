class Schedule {
  String docId;
  Map<String, dynamic> blockedSlot;
  Map<String, dynamic> bookedSlot;
  String counsellorId;
  num date;
  Map<String, dynamic> studentList;

  Schedule({
    this.docId,
    this.blockedSlot,
    this.bookedSlot,
    this.counsellorId,
    this.date,
    this.studentList,
  });

  Schedule.fromJson(Map<String, dynamic> json) {
    docId = json['docId'];
    blockedSlot = json['blockedSlot'];
    bookedSlot = json['bookedSlot'];
    counsellorId = json['counsellorId'];
    date = json['date'];
    studentList = json['studentList'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['docId'] = this.docId;
    data['blockedSlot'] = this.blockedSlot;
    data['bookedSlot'] = this.bookedSlot;
    data['counsellorId'] = this.counsellorId;
    data['date'] = this.date;
    data['studentList'] = this.studentList;
    return data;
  }

  Schedule.copyFrom(Schedule schedule) {
    blockedSlot = schedule.blockedSlot;
    bookedSlot = schedule.bookedSlot;
    counsellorId = schedule.counsellorId;
    date = schedule.date;
    docId = schedule.docId;
    studentList = schedule.studentList;
  }

  @override
  String toString() {
    return this.toJson().toString();
  }
}
