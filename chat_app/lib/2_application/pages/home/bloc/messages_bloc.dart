import 'package:chat_app/1_domain/entity/message.dart';
import 'package:chat_app/1_domain/use_cases/message_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../1_domain/failures/failures.dart';

const generalFailureMessage = "Oops! Something gone wrong. Please try again!";
const serverFailureMessage = "Oops! API Error. Please try again!";
const cacheFailureMessage = "Oops! Chache Failed. Please try again!";

class MessagesBloc extends Bloc<MessagesEvent, MessagesState> {
  final MessageUseCases messageUseCases;
  MessagesBloc({required this.messageUseCases}) : super(MessagesInitial()) {
    on<MessageLoadingEvent>((event, emit) async {
      await Future.delayed(const Duration(milliseconds: 50));
      emit(const MessagesStateLoaded(messages: <Message>[]));
    });

    on<MessageRequestEvent>((event, emit) async {
      if (state is MessagesStateLoaded) {
        final currentState = state as MessagesStateLoaded;
        emit(MessagesStateLoaded(
          messages: List.from(currentState.messages)..insert(0, event.message),
        ));

        final failureOrAdvice =
            await messageUseCases.getMessage(event.message.text);

        failureOrAdvice.fold(
            (failure) => emit(
                  MessagesStateError(
                    errorMessage: _mapFailureToMessage(failure),
                  ),
                ), (message) {
          final cState = state as MessagesStateLoaded;
          emit(
            MessagesStateLoaded(
              messages: List.from(cState.messages)..insert(0, message),
            ),
          );
        });
      }
    });
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverFailureMessage;
      case CacheFailure:
        return cacheFailureMessage;
      default:
        return generalFailureMessage;
    }
  }
}

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
