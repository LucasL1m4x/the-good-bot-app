import 'package:the_good_bot_app/models/chat_message.dart';
import 'package:the_good_bot_app/repository/database_helper.dart';

class BotRepository {
  // Instancia do Database Helper
  DatabaseHelper _databaseHelper;

  // Construtor
  BotRepository() {
    _databaseHelper = new DatabaseHelper();
  }

  Future<List<ChatMessage>> findAll() async {
    var connection = await _databaseHelper.connection;
    var result = await connection.query(
      "ChatMessage",
      columns: ["id", "name", "text", "type"],
    );
    List<ChatMessage> listaChat = [];

    result.forEach((element) {
      listaChat.add(ChatMessage.fromMap(element));
    });

    return listaChat;
  }

  Future<int> create(ChatMessage chatMessage) async {
    var connection = await _databaseHelper.connection;
    var result = await connection.insert(
      "ChatMessage",
      chatMessage.toMap(),
    );
    return result;
  }

  Future<ChatMessage> get(String name) async {
    var connection = await _databaseHelper.connection;
    List<Map> results = await connection.query(
      "ChatMessage",
      columns: ["name", "text", "ChatMessageType"],
      where: 'name = ?',
      whereArgs: ['name'],
    );

    if (results.length > 0) {
      return ChatMessage.fromMap(
        results.first,
      );
    } else {
      return null;
    }
  }

  Future<ChatMessage> getRaw(String name) async {
    var connection = await _databaseHelper.connection;
    var sqlCommand = "SELECT * FROM ChatMessage WHERE ID = $name  ";

    var results = await connection.rawQuery(sqlCommand);
    if (results.length > 0) {
      return new ChatMessage.fromMap(results.first);
    } else {
      return null;
    }
  }

  Future<List<ChatMessage>> deleteAll() async {
    var connection = await _databaseHelper.connection;
    var sqlCommand = "DELETE FROM ChatMessage";
    await connection.rawQuery(sqlCommand);
    return findAll();
  }
}
