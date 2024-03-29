import 'package:chat_app/1_domain/entity/message.dart';
import 'package:chat_app/2_application/core/utils/images_consts.dart';
import 'package:chat_app/2_application/core/widgets/circular_icon_button.dart';
import 'package:chat_app/2_application/pages/home/bloc/text_to_speech_cubit.dart';
import 'package:chat_app/2_application/pages/home/widgets/chat_message_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../injection.dart';
import '../../../themes/color_consts.dart';

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

    final imagePath = message.isUserMessage ? userImage : pandaImage;
    final alignment = message.isUserMessage
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    return InkWell(
      onDoubleTap: () => showOptions(context, message),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 8.0, top: 16, bottom: 16, right: 32),
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
      ),
    );
  }

  Future<String?> showOptions(BuildContext context, Message message) {
    // final btnBackgroundColor = Theme.of(context).colorScheme.primary;

    return showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            CircularIconButton(
                btnColor: btnBackgroundColor,
                icon: const Image(
                  width: 40,
                  height: 40,
                  image: AssetImage(cardIconImage),
                ),
                onTap: () {
                  debugPrint("flashcard");
                  Navigator.pop(context, 'flashcard');
                  context.goNamed("create_flashcard",
                      params: {'message': message.text});
                }),
            CircularIconButton(
                btnColor: btnBackgroundColor,
                icon: const Icon(
                  Icons.volume_up,
                  color: btnForegroundColor,
                  size: 35,
                ),
                onTap: () {
                  debugPrint("speak out loud");
                  Navigator.pop(context, 'Speaker');
                }),
            CircularIconButton(
                btnColor: btnBackgroundColor,
                icon: const Icon(
                  Icons.download,
                  color: btnForegroundColor,
                  size: 35,
                ),
                onTap: () {
                  debugPrint("download");
                  Navigator.pop(context, 'download');
                }),
          ],
        ),
      ),
    );
  }
}
