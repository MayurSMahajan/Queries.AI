import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final bool isUserMessage;
  final String text;

  const Message({required this.isUserMessage, required this.text});

  @override
  List<Object?> get props => [isUserMessage, text];
}
