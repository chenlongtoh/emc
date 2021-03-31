class EmotionEntry {
  String emotion;
  String notes;
  num timestamp;
  String uid;

  EmotionEntry({this.emotion, this.notes, this.timestamp, this.uid});

  EmotionEntry.fromJson(Map<String, dynamic> json) {
    emotion = json['emotion'];
    notes = json['notes'];
    timestamp = json['timestamp'];
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['emotion'] = this.emotion;
    data['notes'] = this.notes;
    data['timestamp'] = this.timestamp;
    data['uid'] = this.uid;
    return data;
  }
}