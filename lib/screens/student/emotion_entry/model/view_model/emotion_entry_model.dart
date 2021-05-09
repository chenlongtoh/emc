import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/screens/student/emotion_entry/model/entity/emotion_entry.dart';
import 'package:emc/screens/student/emotion_entry/service/emotion_entry_service.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'dart:developer';

class EmotionEntryModel {
  final AuthModel authModel;
  EmotionEntryModel({this.authModel});

  Future save(String emotionString, String notes) async {
    EasyLoading.show();
    String uid = authModel?.user?.uid ?? "-";
    EmotionEntry emotion = new EmotionEntry(
      emotion: emotionString ?? "N/A",
      notes: notes ?? "-",
      timestamp: DateTime.now().millisecondsSinceEpoch,
      uid: uid,
    );
    final success = await EmotionEntryService.saveEmotionEntry(emotion.toJson());
    if(success){
      EasyLoading.showSuccess("Emotion Saved Successfully");
    } else {
      EasyLoading.showError("Couldn't save, please try again");
    }
    EasyLoading.dismiss();
    return success;
  }
}
