class ConnectedStudent {
  String sid;
  String name;
  String profilePicture;

  ConnectedStudent({this.sid, this.name, this.profilePicture});

  ConnectedStudent.fromJson(Map<String, dynamic> json) {
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
