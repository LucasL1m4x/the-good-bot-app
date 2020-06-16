import 'package:the_good_bot_app/models/chat_message.dart';
import 'package:the_good_bot_app/widgets/chat_message_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogflow/dialogflow_v2.dart';
import 'package:the_good_bot_app/repository/bot_repository.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _messageList = <ChatMessage>[];
  final _controllerText = new TextEditingController();

  BotRepository botRepository = new BotRepository();

  @override
  void dispose() {
    super.dispose();
    _controllerText.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(238, 15, 82, .9),
        title: Text('ChatBot'),
      ),
      body: Column(
        children: <Widget>[
          _buildList(),
          Divider(height: 1.0),
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildList() {
    return Flexible(
      child: FutureBuilder(
        future: botRepository.findAll(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return ListView.builder(
              padding: EdgeInsets.all(8.0),
              reverse: true,
              itemBuilder: (_, int index) =>
                  ChatMessageListItem(chatMessage: snapshot.data[index]),
              itemCount: snapshot.data.length,
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  void _sendMessage({String text}) {
    _controllerText.clear();
    _addMessage(name: 'Flávio Moreni', text: text, type: 'sent');
  }

  void _addMessage({String name, String text, String type}) {
    var message = ChatMessage(text: text, name: name, type: type);
    setState(() {
      _messageList.insert(0, message);
      if (!(text == 'Escrevendo...')) {
        botRepository.create(message);
      }
    });

    if (type == 'sent') {
      _dialogFlowRequest(query: message.text);
    }
  }

  Future _dialogFlowRequest({String query}) async {
    _addMessage(name: 'O bom robô', text: 'Escrevendo...', type: 'received');

    AuthGoogle authGoogle =
        await AuthGoogle(fileJson: "assets/credentials.json").build();
    Dialogflow dialogflow =
        Dialogflow(authGoogle: authGoogle, language: "pt-BR");
    AIResponse response = await dialogflow.detectIntent(query);

    setState(() {
      _messageList.removeAt(0);
    });

    _addMessage(
        name: 'O bom robô',
        text: response.getMessage() ?? '',
        type: 'received');
  }

  Widget _buildTextField() {
    return new Flexible(
      child: new TextField(
        controller: _controllerText,
        decoration: new InputDecoration.collapsed(
          hintText: "Enviar mensagem",
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return new Container(
      margin: new EdgeInsets.only(left: 8.0),
      child: new IconButton(
          icon: new Icon(Icons.send, color: Color.fromRGBO(238, 15, 82, .9)),
          onPressed: () {
            if (_controllerText.text.isNotEmpty) {
              _sendMessage(text: _controllerText.text);
            }
          }),
    );
  }

  Widget _buildUserInput() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: new Row(
        children: <Widget>[
          _buildTextField(),
          _buildSendButton(),
        ],
      ),
    );
  }
}
