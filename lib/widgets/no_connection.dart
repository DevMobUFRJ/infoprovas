import 'package:flutter/material.dart';
import 'package:infoprovas/styles/style.dart';

class NoConnection extends StatelessWidget {
  final Function onPressed;

  NoConnection(this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.cloud_off),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Sem conexão com a internet',
            ),
          ),
          FlatButton(
            onPressed: onPressed,
            textColor: Style.mainTheme.primaryColor,
            child: Text("TENTAR NOVAMENTE"),
          ),
        ],
      ),
    );
  }
}
