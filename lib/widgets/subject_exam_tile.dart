import 'package:flutter/material.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/screens/exam_view.dart';

class SubjectExamTile extends StatefulWidget {
  final Exam _exam;

  SubjectExamTile(this._exam);

  @override
  _SubjectExamTileState createState() => _SubjectExamTileState();
}

class _SubjectExamTileState extends State<SubjectExamTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "${widget._exam.type} - ${widget._exam.year}.${widget._exam.semester}",
            ),
            subtitle: Text(
              "${widget._exam.professorName}",
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
