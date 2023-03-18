import 'package:bloc_test/bloc_test.dart';
import 'package:chat_app/1_domain/entity/message.dart';
import 'package:chat_app/1_domain/failures/failures.dart';
import 'package:chat_app/1_domain/use_cases/message_use_case.dart';
import 'package:chat_app/2_application/pages/home/bloc/messages_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/scaffolding.dart';

const String kQuery = 'what is 2 plus 2';

class MockMessageUseCases extends Mock implements MessageUseCases {}

void main() {
  group('Advicer Cubit', () {
    group('should emit', () {
      MockMessageUseCases mockMessageUseCases = MockMessageUseCases();
      Message userQueryMsg = const Message(isUserMessage: true, text: kQuery);
      Message chatAnswerMsg = const Message(isUserMessage: false, text: kQuery);
      blocTest<MessagesBloc, MessagesState>(
        'nothing when no method is called',
        build: () => MessagesBloc(messageUseCases: mockMessageUseCases),
        expect: () => const <MessagesState>[],
      );
    });
  });
}
