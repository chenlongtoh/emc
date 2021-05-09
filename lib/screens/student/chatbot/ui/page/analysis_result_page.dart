import 'dart:developer';

import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/screens/student/chatbot/model/entity/analysis_result.dart';
import 'package:emc/screens/student/chatbot/ui/widget/emotion_analysis_result_card.dart';
import 'package:emc/screens/student/emotion_entry/constant.dart';
import 'package:emc/screens/student/emotion_entry/model/view_model/emotion_entry_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

class AnalysisResultPageArgs {

  final AnalysisResult analysisResult;
  AnalysisResultPageArgs({this.analysisResult});
}

class AnalysisResultPage extends StatefulWidget {
  static const String routeName = "/analysisResultPage";
  final AnalysisResultPageArgs args;

  const AnalysisResultPage({Key key, this.args}) : super(key: key);

  @override
  _AnalysisResultPageState createState() => _AnalysisResultPageState();
}

class _AnalysisResultPageState extends State<AnalysisResultPage> {
  final GlobalKey<FormBuilderState> _fbKey = new GlobalKey<FormBuilderState>();
  EmotionEntryModel _model;
  AuthModel authModel;

  @override
  void initState() {
    super.initState();
    final authModel = Provider.of<AuthModel>(context, listen: false);
    _model = new EmotionEntryModel(authModel: authModel);
  }

  Widget _getQuote() {
    return Text(
      "\" LONG ONG TEXt\"",
      style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
    );
  }

  void _onFindCounsellor() {}

  void _onSave() async {
    _fbKey?.currentState?.saveAndValidate();
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    final String notes = (_fbKey?.currentState?.value ?? const {})[EmotionEntryForm.NOTES] ?? "";
    log("notes => $notes");
    final String emotionString = EMOTION_STRING_MAP[Emotion.happy];
    bool success = await _model.save(emotionString, notes);
    if (success) {
      _fbKey?.currentState?.reset();
      Navigator.pop(context);
    }
  }

  Future<void> _onSaveEmotion() {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Enter Notes'),
          content: FormBuilder(
            key: _fbKey,
            child: FormBuilderTextField(
              name: EmotionEntryForm.NOTES,
              maxLines: 6,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                border: new OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: new BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
                hintText: "Notes",
              ),
            ),
          ),
          // content: SingleChildScrollView(
          //   child: ListBody(
          //     children: <Widget>[
          //       Text('Would you like to connect to this student?'),
          //     ],
          //   ),
          // ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: _onSave,
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      appBar: AppBar(title: Text("Analysis")),
      maskBackground: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: SingleChildScrollView(
          physics: new BouncingScrollPhysics(),
          child: Column(
            children: [
              EmotionAnalysisResultCard(result: widget?.args?.analysisResult),
              SizedBox(height: 20),
              Text(
                "Emotion Detected: ${widget?.args?.analysisResult?.emotionDetected?.emotionString ?? '-'}",
                style: TextStyle(fontStyle: FontStyle.italic, color: Colors.white),
              ),
              SizedBox(height: 20),
              _getQuote(),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async => await _onSaveEmotion(),
                    child: Text("Save Emotion"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15),
                  ElevatedButton(
                    onPressed: _onFindCounsellor,
                    child: Text("Find Counsellor"),
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
