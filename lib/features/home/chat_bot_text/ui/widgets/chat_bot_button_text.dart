import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:morshd/features/home/chat_bot_text/ui/chat_bot_screen_text.dart';


class ChatBotButtonText extends StatelessWidget {
  const ChatBotButtonText({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => const ChatBotScreenText()));
      },
      backgroundColor: Colors.white,
      child: FaIcon(
        FontAwesomeIcons.robot,
        color: Colors.white,
      ),
    );
  }
}

