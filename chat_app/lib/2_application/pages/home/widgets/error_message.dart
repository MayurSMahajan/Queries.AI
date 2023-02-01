import 'package:chat_app/2_application/pages/home/bloc/messages_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ErrorMessage extends StatelessWidget {
  final String message;
  const ErrorMessage({super.key, required this.message});

  Future<void> _backToLoadingState(BuildContext context) {
    BlocProvider.of<MessagesBloc>(context).add(MessageLoadingEvent());
    return Future.delayed(const Duration(milliseconds: 0));
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return RefreshIndicator(
      color: Colors.pink,
      onRefresh: () => _backToLoadingState(context),
      child: ListView(
        children: [
          const SizedBox(height: 300),
          const Icon(Icons.error, size: 40, color: Colors.red),
          const SizedBox(height: 20),
          Text(message,
              style: themeData.textTheme.bodyText1!.copyWith(fontSize: 22),
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
          Text("Pull Up to Refresh",
              style: themeData.textTheme.bodyText1,
              textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
