import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/features/home/chat_bot/data/models/chat_bot_response.dart';
import 'package:morshd/features/home/chat_bot/data/services/api_result_chat.dart';
import 'package:morshd/features/home/chat_bot/data/services/chat_bot_services.dart';

class ChatBotRepo {
  final ChatBoServices _chatBoServices;

  ChatBotRepo(this._chatBoServices);

  Future<ApiResultChat<ChatBotResponse>> chatBot(File image) async {
    var response = await _chatBoServices.chatBot(FormData.fromMap({
      "imageFile": await MultipartFile.fromFile(image.path),
    }));

    try {
       return ApiSuccessChat(response);
    } catch (failure) {
      return ApiFailureChat(failure.toString());
    }
  }
}

final chatBotRepoProvider = FutureProvider((ref) async {
  final chatBotServices = await ref.watch(chatBotServicesProvider.future);

  return ChatBotRepo(chatBotServices);
});
