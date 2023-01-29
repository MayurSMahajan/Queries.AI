//A use case sits between your Bloc state Management solution and the data repository.
//It is just a collection of methods.
import 'package:chat_app/1_domain/entity/message.dart';
import 'package:dartz/dartz.dart';

import '../failures/failures.dart';
import '../repositories/message_repo.dart';

class MessageUseCases {
  final MessageRepo messageRepoImpl;
  MessageUseCases({required this.messageRepoImpl});

  Future<Either<Failure, Message>> getMessage(String query) async {
    return messageRepoImpl.getMessageFromDataSource(query);
    // //space for business logic.
  }
}
