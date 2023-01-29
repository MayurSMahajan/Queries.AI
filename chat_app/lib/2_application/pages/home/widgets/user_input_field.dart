import 'package:chat_app/2_application/pages/home/bloc/messages_bloc.dart';
import 'package:chat_app/1_domain/entity/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      Message newMessage = Message(sender: "User", text: query);
      BlocProvider.of<MessagesBloc>(context)
          .add(MessageRequestEvent(newMessage));
    }
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
                child: const Icon(
                  Icons.mic,
                  color: Colors.white,
                ),
                onTap: () {},
              ),
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
