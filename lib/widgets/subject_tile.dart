import 'package:flutter/material.dart';
import 'package:infoprovas/model/subject.dart';
import 'package:infoprovas/screens/subject_exam.dart';

class SubjectTile extends StatelessWidget {
  int period;
  final Subject _subject;
  SubjectTile(this._subject, this.period);

  Widget _selectSubject(Subject _subject) {
    if (period == 0) {
      return CreateTileSubject(_subject);
    } else if (period == 9 && _subject.period == 0) {
      return CreateTileSubject(_subject);
    } else if (_subject.period == period) {
      return CreateTileSubject(_subject);
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          _selectSubject(_subject),
        ],
      );
}

class CreateTileSubject extends StatelessWidget {
  Subject _subject;

  CreateTileSubject(this._subject);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            _subject.name,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20),
          ),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => SubjectExam(_subject)));
          },
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Container(
            height: 0.5,
            color: Colors.black12,
          ),
        )
      ],
    );
  }
}

