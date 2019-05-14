import 'package:flutter/material.dart';
import 'package:project/styles/style.dart';
import 'package:project/model/test.dart';
import 'package:project/widgets/test_tile.dart';
import 'package:project/widgets/subject_test_tile.dart';

class SubjectTestTab extends StatefulWidget {
  List<Test> _tests = <Test>[];

  SubjectTestTab(this._tests);

  @override
  _SubjectTestTabState createState() => _SubjectTestTabState();
}

class _SubjectTestTabState extends State<SubjectTestTab> {
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
            itemBuilder: (context, index) => SubjectTestTile(widget._tests[index]),
          );
  }
}
