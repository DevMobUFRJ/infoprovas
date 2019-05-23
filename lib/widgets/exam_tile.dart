import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/utils/database_helper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:infoprovas/screens/exam_view.dart';
import 'package:infoprovas/styles/style.dart';

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
    return Slidable(
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
      child: Card(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 0, top: 0),
          child: ListTile(
            leading: Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Style.mainTheme.primaryColor,
              ),
              child: Center(
                child: Text(
                  dateFormat(
                      "${widget._exam.year}", "${widget._exam.semester}"),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
            ),
            title: Text(
              "${widget._exam.subject}",
            ),
            subtitle: Text("${widget._exam.professorName}"),
            onTap: openExamView,
          ),
        ),
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
    );
  }
}

String dateFormat(String year, String semester) {
  return "${year.substring(2, 4)}.${semester}";
}
