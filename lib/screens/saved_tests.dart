import 'package:flutter/material.dart';

class SavedTests extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //TODO: criar layout
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Provas Salvas"),
        elevation: 2.0,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  "Prova salva",
                  style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                onTap: (){},
              ),
              Divider(
                color: Colors.black26,
              )
            ],
          ),
        ],
      ),
    );
  }
}
