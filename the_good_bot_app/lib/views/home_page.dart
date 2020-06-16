import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(238, 15, 82, .9),
          title: Text("The Good Bot"),
          <Widget>[
                 IconButton(
            icon: Icon(Icons.delete_sweep),
            onPressed: () {
              botRepository.deleteAll();
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

              child: const Text('Abrir o ChatBot', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
