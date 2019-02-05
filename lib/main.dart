import 'package:flutter/material.dart';
import 'package:project/screens/course_selection.dart';
import 'package:project/styles/style.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'InfoProvas',
      theme: Style.themePrincipal,
      home: CourseSelection(),
      routes: <String, WidgetBuilder>{
        //'/send': (BuildContext context) => SendPage()
      },
    );
  }
}