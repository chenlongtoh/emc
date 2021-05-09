import 'dart:convert';
import 'dart:developer';
import 'dart:math' as Math;

import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:flutter/services.dart';

import '../../constant.dart';

class SentimentAnalyzer {
  bool isLoading = false;

  Interpreter _interpreter;
  Map<String, dynamic> _vocab = {};

  init() async {
    try {
      _interpreter = await Interpreter.fromAsset(TFLITE_MODEL_FILE);
      final String data = await rootBundle.loadString('assets/$TOKENIZED_WORDS_FILE');
      _vocab = json.decode(data);
    } catch (error) {
      log("Error @ ML > init => $error");
    }
  }

  List<double> analyseText(String text) {
    List<List<double>> inputTensor = tokenizeText(text); 
    var outputTensor = List.filled(TENSOR_OUTPUT_LEN, null).reshape([1, TENSOR_OUTPUT_LEN]);
    _interpreter.run(inputTensor, outputTensor);
    return outputTensor[0];
  }

  tokenizeText(String text) {
    List<String> words = text.split(' ');
    if (words.length > TENSOR_INPUT_MAX_LEN) {
      words = words.sublist(0, TENSOR_INPUT_MAX_LEN);
    }
    List<double> sequence = List<double>.from(words.map((word) {
      final String lowercaseWord = word.toLowerCase();
      return _vocab.containsKey(lowercaseWord) ? _vocab[lowercaseWord].toDouble() : _vocab[TOKENIZER_OOV_TOKEN].toDouble();
    }).toList());

    if (words.length != TENSOR_INPUT_MAX_LEN) {
      final int currentLength = sequence.length;
      sequence.length = TENSOR_INPUT_MAX_LEN;
      sequence.fillRange(currentLength, TENSOR_INPUT_MAX_LEN, 0);
    }
    return [sequence];
  }
}
