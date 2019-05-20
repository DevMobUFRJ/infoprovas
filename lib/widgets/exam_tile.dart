import 'package:flutter/material.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/utils/database_helper.dart';

class ExamTile extends StatefulWidget {
  final Exam _exam;

  ExamTile(this._exam);

  @override
  _ExamTileState createState() => _ExamTileState();
}

class _ExamTileState extends State<ExamTile> {

  // função de teste, deleta a prova ao clicar no item
  void _deleteExam() async {
    await DatabaseHelper.internal().deleteExam(widget._exam.id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "${widget._exam.subject} - ${widget._exam.professorName}",
            ),
            subtitle: Text(
              "${widget._exam.type} - ${widget._exam.year}.${widget._exam.semester}",
            ),
            onTap: _deleteExam,
          ),
        ],
      ),
    );
  }
}
