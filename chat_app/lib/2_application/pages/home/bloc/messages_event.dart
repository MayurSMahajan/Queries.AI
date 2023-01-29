part of 'messages_bloc.dart';

abstract class MessagesEvent extends Equatable {
  const MessagesEvent();

  @override
  List<Object> get props => [];
}

class MessageLoadingEvent extends MessagesEvent {}

class MessageRequestEvent extends MessagesEvent {
  final Message message;
  const MessageRequestEvent(this.message);

  @override
  List<Object> get props => [message];
}
