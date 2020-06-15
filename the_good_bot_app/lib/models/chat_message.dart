import 'dart:convert';

enum ChatMessageType {sent, received}

class ChatMessage {
  ChatMessage({
    this.name,
    this.text,
    this.type,
  });

  final String name;
  final String text;
  final ChatMessageType type;

  factory ChatMessage.fromJson(String str) => ChatMessage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ChatMessage.fromMap(Map<String, dynamic> json) => ChatMessage(
    name: json["name"],
    text: json["text"],
    type: json["ChatMessageType"],
  );

  Map<String, dynamic> toMap() => {
    "name": name,
    "text": text,
    "ChatMessageType": type,
  };
}