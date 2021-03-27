enum Emotion {
  happy,
  sad,
  angry,
}

extension EmotionTypeExtension on Emotion {
  static final Map _emotionStringMap = {
    Emotion.happy: "Happy",
    Emotion.sad: "Sad",
    Emotion.angry: "Angry",
  };

  static final Map _emotionIconAssetMap = {
    Emotion.happy: "assets/images/happy.png",
    Emotion.sad: "assets/images/sad.png",
    Emotion.angry: "assets/images/angry.png",
  };

  String get emotionString => _emotionStringMap[this];

  String get emotionIconAssetPath => _emotionIconAssetMap[this];
}

class EmotionEntryForm{
  static const NOTES = "notes";
}