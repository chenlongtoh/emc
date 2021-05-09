class Quote {
  String quote;
  String author;
  String occupation;

  Quote({this.quote, this.author, this.occupation});

  Quote.fromJson(Map<String, dynamic> json) {
    quote = json['quote'];
    author = json['author'];
    occupation = json['occupation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['quote'] = this.quote;
    data['author'] = this.author;
    data['occupation'] = this.occupation;
    return data;
  }
}
