import 'package:chat_app/1_domain/entity/message.dart';

import '../../1_domain/failures/failures.dart';
import '../../1_domain/repositories/message_repo.dart';
import 'package:dartz/dartz.dart';

import '../data_sources/message_data_source.dart';
import '../exceptions/exceptions.dart';

class MessageRepoImpl implements MessageRepo {
  final MessageRemoteDataSource messagesRemoteDataSource;
  MessageRepoImpl({required this.messagesRemoteDataSource});

  @override
  Future<Either<Failure, Message>> getMessageFromDataSource(
      String query) async {
    try {
      final result = await messagesRemoteDataSource.getMessageFromApi(query);
      return right(result);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
