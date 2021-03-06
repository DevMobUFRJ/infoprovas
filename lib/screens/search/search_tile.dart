import 'package:flutter/material.dart';
import 'package:infoprovas/model/professor.dart';
import 'package:infoprovas/model/subject.dart';
import 'package:infoprovas/screens/professors_tab/professor_exams.dart';
import 'package:infoprovas/screens/subjects_tab/subject_exams.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

class SearchTile extends StatelessWidget {
  final String name;
  final String type;
  final Professor professor;
  final Subject subject;

  SearchTile(
      {@required this.name, @required this.type, this.professor, this.subject});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: identical(type, "professor")
          ? Icon(OMIcons.person)
          : Icon(OMIcons.book),
      title: Text(name),
      onTap: () {
        if (identical(type, "professor")) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfessorExam(professor),
            ),
          );
        } else if (identical(type, "subject")) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubjectExam(subject),
            ),
          );
        }
      },
    );
  }
}
