import 'package:chat_app/1_domain/entity/message.dart';
import 'package:chat_app/1_domain/use_cases/message_use_case.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../1_domain/failures/failures.dart';

part 'messages_event.dart';
part 'messages_state.dart';

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
        //mocking a network call.
        final failureOrAdvice =
            await messageUseCases.getMessage(event.message.text);

        failureOrAdvice.fold(
            (failure) => emit(MessagesStateError(
                errorMessage: _mapFailureToMessage(failure))), (message) {
          final cState = state as MessagesStateLoaded;
          emit(MessagesStateLoaded(
            messages: List.from(cState.messages)..insert(0, message),
          ));
        });

        // emit(const MessagesStateError(errorMessage: "Some Error Occured"));
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
