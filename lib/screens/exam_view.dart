import 'package:flutter/material.dart';
import 'package:project/styles/style.dart';
import 'package:project/model/exam.dart';
import 'package:project/utils/database_helper.dart';
import 'package:project/screens/saved_exams.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ExamView extends StatefulWidget {
  Exam _exam;

  ExamView(this._exam);

  @override
  _ExamViewState createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {

  void saveExam() async {
    if (await DatabaseHelper.internal().saveExam(widget._exam))
      showSnackBar();
    else {
      // TODO: implementar abrir prova salva
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SavedExams()));
    }
  }

  void showSnackBar() {
    String message = "Prova salva com sucesso";
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(message),
        ),
        backgroundColor: Style.mainTheme.primaryColor,
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Style.mainTheme.primaryColor,
        title: Text("InfoProvas"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.save,
              color: Colors.white,
            ),
            onPressed: saveExam,
          )
        ],
      ),
      body: Container(),
    );
  }
}
