import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/core/networking/api_constants.dart';
import 'package:morshd/core/networking/dio_factory.dart';
import 'package:morshd/features/home/chat_bot_text/data/models/chat_bot_request_text.dart';
import 'package:morshd/features/home/chat_bot_text/data/models/chat_bot_response_text.dart';


class ChatBotServicesText {
  final Dio _dio;

  ChatBotServicesText(this._dio);

  Future<ChatBotResponseText> chatBotText(ChatBotRequestText chatBotRequest) async {
    final request = await _dio.post('https://arcane-hamlet-39266-4e9e90b3f3b9.herokuapp.com/chat',
        data: chatBotRequest.toJson());
    return ChatBotResponseText.fromJson(request.data);
  }
}

final chatBotServicesProviderText = FutureProvider<ChatBotServicesText>((ref) async {
  Dio dio = await DioFactory.getDio();

  return ChatBotServicesText(dio);
});
