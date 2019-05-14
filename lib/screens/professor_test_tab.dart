import 'package:flutter/material.dart';
import 'package:project/styles/style.dart';
import 'package:project/model/test.dart';
import 'package:project/widgets/professor_test_tile.dart';
import 'package:project/widgets/subject_test_tile.dart';

class ProfessorTestTab extends StatefulWidget {
  List<Test> _tests = <Test>[];

  ProfessorTestTab(this._tests);

  @override
  _ProfessorTestTabState createState() => _ProfessorTestTabState();
}

class _ProfessorTestTabState extends State<ProfessorTestTab> {
  @override
  Widget build(BuildContext context) {
    return widget._tests.isEmpty
        ? Center(
        child: CircularProgressIndicator(
          valueColor:
          AlwaysStoppedAnimation<Color>(Style.mainTheme.primaryColor),
        ))
        : ListView.builder(
      physics: ScrollPhysics(parent: BouncingScrollPhysics()),
      itemCount: widget._tests.length,
      itemBuilder: (context, index) => ProfessorTestTile(widget._tests[index]),
    );
  }
}
