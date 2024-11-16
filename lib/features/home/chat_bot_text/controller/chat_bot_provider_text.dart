import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:morshd/features/home/chat_bot_text/data/models/chat_bot_request_text.dart';
import 'package:morshd/features/home/chat_bot_text/data/models/messages_text.dart';
import 'package:morshd/features/home/chat_bot_text/data/repo/chat_bot_repo_text.dart';
import 'package:morshd/features/home/chat_bot_text/data/services/chat_bot_services_text.dart';
import 'package:morshd/features/home/chat_bot_text/ui/widgets/chat_bot_form_text.dart';


class ChatBotProviderText extends AsyncNotifier {
  List<MessageText> message = [];

  @override
  FutureOr build() {
     }

  Future chatBot() async {
    state = const AsyncValue.loading();
    final request = await ref.read(chatBotRepoProviderText.future);
    final result = await request.chatBotText(
      ChatBotRequestText(
        message: chatBotControllerText.text,
      ),
    );
    message.add(MessageText(message: chatBotControllerText.text, isUserMessage: true));
    result.when(success: (response) {
      message.add(MessageText(message: response.response, isUserMessage: false));

      state = AsyncValue.data(response);
    }, failure: (message) {
      state = AsyncValue.error(message, StackTrace.current);
    });
  }
}

final chatBotProvider = AsyncNotifierProvider<ChatBotProviderText, void>(
  () => ChatBotProviderText(),
);
