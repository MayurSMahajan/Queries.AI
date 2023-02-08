import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:chat_app/0_data/models/message_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../exceptions/exceptions.dart';

abstract class MessageRemoteDataSource {
  /// Requests a response from an API
  /// returns [MessageModel] if successful
  /// throws a server exception if status code is not 200
  Future<MessageModel> getMessageFromApi(String query);
}

class MessageRemoteDataSourceImpl implements MessageRemoteDataSource {
  final http.Client client;
  MessageRemoteDataSourceImpl({required this.client});

  @override
  Future<MessageModel> getMessageFromApi(String query) async {
    final urlLink = dotenv.env['SERVER_URL'];
    final url = Uri.parse(urlLink!);
    const headers = {
      'content-type': 'application/json; charset=utf-8',
    };
    final response = await client.post(
      url,
      headers: headers,
      body: jsonEncode({
        'prompt': query,
      }),
    );
    if (response.statusCode != 200) {
      throw ServerException();
    } else {
      return MessageModel.fromJson(json.decode(response.body));
    }
  }
}
