import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/home_professor_tab.dart';
import 'package:project/screens/home_subjects_tab.dart';
import 'package:project/screens/drawer_screen.dart';
import 'package:project/styles/style.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:project/repository/professor_repository.dart';
import 'package:project/repository/subject_repository.dart';
import 'package:project/model/professor.dart';
import 'package:project/model/subject.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Subject> _subject = <Subject>[];
  List<Professor> _professor = <Professor>[];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    listenForProfessor();
    listenForSubject();
  }

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      drawer: DrawerScreen(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Style.mainTheme.primaryColor,
        title: Text("InfoProvas"),
        elevation: 0.0,
      ),
      body: DefaultTabController(
        length: 2,
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
                          tabs: [
                            Tab(child: Text("Disciplinas")),
                            Tab(child: Text("Professores")),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  SubjectsTab(_subject),
                  ProfessorTab(_professor),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void listenForSubject() async {
    final Stream<Subject> stream = await getSubject();
    stream.listen((Subject subject) => setState(() => _subject.add(subject)));
  }

  void listenForProfessor() async {
    final Stream<Professor> stream = await getProfessor();
    stream.listen(
        (Professor professor) => setState(() => _professor.add(professor)));
  }
}
