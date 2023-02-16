import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/1_domain/entity/message.dart';

import 'widgets/widgets.dart';
import '../../../injection.dart';
import 'bloc/messages_bloc.dart';

class HomeScreenWrapper extends StatelessWidget {
  const HomeScreenWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MessagesBloc>()..add(MessageLoadingEvent()),
      child: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gradientStartColor = Theme.of(context).colorScheme.surfaceVariant;
    final gradientEndColor = Theme.of(context).colorScheme.onSurfaceVariant;

    return Scaffold(
        appBar: const MyAppBar(
          title: "Ask Anything",
        ),
        drawer: const MyDrawer(),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [gradientStartColor, gradientEndColor],
                stops: const [0.7, 0.9],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: SafeArea(
            child: BlocBuilder<MessagesBloc, MessagesState>(
              builder: (context, state) {
                if (state is MessagesStateLoaded) {
                  return MessagesListView(
                    messages: state.messages,
                    isLoading: state.messages.length,
                  );
                }
                if (state is MessagesStateError) {
                  return ErrorMessage(message: state.errorMessage);
                }
                return const ScreenLoading();
              },
            ),
          ),
        ));
  }
}

class MessagesListView extends StatelessWidget {
  final int isLoading;
  final List<Message> messages;
  const MessagesListView({
    Key? key,
    required this.messages,
    required this.isLoading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
            child: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: ListView.builder(
            reverse: true,
            padding: const EdgeInsets.all(8.0),
            itemCount: messages.length,
            itemBuilder: (context, index) {
              return ChatMessageWrapper(message: messages[index]);
            },
          ),
        )),
        isLoading % 2 != 0 ? const ThreeDots() : const SizedBox(height: 1),
        // const Divider(
        //   height: 1.0,
        // ),
        const UserInputField(),
      ],
    );
  }
}
