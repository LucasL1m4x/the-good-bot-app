import 'package:flutter/material.dart';
import 'package:the_good_bot_app/views/chat_page.dart';
import 'package:the_good_bot_app/views/home_page.dart';



void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/chat_page': (context) => ChatPage(),
      },
    );
  }
}

