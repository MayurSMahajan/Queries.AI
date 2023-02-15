import 'package:chat_app/1_domain/entity/message.dart';
import 'package:equatable/equatable.dart';

class MessageModel extends Message with EquatableMixin {
  MessageModel({required bool isUserMessage, required String text})
      : super(isUserMessage: false, text: text);

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(isUserMessage: false, text: json['assistant']);
  }
}
