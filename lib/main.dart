import 'package:flutter/material.dart';
import 'package:infoprovas/screens/home.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:infoprovas/screens/about.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
        defaultBrightness: Brightness.light,
        data: (brightness) => ThemeData(
              primarySwatch: Colors.teal,
              brightness: brightness,
            ),
        themedWidgetBuilder: (context, theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'InfoProvas',
            theme: theme,
            home: Home(),
            routes: <String, WidgetBuilder>{
              'about': (context) => About(),
            },
          );
        });
  }
}