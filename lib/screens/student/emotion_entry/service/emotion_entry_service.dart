import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class EmotionEntryService {
  static Future saveEmotionEntry(Map<String, dynamic> data) async {
    try {
      CollectionReference emotionRecord = FirebaseFirestore.instance.collection('emotionRecord');
      await emotionRecord.add(data);
      return true;
    } on FirebaseException catch (error) {
        EasyLoading.showError("Error: $error");
    }
    return false;
  }
}
