import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/core/networking/api_result.dart';
import 'package:morshd/core/networking/api_result_text.dart';
import 'package:morshd/features/home/chat_bot_text/data/models/chat_bot_request_text.dart';
import 'package:morshd/features/home/chat_bot_text/data/models/chat_bot_response_text.dart';
import 'package:morshd/features/home/chat_bot_text/data/services/chat_bot_services_text.dart';



class ChatBotRepoText {
  final ChatBotServicesText _chatBotServices;

  ChatBotRepoText(this._chatBotServices);

  Future<ApiResultText<ChatBotResponseText>> chatBotText(ChatBotRequestText chatBotRequest) async {
    try {
      final response = await _chatBotServices.chatBotText(chatBotRequest);
      return ApiSuccessText(response);
    } catch (failure) {
      return ApiFailureText(failure.toString());
    }
  }
}

final chatBotRepoProviderText = FutureProvider<ChatBotRepoText>((ref) async {
  final chatBotServices = await ref.read(chatBotServicesProviderText.future);
  return ChatBotRepoText(chatBotServices);
});
