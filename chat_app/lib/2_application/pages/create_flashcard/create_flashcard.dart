import 'package:chat_app/2_application/pages/home/widgets/widgets.dart';
import 'package:flutter/material.dart';

const createFlashcard = "Create Flashcard";
const createInformation = "Enter information you want to remember";
const createHook = "Enter a hook phrase or word";

class CreateFlashcard extends StatelessWidget {
  final String? message;
  const CreateFlashcard({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: createFlashcard),
      body: Center(
        child: Text(message ?? createInformation),
      ),
    );
  }
}
