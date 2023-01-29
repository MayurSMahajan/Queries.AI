import 'package:chat_app/2_application/pages/home/cubit/text_to_speech_cubit.dart';
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
        // const SaveForLaterIcon(),
        // ? const Icon(Icons.volume_off_rounded)
      ],
    );
  }
}

class SaveForLaterIcon extends StatefulWidget {
  const SaveForLaterIcon({super.key});

  @override
  State<SaveForLaterIcon> createState() => _SaveForLaterIconState();
}

class _SaveForLaterIconState extends State<SaveForLaterIcon> {
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => setState(() {
        isSaved = !isSaved;
      }),
      icon: isSaved
          ? const Icon(Icons.download_for_offline_outlined)
          : const Icon(Icons.download_for_offline),
    );
  }
}
