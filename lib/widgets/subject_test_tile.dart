import 'package:flutter/material.dart';
import 'package:project/styles/style.dart';
import 'package:project/model/test.dart';
import 'package:project/screens/test_view.dart';

class SubjectTestTile extends StatefulWidget {
  final Test _test;

  SubjectTestTile(this._test);

  @override
  _SubjectTestTileState createState() => _SubjectTestTileState();
}

class _SubjectTestTileState extends State<SubjectTestTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "${widget._test.type} - ${widget._test.year}.${widget._test.semester}",
            ),
            subtitle: Text(
              "${widget._test.professorName}",
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
