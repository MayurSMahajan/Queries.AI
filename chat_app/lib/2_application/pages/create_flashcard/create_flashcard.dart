import 'package:chat_app/2_application/core/widgets/flashcard.dart';
import 'package:chat_app/2_application/core/widgets/gradient_background_with_child.dart';
import 'package:chat_app/2_application/pages/home/widgets/widgets.dart';
import 'package:flutter/material.dart';

const kCreateFlashcard = "Create Flashcard";
const kCreateInformation = "Enter information you want to remember";
const kCreateHook = "Enter a hook phrase or word";

class CreateFlashcard extends StatelessWidget {
  final String? message;
  const CreateFlashcard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: kCreateFlashcard),
      body: GradientBackgroundwithChild(
        child: Center(
            child: Flashcard(
          cardNum: 1,
          color: Theme.of(context).colorScheme.secondary,
          phrase: kCreateHook,
          explanation: message ?? kCreateInformation,
        )),
      ),
    );
  }
}
