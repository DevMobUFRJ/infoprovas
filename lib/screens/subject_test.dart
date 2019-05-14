import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project/styles/style.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:project/model/subject.dart';
import 'package:project/model/test.dart';
import 'package:project/repository/subject_test_repository.dart';
import 'package:project/screens/subject_test_tab.dart';

class SubjectTest extends StatefulWidget {
  Subject _subject;

  SubjectTest(this._subject);

  @override
  _SubjectTestState createState() => _SubjectTestState();
}

class _SubjectTestState extends State<SubjectTest>
    with TickerProviderStateMixin {
  List<Test> _tests = <Test>[];
  List<String> _types = [];

  @override
  void initState() {
    super.initState();
    listenForTests();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Style.mainTheme.primaryColor,
        title: Text("${widget._subject.name}"),
        elevation: 0,
      ),
      body: _types.isEmpty ? Center(child: CircularProgressIndicator()): DefaultTabController(
        length: _types.length,
        child: Column(
          children: <Widget>[
            Material(
              elevation: 2.0,
              child: Container(
                color: Style.mainTheme.primaryColor,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          left: width / 12.5,
                          right: width / 12.5,
                        ),
                        child: TabBar(
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BubbleTabIndicator(
                            indicatorColor: Colors.white,
                            indicatorHeight: 20.0,
                            tabBarIndicatorSize: TabBarIndicatorSize.label,
                          ),
                          unselectedLabelColor: Colors.white,
                          labelColor: Style.mainTheme.primaryColor,
                          tabs: _types.map((type) => Tab(child: Text(type))).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: _types.map((type) => SubjectTestTab(_tests.where((Test t) => t.type == type).toList())).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void listenForTests() async {
    final Stream<Test> stream = await getTests(widget._subject.id);
    stream.listen(
      (Test test) => setState(
            () {
              _tests.add(test);
              if (_types != null) {
                if (!_types.contains(test.type)) {
                  _types.add(test.type);
                }
              }
            },
          ),
    );
  }
}
