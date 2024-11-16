class ChatBotResponseText {
  final String response;

  ChatBotResponseText({required this.response});

  factory ChatBotResponseText.fromJson(Map<String, dynamic> json) {
    return ChatBotResponseText(
      response: json['response'],
    );
  }
}
