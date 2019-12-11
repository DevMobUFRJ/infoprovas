import 'package:flutter/material.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/widgets/exam_tile.dart';

class SubjectExamTab extends StatefulWidget {
  final List<Exam> _exams;

  SubjectExamTab(this._exams);

  @override
  _SubjectExamTabState createState() => _SubjectExamTabState();
}

class _SubjectExamTabState extends State<SubjectExamTab> {
  @override
  Widget build(BuildContext context) {
    return widget._exams.isEmpty
        ? Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Style.mainTheme.primaryColor),
            ),
          )
        : ListView.builder(
            physics: ScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            itemCount: widget._exams.length,
            itemBuilder: (context, index) =>
                ExamTile(widget._exams[index], "prova"),
          );
  }
}
