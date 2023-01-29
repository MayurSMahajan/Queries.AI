import 'package:chat_app/0_data/data_sources/message_data_source.dart';
import 'package:chat_app/0_data/repositories/messages_repo_impl.dart';
import 'package:chat_app/1_domain/repositories/message_repo.dart';
import 'package:chat_app/1_domain/use_cases/message_use_case.dart';
import 'package:chat_app/2_application/pages/home/bloc/messages_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.I;

Future<void> init() async {
  //application layer
  sl.registerFactory(() => MessagesBloc(messageUseCases: sl()));

  //domain layer
  sl.registerFactory(() => MessageUseCases(messageRepoImpl: sl()));

  //data layer
  sl.registerFactory<MessageRepo>(
      () => MessageRepoImpl(messagesRemoteDataSource: sl()));
  sl.registerFactory<MessageRemoteDataSource>(
      () => MessageRemoteDataSourceImpl(client: sl()));

  //externs
  sl.registerFactory(() => http.Client());
}
