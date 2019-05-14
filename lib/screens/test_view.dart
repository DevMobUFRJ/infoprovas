import 'package:flutter/material.dart';
import 'package:project/styles/style.dart';
import 'package:project/model/test.dart';

class TestView extends StatefulWidget {
  Test _test;

  TestView(this._test);

  @override
  _TestViewState createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Style.mainTheme.primaryColor,
        title: Text("InfoProvas"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save, color: Colors.white,), onPressed: null)
        ],
      ),
      body: Container(),
    );
  }
}
