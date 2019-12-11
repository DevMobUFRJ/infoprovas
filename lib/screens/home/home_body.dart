import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter/material.dart';
import 'package:infoprovas/screens/professors_tab/home_professor_tab.dart';
import 'package:infoprovas/screens/subjects_tab/home_subjects_tab.dart';
import 'package:infoprovas/styles/style.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Material(
            elevation: 2.0,
            child: Container(
              width: double.maxFinite,
              color: Style.mainTheme.primaryColor,
              child: Column(
                children: <Widget>[
                  TabBar(
                    isScrollable: true,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicator: BubbleTabIndicator(
                      indicatorColor: Colors.white,
                      indicatorHeight: 20.0,
                      tabBarIndicatorSize:
                      TabBarIndicatorSize.label,
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
                SubjectsTab(),
                ProfessorTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
