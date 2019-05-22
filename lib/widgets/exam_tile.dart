import 'package:flutter/material.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/utils/database_helper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:infoprovas/screens/exam_view.dart';

class ExamTile extends StatefulWidget {
  final Exam _exam;

  ExamTile(this._exam);

  @override
  _ExamTileState createState() => _ExamTileState();
}

class _ExamTileState extends State<ExamTile> {

  // remove prova do sqflite
  void _deleteExam() async {
    await DatabaseHelper.internal().deleteExam(widget._exam.id);
  }

  // abre tela de visualização da prova
  void openExamView() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ExamView(widget._exam)));
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Slidable(
        key: Key(widget._exam.id.toString()),
        direction: Axis.horizontal,
        dismissal: SlidableDismissal(
          child: SlidableDrawerDismissal(),
          onDismissed: (actionType) {
            // TODO: implementar snackbar por deletar prova (no ListTile tambem)
            _deleteExam();
          },
        ),
        actionPane: SlidableScrollActionPane(),
        actionExtentRatio: 0.2,
        child: ListTile(
          title: Text(
            "${widget._exam.subject} - ${widget._exam.professorName}",
          ),
          subtitle: Text(
            "${widget._exam.type} - ${widget._exam.year}.${widget._exam.semester}",
          ),
          onTap: openExamView,
        ),
        secondaryActions: <Widget>[
          IconSlideAction(
            caption: 'Remover',
            color: Colors.red[400],
            icon: Icons.delete,
            onTap: () {
              _deleteExam();
            },
          ),
        ],
      ),
    );
  }
}
