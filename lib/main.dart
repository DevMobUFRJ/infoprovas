import 'package:flutter/material.dart';
import 'package:project/screens/home.dart';
import 'package:project/styles/style.dart';
import 'package:project/screens/about.dart';
import 'package:project/screens/saved_exams.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InfoProvas',
      theme: ThemeData(
        brightness: Style.mainTheme.brightness,
        primaryColor: Style.mainTheme.primaryColor,
        accentColor: Style.mainTheme.accentColor,
        accentColorBrightness: Brightness.light
      ),
      home: Home(),
      routes: <String, WidgetBuilder>{
        'about': (context) => About(),
      },
    );
  }
}