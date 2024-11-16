import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/core/widgets/app_scaffold.dart';
import 'package:morshd/features/home/chat_bot_text/ui/widgets/chat_bot_form_text.dart';
import 'package:morshd/features/home/chat_bot_text/ui/widgets/message_user_and_bot_text.dart';

class ChatBotScreenText extends StatelessWidget {
  const ChatBotScreenText({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Chat Bot',
          style: TextStyle(
            color: Colors.orange,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: MessageUserAndBotText(),
          ),
          ChatBotFormText(),
        ],
      ),
    );
  }
}
