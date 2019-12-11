import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/utils/database_helper.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:infoprovas/screens/exam_view.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/utils/main_functions.dart';
import 'package:path_provider/path_provider.dart';

class ExamTile extends StatefulWidget {
  final Exam _exam;
  final void Function(String) updateExamList;
  final void Function(String) showSnackBar;

  ExamTile(this._exam, {Key key, this.updateExamList, this.showSnackBar})
      : super(key: key);

  @override
  _ExamTileState createState() => _ExamTileState();
}

class _ExamTileState extends State<ExamTile> {
  // remove prova do sqflite
  void _deleteExam() async {
    await DatabaseHelper.internal()
        .deleteExam(widget._exam.id)
        .then((value) => value == 1 ? deleteFile() : null)
        .then((result) => result == null
            ? null
            : widget.updateExamList(widget._exam.subject));
  }

  // remove arquivo da prova do dispositivo
  Future<FileSystemEntity> deleteFile() async {
    String dir = (await getApplicationDocumentsDirectory()).path;
    String filename = "${widget._exam.id}.pdf";
    File file = File('$dir/$filename');
    try {
      return file.delete(recursive: true);
    } catch (e) {
      return null;
    }
  }

  // abre tela de visualização da prova
  void openExamView() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExamView(widget._exam),
      ),
    );
  }

  // abre caixa de dialogo de confirmação pra deletar prova
  showAlertDialog() {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Tem certeza que deseja deletar a prova?'),
          actions: <Widget>[
            FlatButton(
              child: Text('Não'),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            FlatButton(
              child: Text('Sim'),
              onPressed: () {
                Navigator.of(context).pop(true);
                _deleteExam();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(
        widget._exam.id.toString(),
      ),
      direction: Axis.horizontal,
      dismissal: SlidableDismissal(
        onWillDismiss: (actionType) => showAlertDialog(),
        child: SlidableDrawerDismissal(),
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
            title: Row(
              children: <Widget>[
                Text(getShortType(widget._exam.type)),
                Text(" - ${widget._exam.subject}"),
              ],
            ),
            subtitle: Text("${widget._exam.professorName}"),
            onTap: openExamView,
            onLongPress: () => widget.showSnackBar(
                "Deslize o item para a esquerda para ver mais informações"),
          ),
        ),
      ),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: 'Deletar',
          color: Colors.red[400],
          icon: Icons.delete_outline,
          onTap: () => showAlertDialog(),
        ),
      ],
    );
  }
}

String dateFormat(String year, String semester) =>
    "${year.substring(2, 4)}.$semester";
