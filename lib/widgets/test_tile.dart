import 'package:flutter/material.dart';
import 'package:project/styles/style.dart';
import 'package:project/model/test.dart';
import 'package:project/utils/database_helper.dart';

class TestTile extends StatefulWidget {
  final Test _test;

  TestTile(this._test);

  @override
  _TestTileState createState() => _TestTileState();
}

class _TestTileState extends State<TestTile> {

  // função de teste, deleta a prova ao clicar no item
  void _deleteTest() {
    DatabaseHelper.internal().deleteTest(widget._test.id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
              "${widget._test.subject} - ${widget._test.professorName}",
            ),
            subtitle: Text(
              "${widget._test.type} - ${widget._test.year}.${widget._test.semester}",
            ),
            onTap: _deleteTest,
          ),
        ],
      ),
    );
  }
}
