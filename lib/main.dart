import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/screens/course_selection.dart';
import 'package:project/styles/style.dart';
import 'package:project/screens/about.dart';
import 'package:project/screens/saved_tests.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InfoProvas',
      theme: Style.mainTheme,
      home: CourseSelection(),
      routes: <String, WidgetBuilder>{
        'about': (context) => About(),
        'savedtests': (context) => SavedTests(),
      },
    );
  }
}