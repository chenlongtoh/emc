import 'dart:convert';
import 'dart:developer';
import 'dart:math' as Math;

import 'package:dialog_flowtter/dialog_flowtter.dart';
import 'package:emc/screens/student/chatbot/model/entity/analysis_result.dart';
import 'package:emc/screens/student/chatbot/model/entity/chat.dart';
import 'package:emc/screens/student/chatbot/model/entity/quote.dart';
import 'package:emc/screens/student/chatbot/model/entity/sentiment_analyzer.dart';
import 'package:emc/screens/student/chatbot/service/quote_service.dart';
import 'package:emc/screens/student/emotion_entry/constant.dart';
import 'package:flutter/foundation.dart';

import '../../constant.dart';

class ChatModel with ChangeNotifier {
  int consecutiveCounter = 0;
  List<Chat> chatList = [];
  AnalysisResult analysisResult;
  bool isLoading = false;
  DialogFlowtter dialogFlowtter;
  SentimentAnalyzer sentimentAnalysisModel = new SentimentAnalyzer();
  Quote randomQuote;
  bool isChatLoading = false;

  init() async {
    setLoading();
    await sentimentAnalysisModel.init();
    dialogFlowtter = await DialogFlowtter.fromFile(path: "assets/services.json");
    _displayBotLoadingChat();
    await getWelcome();
    setIdle();
  }

  getWelcome() async {
    final QueryInput queryInput = QueryInput(
      text: TextInput(
        text: "Hi. How are you?",
        languageCode: "en",
      ),
    );
    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: queryInput,
    );
    _addToChat(response?.text, ChatType.bot);
    log("Response => ${response?.queryResult?.intent?.isFallback ?? '-'}");
  }

  _displayBotLoadingChat(){
    isChatLoading = true;
    chatList.add(new Chat(chatType: ChatType.botLoading));
    notifyListeners();
  }

  void _addToChat(String text, ChatType type) {
    if(type == ChatType.bot && isChatLoading){
      isChatLoading = false;
      chatList.removeLast();
    }
    if (text != null) {
      chatList.add(new Chat(chatType: type, text: text));
    }
    notifyListeners();
  }

  inputText(String input) async {
    analysisResult = null;
    _addToChat(input, ChatType.user);
    _displayBotLoadingChat();
    DetectIntentResponse response = await dialogFlowtter.detectIntent(
      queryInput: QueryInput(
        text: TextInput(
          text: input,
          languageCode: "en",
        ),
      ),
    );
    _addToChat(response?.text, ChatType.bot);
    final List<double> output = sentimentAnalysisModel.analyseText(input);
    // log("output?.isNotEmpty ?? false => ${output?.isNotEmpty}");
    if (output?.isNotEmpty ?? false) {
      final double highestPrediction = output.reduce(Math.max);
      log("output => $output"); 
      log("response?.queryResult?.intent?.displayName => ${response?.queryResult?.intent?.displayName}");
      if (highestPrediction > 0.5) {
        final Emotion dialogFlowEmotion = EMOTION_STRING_MAP.keys.firstWhere(
          (key) => EMOTION_STRING_MAP[key] == response?.queryResult?.intent?.displayName,
          orElse: () => null,
        );
        // log("response?.queryResult?.intent?.displayName => ${response?.queryResult?.intent?.displayName}");
        final Emotion emotionDetected =
            TENSOR_EMOTION_CLASS_INDEX_MAP.keys.firstWhere((key) => TENSOR_EMOTION_CLASS_INDEX_MAP[key] == output.indexOf(highestPrediction));
        log("dialogFlowEmotion => $dialogFlowEmotion");
        log("emotionDetected => $emotionDetected");

        if (dialogFlowEmotion == emotionDetected || highestPrediction > 0.8) {
          log("Came here => camehere");
          randomQuote = await QuoteService.genrateRandomQuote();
          analysisResult = new AnalysisResult(
            happiness: output[TENSOR_EMOTION_CLASS_INDEX_MAP[Emotion.happy]],
            angriness: output[TENSOR_EMOTION_CLASS_INDEX_MAP[Emotion.angry]],
            sadness: output[TENSOR_EMOTION_CLASS_INDEX_MAP[Emotion.sad]],
            emotionDetected: emotionDetected,
            randomQuote: randomQuote,
          );
        }
      }
    }
    // result["prediction"];
    // log("chatList.last.text => ${chatList.last.text}");
    notifyListeners();
  }

  addLoadingText(){
    _addToChat(null, ChatType.botLoading);
  }

  removeLoadingText(){
    chatList.removeLast();
  }

  clearChat() {
    chatList.clear();
    notifyListeners();
  }

  setLoading() {
    isLoading = true;
    notifyListeners();
  }

  setIdle() {
    isLoading = false;
    notifyListeners();
  }
}
