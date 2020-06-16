import 'dart:convert';

class ChatMessage {
  ChatMessage({
    this.id,
    this.name,
    this.text,
    this.type,
  });

  final int id;
  final String name;
  final String text;
  final String type;

  ChatMessage chatMessageFromJson(String str) =>
      ChatMessage.fromMap(json.decode(str));

  String chatMessageToJson(ChatMessage data) => json.encode(data.toMap());
  factory ChatMessage.fromMap(Map<String, dynamic> json) => ChatMessage(
        id: json["id"],
        name: json["name"],
        text: json["text"],
        type: json["type"],
      );

  Map<String, dynamic> toMap() =>
      {"id": id, "name": name, "text": text, "type": type};
}
