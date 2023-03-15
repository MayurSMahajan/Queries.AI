import 'package:chat_app/2_application/pages/home/bloc/text_to_speech_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatMessageControls extends StatelessWidget {
  final String message;

  const ChatMessageControls({super.key, required this.message});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        BlocBuilder<TextToSpeechCubit, TextToSpeechState>(
          builder: (context, state) {
            if (state is TextToSpeechPlaying) {
              return IconButton(
                  onPressed: () =>
                      BlocProvider.of<TextToSpeechCubit>(context).stopPlaying(),
                  icon: const Icon(Icons.volume_off_rounded));
            }
            return IconButton(
                onPressed: () =>
                    BlocProvider.of<TextToSpeechCubit>(context).startPlaying(
                      textToRead: message,
                    ),
                icon: const Icon(Icons.volume_up_rounded));
          },
        ),
      ],
    );
  }
}
