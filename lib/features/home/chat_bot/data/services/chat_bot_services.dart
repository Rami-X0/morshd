import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/core/networking/dio_factory.dart';
import 'package:morshd/features/home/chat_bot/data/models/chat_bot_response.dart';

class ChatBoServices {
  final Dio _dio;

  ChatBoServices(this._dio);

  Future<ChatBotResponse> chatBot(FormData formData) async {
    final response = await _dio.post(
      'http://morshd.somee.com/api/AIPlace/check-travel-place',
      data: formData,
    );
    final data=jsonDecode(response.data);
    print(data['name']);

    return ChatBotResponse.fromJson(data);
  }
}

final chatBotServicesProvider = FutureProvider(
  (ref) async {
    Dio dio = await DioFactory.getDio();
    return ChatBoServices(dio);
  },
);
