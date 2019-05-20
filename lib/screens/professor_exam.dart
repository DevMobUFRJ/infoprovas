import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infoprovas/model/professor.dart';
import 'package:infoprovas/repository/professor_exam_repository.dart';
import 'package:infoprovas/screens/professor_exam_tab.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:infoprovas/model/exam.dart';

class ProfessorExam extends StatefulWidget {
  Professor _professor;

  ProfessorExam(this._professor);

  @override
  _ProfessorExamState createState() => _ProfessorExamState();
}

class _ProfessorExamState extends State<ProfessorExam>
    with TickerProviderStateMixin {
  List<Exam> _exams = <Exam>[];
  List<String> _types = [];
  Map<String, Exam> map;

  @override
  void initState() {
    super.initState();
    listenForExams();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Style.mainTheme.primaryColor,
        title: Text("${widget._professor.name}"),
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
                                  tabBarIndicatorSize:
                                      TabBarIndicatorSize.label,
                                ),
                                unselectedLabelColor: Colors.white,
                                labelColor: Style.mainTheme.primaryColor,
                                tabs: _types
                                    .map((type) => Tab(child: Text(type)))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: _types.map((type) => ProfessorExamTab(_exams.where((Exam e) => e.type == type).toList())).toList(),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  void listenForExams() async {
    final Stream<Exam> stream = await getProfessorExams(widget._professor.id);
    stream.listen(
      (Exam exam) => setState(
            () {
              exam.professorName = widget._professor.name;
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
