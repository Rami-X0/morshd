import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morshd/core/widgets/app_text_form_field.dart';
import 'package:morshd/features/home/chat_bot_text/controller/chat_bot_provider_text.dart';


class ChatBotFormText extends ConsumerStatefulWidget {
  const ChatBotFormText({super.key});

  @override
  ConsumerState<ChatBotFormText> createState() => _ChatBotFormState();
}

final TextEditingController chatBotControllerText = TextEditingController();

class _ChatBotFormState extends ConsumerState<ChatBotFormText> {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: AppTextFormField(
        hintText: 'write your message',
        suffixIcon: GestureDetector(
          onTap: () {
            ref.read(chatBotProvider.notifier).chatBot().then((value) {
              chatBotControllerText.clear();
            });
          },
          child: const FaIcon(
            FontAwesomeIcons.solidPaperPlane,
          ),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'please enter your message';
          }
          return null;
        },
        controller: chatBotControllerText,
        // text: '',
      ),
    );
  }
}
