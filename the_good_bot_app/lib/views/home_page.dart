import 'package:flutter/material.dart';
import 'package:the_good_bot_app/widgets/confirm_delete.dart';
import '../repository/bot_repository.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  BotRepository botRepository = new BotRepository();
  Confirm confirm = new Confirm();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(238, 15, 82, .9),
        title: Text("The Good Bot"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: () {
              confirm.deleteDialog(context);
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.only(top: 60, left: 40, right: 40),
        color: Color.fromRGBO(247, 247, 247, .9),
        child: ListView(
          children: <Widget>[
            SizedBox(
              width: 400,
              height: 300,
              child: Image.asset("assets/logo.png"),
            ),
            SizedBox(
              height: 20,
            ),
            RaisedButton(
              color: Color.fromRGBO(238, 15, 82, .9),
              onPressed: () async {
                await Navigator.pushNamed(
                  context,
                  "/chat_page",
                );
              },
              child:
                  const Text('Abrir o ChatBot', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
