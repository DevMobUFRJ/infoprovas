import 'package:flutter/material.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/widgets/exam_tile.dart';
import 'package:infoprovas/utils/database_helper.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class SavedExams extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Provas Salvas"),
        backgroundColor: Style.mainTheme.primaryColor,
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: null,
          ),
        ],
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  // atualiza a lista de provas e mostra snackbar de prova removida
  updateExamList(String subject) async {
    setState(() {});
    showSnackBar("Prova de $subject removida");
  }

  showSnackBar(String message) {
    Scaffold.of(context).showSnackBar(
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
    return FutureBuilder<List<dynamic>>(
      future: DatabaseHelper.internal().getSavedExams(),
      builder: (_, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return ListView.builder(
              physics: ScrollPhysics(parent: BouncingScrollPhysics()),
              itemCount: snapshot.data.length,
              itemBuilder: (_, int index) {
                Exam exam = snapshot.data[index];
                return ExamTile(
                  exam,
                  updateExamList: updateExamList,
                  showSnackBar: showSnackBar,
                );
              },
            );
          } else {
            return Center(
              child: Container(
                child: Text("Não há provas salvas"),
              ),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
