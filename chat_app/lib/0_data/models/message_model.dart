import 'package:chat_app/1_domain/entity/message.dart';
import 'package:equatable/equatable.dart';

class MessageModel extends Message with EquatableMixin {
  MessageModel({String sender = "CHAD", required String text})
      : super(sender: sender, text: text);

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(sender: "CHAD", text: json['assistant']);
  }
}
