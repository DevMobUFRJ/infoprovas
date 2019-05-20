import 'package:flutter/material.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/widgets/subject_exam_tile.dart';

class SubjectExamTab extends StatefulWidget {
  List<Exam> _exams = <Exam>[];

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
          ))
        : ListView.builder(
            physics: ScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: widget._exams.length,
            itemBuilder: (context, index) => SubjectExamTile(widget._exams[index]),
          );
  }
}
