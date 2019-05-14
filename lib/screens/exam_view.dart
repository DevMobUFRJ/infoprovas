import 'package:flutter/material.dart';
import 'package:project/styles/style.dart';
import 'package:project/model/exam.dart';

class ExamView extends StatefulWidget {
  Exam _exam;

  ExamView(this._exam);

  @override
  _ExamViewState createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
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
