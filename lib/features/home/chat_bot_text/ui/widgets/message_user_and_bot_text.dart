import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/home/chat_bot_text/controller/chat_bot_provider_text.dart';

class MessageUserAndBotText extends ConsumerWidget {
  const MessageUserAndBotText({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatBotState = ref.watch(chatBotProvider);
    final messages = ref.read(chatBotProvider.notifier).message;

    return chatBotState.when(
      data: (data) {
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final message = messages[index];
              final isUserMessage = message.isUserMessage;

              return Row(
                mainAxisAlignment: isUserMessage
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: isUserMessage ? Colors.blue[100] : Colors.green[100],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isUserMessage ? Colors.blue : Colors.green,
                      ),
                    ),
                    child: Text(
                      message.message,
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
      error: (failure, stackTrace) {
        return Text(failure.toString());
      },
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
