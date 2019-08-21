import 'package:flutter/material.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/screens/exam_view.dart';

class ViewExamTile extends StatefulWidget {
  final Exam _exam;
  final String _tileType;

  ViewExamTile(this._exam, this._tileType);

  @override
  _ViewExamTileState createState() => _ViewExamTileState();
}

class _ViewExamTileState extends State<ViewExamTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 3, bottom: 3),
        child: ListTile(
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              //color: Style.mainTheme.primaryColor,
              color: Style.mainTheme.primaryColor,
            ),
            child: Center(
              child: Text(
                dateFormat("${widget._exam.year}", "${widget._exam.semester}"),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
          ),
          title: formatTitle(widget._tileType),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ExamView(widget._exam)));
          },
        ),
      ),
    );
  }

  String dateFormat(String year, String semester) =>
      "${year.substring(2, 4)}.$semester";

  Widget formatTitle(String tileType) {
    if (tileType.compareTo("professor") == 0) {
      return Text(
        "${widget._exam.subject}",
      );
    } else
      return Text(
        "${widget._exam.professorName}",
      );
  }
}
