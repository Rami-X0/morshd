class ChatBotRequestText {
  final String message;

  ChatBotRequestText({required this.message});

  Map<String, dynamic> toJson() {
    return {
      'message': message,
    };
  }
}
