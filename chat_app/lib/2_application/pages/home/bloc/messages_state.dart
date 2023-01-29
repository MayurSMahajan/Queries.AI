part of 'messages_bloc.dart';

@immutable
abstract class MessagesState extends Equatable {
  const MessagesState();

  @override
  List<Object> get props => [];
}

class MessagesInitial extends MessagesState {}

class MessagesStateLoaded extends MessagesState {
  final List<Message> messages;
  const MessagesStateLoaded({required this.messages});

  @override
  List<Object> get props => [messages];
}

class MessagesStateError extends MessagesState {
  final String errorMessage;
  const MessagesStateError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
