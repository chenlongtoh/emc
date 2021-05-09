import 'package:emc/screens/student/chatbot/model/view_model/chat_model.dart';
import 'package:emc/util/form_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class ChatInput extends StatefulWidget {
  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final GlobalKey<FormBuilderState> _fbKey = new GlobalKey<FormBuilderState>();

  void _onSend(ChatModel model) {
    _fbKey.currentState.saveAndValidate();
    final String input = FormUtil.getFormValue(_fbKey, ChatInputForm.INPUT_TEXT);
    if (input?.isNotEmpty ?? false) {
      model?.inputText(input);
      _fbKey.currentState.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatModel>(
      builder: (context, model, child) {
        return FormBuilder(
          key: _fbKey,
          child: Container(
            decoration: BoxDecoration(
              color: Color(0x4abfbbbb),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Row(
              children: [
                Expanded(
                  child: FormBuilderTextField(
                    name: ChatInputForm.INPUT_TEXT,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      isDense: true,
                      border: new OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27),
                        borderSide: new BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      hintText: "Chat here...",
                    ),
                    maxLines: 3,
                    minLines: 1,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: CHAT_BOX_COLOR,
                      size: 30,
                    ),
                    onPressed: () => _onSend(model),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
