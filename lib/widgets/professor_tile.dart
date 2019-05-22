import 'package:flutter/material.dart';
import 'package:infoprovas/model/professor.dart';
import 'package:infoprovas/screens/professor_exam.dart';

class ProfessorTile extends StatelessWidget {
  final Professor _professor;
  ProfessorTile(this._professor);

  @override
  Widget build(BuildContext context) => Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              ListTile(
                title: Text(
                  _professor.name,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProfessorExam(_professor))),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Container(
                  height: 0.5,
                  color: Colors.black12,
                ),
              )
            ],
          )
        ],
      );
}
