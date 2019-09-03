import 'dart:async';
import 'package:floating_search_bar/floating_search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:infoprovas/model/search_item.dart';
import 'package:infoprovas/screens/home_professor_tab.dart';
import 'package:infoprovas/screens/home_subjects_tab.dart';
import 'package:infoprovas/screens/drawer_screen.dart';
import 'package:infoprovas/screens/search.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:infoprovas/repository/professor_repository.dart';
import 'package:infoprovas/repository/subject_repository.dart';
import 'package:infoprovas/model/professor.dart';
import 'package:infoprovas/model/subject.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  List<Subject> _subject = <Subject>[];
  List<Professor> _professor = <Professor>[];
  List<SearchItem> _searchList = <SearchItem>[];
  String title = "InfoProvas";

  @override
  void initState() {
    super.initState();
    listenForProfessor();
    listenForSubject();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerScreen(),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Style.mainTheme.primaryColor,
        title: Text("InfoProvas"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              populateSearchList();
              showSearch(
                context: context,
                delegate: SearchPage(
                    professor: _professor,
                    searchList: _searchList,
                    subject: _subject),
              );
            },
          ),
        ],
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: <Widget>[
            Material(
              elevation: 2.0,
              child: Container(
                width: screenWidth,
                color: Style.mainTheme.primaryColor,
                child: Column(
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
                      tabs: [
                        Tab(child: Text("Disciplinas")),
                        Tab(child: Text("Professores")),
                      ],
                    ),
                  ],
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

  void populateSearchList() {
    _searchList.clear();
    _subject.forEach((subject) =>
        _searchList.add(SearchItem(name: subject.name, type: "subject")));
    _professor.forEach((professor) =>
        _searchList.add(SearchItem(name: professor.name, type: "professor")));
  }

  void listenForSubject() async {
    try {
      _subject.addAll(await getSubject());
      _subject
          .sort((a, b) => removeAccent(a.name).compareTo(removeAccent(b.name)));
      setState(() {});
    } catch (e) {
      onFailedConnection();
    }
  }

  void listenForProfessor() async {
    try {
      _professor.addAll(await getProfessor());
      _professor
          .sort((a, b) => removeAccent(a.name).compareTo(removeAccent(b.name)));
      setState(() {});
    } catch (e) {}
  }

  void onFailedConnection() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "Não foi possível conectar a rede",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Style.mainTheme.primaryColor,
        duration: Duration(minutes: 5),
        action: SnackBarAction(
          label: "Tentar novamente",
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              listenForProfessor();
              listenForSubject();
            });
          },
        ),
      ),
    );
  }

  String removeAccent(String name) {
    switch (name[0]) {
      case "Á":
        return "A" + name.substring(1);
      case "É":
        return "E" + name.substring(1);
      case "Í":
        return "I" + name.substring(1);
      case "Ó":
        return "O" + name.substring(1);
      case "Ú":
        return "U" + name.substring(1);
      default:
        return name;
    }
  }
}
