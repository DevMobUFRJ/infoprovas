import 'dart:async';

import 'package:flutter/material.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:infoprovas/model/subject.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/repository/subject_exam_repository.dart';
import 'package:infoprovas/screens/subject_exam_tab.dart';

class SubjectExam extends StatefulWidget {
  Subject _subject;

  SubjectExam(this._subject);

  @override
  _SubjectExamState createState() => _SubjectExamState();
}

class _SubjectExamState extends State<SubjectExam>
    with TickerProviderStateMixin {
  List<Exam> _exams = <Exam>[];
  List<String> _types = [];

  @override
  void initState() {
    super.initState();
    listenForExams();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Style.mainTheme.primaryColor,
        title: Text("${widget._subject.name}"),
        elevation: 0,
      ),
      body: _types.isEmpty
          ? Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: _types.length,
              child: Column(
                children: <Widget>[
                  Material(
                    elevation: 2.0,
                    child: Container(
                      width: screenWidth,
                      color: Style.mainTheme.primaryColor,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          TabBar(
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicator: BubbleTabIndicator(
                              indicatorColor: Colors.white,
                              indicatorHeight: 20.0,
                              tabBarIndicatorSize: TabBarIndicatorSize.label,
                            ),
                            unselectedLabelColor: Colors.white,
                            labelColor: Style.mainTheme.primaryColor,
                            tabs: _types
                                .map((type) => Tab(child: Text(type)))
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: _types
                          .map((type) => SubjectExamTab(_exams
                              .where((Exam e) => e.type == type)
                              .toList()))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void listenForExams() async {
    final Stream<Exam> stream = await getSubjectExams(widget._subject.id);
    stream.listen(
      (Exam exam) => setState(
            () {
              exam.subject = widget._subject.name;
              _exams.add(exam);
              if (_types != null) {
                if (!_types.contains(exam.type)) {
                  _types.add(exam.type);
                }
              }
            },
          ),
    );
  }
}
