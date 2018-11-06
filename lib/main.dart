import 'package:flutter/material.dart';
import 'package:project/infoHome.dart';
import 'package:project/send.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'InfoProvas',
      home: new InfoHome(),
      routes: <String, WidgetBuilder>{
        '/send': (BuildContext context) => SendPage()
      },
    );
  }
}