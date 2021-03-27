class Account {
  String email;
  String password;
  String name;
  String matric;
  String profilePic;

  Account({this.email, this.password, this.name, this.matric, this.profilePic});

  Account.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    name = json['name'];
    matric = json['matric'];
    profilePic = json['profilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    data['name'] = this.name;
    data['matric'] = this.matric;
    data['profilePic'] = this.profilePic;
    return data;
  }
}
