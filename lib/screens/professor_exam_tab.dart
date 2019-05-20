import 'package:flutter/material.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/widgets/professor_exam_tile.dart';

class ProfessorExamTab extends StatefulWidget {
  List<Exam> _exams = <Exam>[];

  ProfessorExamTab(this._exams);

  @override
  _ProfessorExamTabState createState() => _ProfessorExamTabState();
}

class _ProfessorExamTabState extends State<ProfessorExamTab> {
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
      itemBuilder: (context, index) => ProfessorExamTile(widget._exams[index]),
    );
  }
}
