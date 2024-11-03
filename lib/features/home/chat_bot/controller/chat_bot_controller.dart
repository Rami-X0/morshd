import 'dart:async';
import 'dart:io';


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/features/home/chat_bot/data/models/message_and_image_model.dart';
import 'package:morshd/features/home/chat_bot/data/repo/chat_bot_repo.dart';

class ChatBotController extends AsyncNotifier {
  File? image;
  List<MessageAndImageModel> dataAndImage = [];

  void chatBot() async {
    state = const AsyncValue.loading();
    final response = await ref.watch(chatBotRepoProvider.future);

    var result = await response.chatBot(File(
      image!.path,
    ));

    result.when(success: (data) {
      dataAndImage.add(
        MessageAndImageModel(
          name: data.name.toString(),
          image: File(image!.path),
          address: data.address.toString(),
          rating: data.reviews!.first.rating!.toDouble(),
          weekdayText: data.openingHours!.weekdayText,
          openNow: data.openingHours!.openNow!,
          nameReview: data.reviews!.map((e) => e.authorName!).toList(),
          review: data.reviews!.map((e) => e.text!).toList(),
        ),
      );
      state = AsyncValue.data(data);
    }, failure: (failure) {
      state = AsyncValue.error(failure, StackTrace.current);
    });
  }

  @override
  FutureOr build() {}
}

final chatBotControllerProvider =
    AsyncNotifierProvider<ChatBotController, void>(
  () => ChatBotController(),
);
