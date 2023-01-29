import 'package:chat_app/1_domain/entity/message.dart';
import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

abstract class MessageRepo {
  Future<Either<Failure, Message>> getMessageFromDataSource(String query);
}
