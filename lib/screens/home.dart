import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screens/home_professor_tab.dart';
import 'package:project/screens/home_subjects_tab.dart';
import 'package:project/screens/drawer_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/styles/style.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';

Firestore firestore = Firestore.instance;

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}



class HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {


    double width = MediaQuery.of(context).size.width;

    return MaterialApp(
      home: Scaffold(
        drawer: DrawerScreen(),
        backgroundColor: Colors.white,
        appBar: new AppBar(
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
                            padding: EdgeInsets.only(left: width/12.5 ,right: width/12.5),
                            child: TabBar(
                              indicatorSize: TabBarIndicatorSize.label,
                              indicator: BubbleTabIndicator(
                                indicatorColor: Colors.white,
                                indicatorHeight: 20.0,
                                tabBarIndicatorSize: TabBarIndicatorSize.label
                              ),
                              unselectedLabelColor: Colors.white,
                              labelColor: Style.mainTheme.primaryColor,
                              tabs: [
                                new Tab(child: Text("Disciplinas")),
                                new Tab(child: Text("Professores")),
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
                      SubjectsTab(),
                      ProfessorTab(),
                    ],
                  ) ,
                )
              ],
            ))
      ),
    );
  }
}
