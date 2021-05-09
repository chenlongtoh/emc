import 'package:emc/screens/student/emotion_entry/constant.dart';
import 'package:flutter/material.dart';

const String ML_ASSET_PATH = "emotion_detection";
const String TFLITE_MODEL_FILE = "$ML_ASSET_PATH/model.tflite";
const String TOKENIZED_WORDS_FILE = "$ML_ASSET_PATH/words.json";
const String TOKENIZER_OOV_TOKEN = "<UNK>";

const int TENSOR_INPUT_MAX_LEN = 50;
const int TENSOR_OUTPUT_LEN = 3;

const Color CHAT_BOX_COLOR = Color(0xff029393);

const Map<Emotion, int> TENSOR_EMOTION_CLASS_INDEX_MAP = {
  Emotion.angry: 0,
  Emotion.sad: 1,
  Emotion.happy: 2,
};

class ChatInputForm {
  static final String INPUT_TEXT = "inputText";
}
