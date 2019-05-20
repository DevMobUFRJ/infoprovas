import 'package:flutter/material.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/screens/exam_view.dart';

class ProfessorExamTile extends StatefulWidget {
  final Exam _exam;

  ProfessorExamTile(this._exam);

  @override
  _ProfessorExamTileState createState() => _ProfessorExamTileState();
}

class _ProfessorExamTileState extends State<ProfessorExamTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "${widget._exam.subject}",
            ),
            subtitle: Text(
              "${widget._exam.year}.${widget._exam.semester}",
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => ExamView(widget._exam)));
            },
          ),
        ],
      ),
    );
  }
}
