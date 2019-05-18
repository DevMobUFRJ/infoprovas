import 'package:flutter/material.dart';
import 'package:project/styles/style.dart';
import 'package:project/model/exam.dart';
import 'package:project/widgets/exam_tile.dart';
import 'package:project/utils/database_helper.dart';

class SavedExams extends StatefulWidget {
  @override
  _SavedExamsState createState() => _SavedExamsState();
}

class _SavedExamsState extends State<SavedExams> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                return ExamTile(exam);
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
