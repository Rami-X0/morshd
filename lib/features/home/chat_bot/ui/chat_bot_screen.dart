import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:morshd/features/home/chat_bot/ui/widgets/choose_image.dart';
import 'package:morshd/features/home/chat_bot/ui/widgets/show_image_and_data.dart';

class ChatBotScreen extends StatelessWidget {
  const ChatBotScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: ShowImageAndData()),
            Divider(),
            ChooseImageDoctor(),
          ],
        ),
      ),
    );
  }
}
