enum Emotion {
  happy,
  sad,
  angry,
}

extension EmotionExtension on Emotion {
  String get emotionString => EMOTION_STRING_MAP[this];
  String get emotionIconAssetPath => EMOTION_ICON_ASSET_MAP[this];
}

class EmotionEntryForm {
  static const NOTES = "notes";
}

const Map EMOTION_STRING_MAP = {
  Emotion.happy: "Happy",
  Emotion.sad: "Sad",
  Emotion.angry: "Angry",
};

const Map EMOTION_ICON_ASSET_MAP = {
  Emotion.happy: "assets/images/happy.png",
  Emotion.sad: "assets/images/sad.png",
  Emotion.angry: "assets/images/angry.png",
};
