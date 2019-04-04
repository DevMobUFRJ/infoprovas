import 'package:flutter/material.dart';
import '../model/professor.dart';

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
                  style: TextStyle(fontSize: 20, color: Colors.black87),
                ),
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
