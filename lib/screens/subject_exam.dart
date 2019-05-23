import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:infoprovas/model/subject.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/repository/subject_exam_repository.dart';
import 'package:infoprovas/screens/subject_exam_tab.dart';
import 'package:infoprovas/widgets/shorten_text.dart';

class SubjectExam extends StatefulWidget {
  Subject _subject;

  SubjectExam(this._subject);

  @override
  _SubjectExamState createState() => _SubjectExamState();
}

class _SubjectExamState extends State<SubjectExam>
    with TickerProviderStateMixin {
  List<Exam> _exams = <Exam>[];
  List<dynamic> _types = [];

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
                                .map((type) => Tab(child: ShortenText(type)))
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
    stream
        .listen(
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
    )
        .onDone(() {
      _types = orderTypesList();

      _exams.sort((a, b) =>
          (b.year).compareTo(a.year) + (b.semester).compareTo(a.semester));
    });
  }

  // ATENÇÃO GAMBIARRA !!!
  // ordenando lista de tipos de prova
  List<dynamic> orderTypesList() {
    List<dynamic> tempList = [];
    tempList.length = _types.length;

    for (int i = 0; i < _types.length; i++) {
      switch (_types[i]) {
        case "Prova 1":
          tempList[i] = 0;
          break;
        case "Prova 2":
          tempList[i] = 1;
          break;
        case "Prova 3":
          tempList[i] = 2;
          break;
        case "Prova Final":
          tempList[i] = 3;
          break;
        case "2ª Chamada":
          tempList[i] = 4;
          break;
        case "Outros":
          tempList[i] = 5;
          break;
      }
    }
    tempList.sort();
    for (int i = 0; i < tempList.length; i++) {
      switch (tempList[i]) {
        case 0:
          tempList[i] = "Prova 1";
          break;
        case 1:
          tempList[i] = "Prova 2";
          break;
        case 2:
          tempList[i] = "Prova 3";
          break;
        case 3:
          tempList[i] = "Prova Final";
          break;
        case 4:
          tempList[i] = "2ª Chamada";
          break;
        case 5:
          tempList[i] = "Outros";
          break;
      }
    }
    return tempList;
  }
}
