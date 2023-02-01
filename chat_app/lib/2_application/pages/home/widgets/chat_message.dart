import 'package:chat_app/1_domain/entity/message.dart';
import 'package:chat_app/2_application/pages/home/cubit/text_to_speech_cubit.dart';
import 'package:chat_app/2_application/pages/home/widgets/chat_message_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection.dart';

class ChatMessageWrapper extends StatelessWidget {
  final Message message;
  const ChatMessageWrapper({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<TextToSpeechCubit>(),
      child: ChatMessage(message: message),
    );
  }
}

class ChatMessage extends StatelessWidget {
  const ChatMessage({super.key, required this.message});

  final Message message;

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyText1;
    final imagePath = message.sender == "User"
        ? 'assets/images/user.jpg'
        : 'assets/images/panda.jpg';
    final alignment = message.sender == "User"
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 16, bottom: 16, right: 32),
      child: Row(
        crossAxisAlignment: alignment,
        children: [
          CircleAvatar(
              backgroundImage: AssetImage(
            imagePath,
          )),
          const SizedBox(width: 12),
          Expanded(
              child: Text(
            message.text.trim(),
            style: textStyle,
          )),
          ChatMessageControls(message: message.text),
        ],
      ),
    );
  }
}
