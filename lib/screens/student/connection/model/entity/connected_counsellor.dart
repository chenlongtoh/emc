class ConnectedCounsellor {
  String cid;
  String name;
  String profilePicture;
  String qualification;

  ConnectedCounsellor(
      {this.cid, this.name, this.profilePicture, this.qualification});

  ConnectedCounsellor.fromJson(Map<String, dynamic> json) {
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
