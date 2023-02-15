import 'package:chat_app/2_application/pages/home/bloc/messages_bloc.dart';
import 'package:chat_app/1_domain/entity/message.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

import 'package:flutter/material.dart';

const permissionDenied = "Please give permission for using Microphone";

class UserInputField extends StatefulWidget {
  const UserInputField({
    Key? key,
  }) : super(key: key);

  @override
  State<UserInputField> createState() => _UserInputFieldState();
}

class _UserInputFieldState extends State<UserInputField> {
  final TextEditingController _textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late stt.SpeechToText speech;
  bool available = false;
  bool isListening = false;

  @override
  void initState() {
    speech = stt.SpeechToText();
    initializeSpeech();
    super.initState();
  }

  initializeSpeech() async {
    available = await speech.initialize(
        onStatus: speechStatusListener, onError: errorListener);
  }

  speechStatusListener(String text) {
    debugPrint(text);
    if (text == 'done') {
      setState(() {
        isListening = false;
      });
    }
  }

  errorListener(error) {
    debugPrint(error.errorMsg);
  }

  speechResultListener(SpeechRecognitionResult result) {
    setState(() => _textEditingController.text = result.recognizedWords);
  }

  String? textFieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    if (value.length > 128) {
      return 'Please shorten your question to 128 letters';
    }
    return null;
  }

  void sendMessage(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      String query = _textEditingController.text.trim();
      _textEditingController.clear();
      Message newMessage = Message(isUserMessage: true, text: query);
      BlocProvider.of<MessagesBloc>(context)
          .add(MessageRequestEvent(newMessage));
    }
  }

  void _showSnackbar(BuildContext buildContext, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        padding: const EdgeInsets.all(8),
        content: Text(
          message,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final btnColor = Theme.of(context).colorScheme.secondary;
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                color: btnColor,
                shape: BoxShape.circle,
              ),
              child: InkWell(
                  onTap: () {
                    if (!isListening) {
                      if (available) {
                        speech.listen(onResult: speechResultListener);
                      } else {
                        setState(() {
                          isListening = false;
                        });
                        _showSnackbar(context, permissionDenied);
                      }
                      setState(() {
                        isListening = true;
                      });
                    } else {
                      speech.stop();
                      setState(() {
                        isListening = false;
                      });
                    }
                  },
                  child: Icon(
                    isListening ? Icons.stop : Icons.mic,
                    color: Colors.white,
                  )),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _textEditingController,
                  validator: (value) => textFieldValidator(value),
                  onFieldSubmitted: (value) => sendMessage(context),
                  decoration: const InputDecoration(
                      hintText: "Send a message", border: OutlineInputBorder()),
                ),
              ),
            ),
            IconButton(
              icon: const Icon(
                Icons.send,
              ),
              onPressed: () => sendMessage(context),
            ),
          ],
        ),
      ),
    );
  }
}
