import 'package:flutter/material.dart';
import 'package:project/styles/style.dart';
import 'package:project/model/test.dart';
import 'package:project/screens/test_view.dart';

class ProfessorTestTile extends StatefulWidget {
  final Test _test;

  ProfessorTestTile(this._test);

  @override
  _ProfessorTestTileState createState() => _ProfessorTestTileState();
}

class _ProfessorTestTileState extends State<ProfessorTestTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "${widget._test.subject}",
            ),
            subtitle: Text(
              "${widget._test.year}.${widget._test.semester}",
            ),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => TestView(widget._test)));
            },
          ),
        ],
      ),
    );
  }
}
