class EmcUser {
  bool isStudent;
  String uid;
  String email;
  String matric;
  String name;
  String profilePicture;

  // Counsellor fields
  String favouriteQuote;
  String officeNumber;
  String profileDescription;
  String qualification;

  EmcUser({
    this.isStudent,
    this.uid,
    this.email,
    this.matric,
    this.name,
    this.profilePicture,
    this.favouriteQuote,
    this.officeNumber,
    this.profileDescription,
    this.qualification,
  });

  EmcUser.fromJson(Map<String, dynamic> json) {
    isStudent = json['isStudent'];
    uid = json['uid'];
    email = json['email'];
    matric = json['matric'];
    name = json['name'];
    profilePicture = json['profilePicture'];
    favouriteQuote = json['favouriteQuote'];
    officeNumber = json['officeNumber'];
    profileDescription = json['profileDescription'];
    qualification = json['qualification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isStudent'] = this.isStudent;
    data['uid'] = this.uid;
    data['email'] = this.email;
    data['matric'] = this.matric;
    data['name'] = this.name;
    data['profilePicture'] = this.profilePicture;
    data['favouriteQuote'] = this.favouriteQuote;
    data['officeNumber'] = this.officeNumber;
    data['profileDescription'] = this.profileDescription;
    data['qualification'] = this.qualification;
    return data;
  }
}
