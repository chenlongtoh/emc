class Counsellor{
  String cid;
  String email;
  String favouriteQuote;
  String name;
  String officeNumber;
  String profilePicture;
  String qualification;

  Counsellor({
    this.cid,
    this.email,
    this.favouriteQuote,
    this.name,
    this.officeNumber,
    this.profilePicture,
    this.qualification,
  });

  Counsellor.fromJson(Map<String, dynamic> json) {
    cid = json['cid'];
    email = json['email'];
    favouriteQuote = json['favouriteQuote'];
    name = json['name'];
    officeNumber = json['officeNumber'];
    profilePicture = json['profilePicture'];
    qualification = json['qualification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cid'] = this.cid;
    data['email'] = this.email;
    data['favouriteQuote'] = this.favouriteQuote;
    data['name'] = this.name;
    data['officeNumber'] = this.officeNumber;
    data['profilePicture'] = this.profilePicture;
    data['qualification'] = this.qualification;
    return data;
  }
}