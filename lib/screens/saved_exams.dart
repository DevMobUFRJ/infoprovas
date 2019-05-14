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

  // função pra teste, salva uma nova prova na database
  void saveNewExam() async {
    List<Exam> list = await DatabaseHelper.internal().getSavedExams();
    Exam exam;
    if (list.length == 0) {
      exam = Exam(1, 2015, 1, "Adriano", "Prova 1", "Computação 1");
    } else {
      Exam lastExam = await DatabaseHelper.internal().getLastExam();
      exam = Exam(lastExam.id + 1, lastExam.year + 1, 1, "Adriano", "Prova 1",
          "Computação 1");
    }
    await DatabaseHelper.internal().saveExam(exam);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Provas Salvas"),
        backgroundColor: Style.mainTheme.primaryColor,
        elevation: 0.0,
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Style.mainTheme.primaryColor,
        onPressed: saveNewExam,
      ),
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
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
