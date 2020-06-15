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
      columns: [
        "name",
        "text",
        "ChatMessageType",
      ],
    );

    // Converte a lista de Maps para Lista de chat
    List<ChatMessage> listaChat = new List<ChatMessage>();
    for (Map i in result) {
      listaChat.add(ChatMessage.fromMap(i));
    }

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

  Future<int> createRaw(ChatMessage chatMessage) async {
    var connection = await _databaseHelper.connection;
    var sqlCommand = " INSERT INTO ChatMessage ( " +
        "  name , " +
        "  text , " +
        "  ChatMessageType , " +
        "VALUES ( " +
        "    '${chatMessage.name}' , " +
        "    '${chatMessage.text}' , " +
        "    ${chatMessage.type}, " +
        "  ) ";

    var result = await connection.rawInsert(sqlCommand);
    return result;
  }

  Future<ChatMessage> get(String name) async {
    var connection = await _databaseHelper.connection;
    List<Map> results = await connection.query(
      "ChatMessage",
      columns: [
        "name",
        "text",
        "ChatMessageType"
      ],
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


}