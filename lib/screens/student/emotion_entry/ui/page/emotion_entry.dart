import 'dart:developer';

import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_button.dart';
import 'package:emc/screens/student/emotion_entry/model/view_model/emotion_entry_model.dart';
import 'package:emc/screens/student/profile/ui/student_profile.dart';
import 'package:flutter/material.dart';
import 'package:emc/screens/student/emotion_entry/ui/widgets/icon_card.dart';
import 'package:emc/screens/student/emotion_entry/ui/widgets/profile_button.dart';
import 'package:emc/screens/student/emotion_entry/constant.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';
import 'package:emc/common_widget/emc_scaffold.dart';

class EmotionEntry extends StatefulWidget {
  @override
  _EmotionEntryState createState() => _EmotionEntryState();
}

class _EmotionEntryState extends State<EmotionEntry> {
  final GlobalKey<FormBuilderState> _fbKey = new GlobalKey<FormBuilderState>();
  EmotionEntryModel model;
  Emotion _selectedEmotion = Emotion.happy;

  @override
  void initState() {
    super.initState();
    final authModel = Provider.of<AuthModel>(context, listen: false);
    model = new EmotionEntryModel(authModel: authModel);
  }

  void _onSave() async {
    _fbKey?.currentState?.saveAndValidate();
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    final String notes = (_fbKey?.currentState?.value ?? const {})[EmotionEntryForm.NOTES] ?? "";
    final String emotionString = _selectedEmotion.emotionString;
    bool success = await model.save(emotionString, notes);
    if (success) {
      _fbKey.currentState.reset();
      setState(() => _selectedEmotion = Emotion.happy);
    }
  }

  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      maskBackground: false,
      appBar: AppBar(
        actions: [
          ProfileButton(
            onTap: () => Navigator.pushNamed(context, StudentProfile.routeName),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: FormBuilder(
          key: _fbKey,
          child: ListView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: [
              Text(
                "How are you feeling today?",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 35,
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () => setState(() => _selectedEmotion = Emotion.happy),
                    borderRadius: BorderRadius.circular(20),
                    child: IconCard(
                      emotion: Emotion.happy,
                      selected: _selectedEmotion == Emotion.happy,
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() => _selectedEmotion = Emotion.sad),
                    borderRadius: BorderRadius.circular(20),
                    child: IconCard(
                      emotion: Emotion.sad,
                      selected: _selectedEmotion == Emotion.sad,
                    ),
                  ),
                  InkWell(
                    onTap: () => setState(() => _selectedEmotion = Emotion.angry),
                    borderRadius: BorderRadius.circular(20),
                    child: IconCard(
                      emotion: Emotion.angry,
                      selected: _selectedEmotion == Emotion.angry,
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
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
              SizedBox(height: 10),
              Center(
                child: EmcButton(
                  onPressed: _onSave,
                  text: "Save",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
