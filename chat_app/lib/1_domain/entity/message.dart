import 'package:equatable/equatable.dart';

class Message extends Equatable {
  final String sender;
  final String text;

  const Message({required this.sender, required this.text});

  @override
  List<Object?> get props => [sender, text];
}
