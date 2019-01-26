import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../styles/style.dart';
import '../screens/subjectDetails.dart';
import '../config/globalState.dart';
import '../model/subject.dart';

class InfoHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

List<Subject> subjectsFiltered = GlobalState.subjects.where((i) => i.periodNumber == ( 1)).toList();

class HomeState extends State<InfoHome> {
  int _selectedPeriod = 0;
  GlobalState store = GlobalState.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: Style.themePrincipal,
      home: DefaultTabController(
          length: 2,
          child: Scaffold(
              drawer: Drawer(),
              backgroundColor: Colors.white,
              appBar: new AppBar(
                title: Text("InfoProvas"),
                elevation: 2.0,
                bottom: new TabBar(indicatorColor: Colors.white, tabs: [
                  new Tab(text: "Disciplina"),
                  new Tab(text: "Professor"),
                ]),
              ),
              body: TabBarView(children: [
                // TAB Disciplina
                new ListView(
                  padding: EdgeInsets.all(10.0),
                  children: <Widget>[
                   Column( children: <Widget>[
                     Row(               children: <Widget>[
                       new Expanded( child:
                       new SizedBox(
                           width: double.infinity,
                           // height: double.infinity,
                           child:
                       CupertinoButton(
                           child: new Text(GlobalState.periods[_selectedPeriod],
                                   style: new TextStyle(
                                       fontWeight: FontWeight.w700,
                                       color: Colors.white)),
                           padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                           borderRadius: BorderRadius.all(Radius.circular(5.0)),
                           pressedOpacity: 0.5,
                           color: Style.themePrincipal.primaryColor,
                           onPressed: () {
                             showModalBottomSheet(
                                 context: context,
                                 builder: (BuildContext context) {
                                   return Container(
                                     height: 140.0,
                                     child: Row(
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: <Widget>[
                                         Expanded(
                                           child: CupertinoPicker(
                                               scrollController:
                                               new FixedExtentScrollController(
                                                 initialItem: _selectedPeriod,
                                               ),
                                               itemExtent: 48.0,
                                               backgroundColor: Colors.white,
                                               onSelectedItemChanged: (int index) {
                                                 setState(() {
                                                   _selectedPeriod = index;
                                                   subjectsFiltered = GlobalState.subjects.where((i) => i.periodNumber == (index + 1)).toList();
                                                 });
                                               },
                                               children: new List<Widget>.generate(GlobalState.periods.length,
                                                       (int index) {
                                                     return new Center(
                                                       child:  new Text(GlobalState.periods[index], style: new TextStyle(
                                                           fontWeight: FontWeight.w600,
                                                           fontSize: 16.0,
                                                           color: Colors.black)),
                                                     );
                                                   }),
                                           ),
                                         ),
                                       ],
                                     ),
                                   );
                                 });
                           })))
                     ])]),
                   new Divider(color: Colors.black26),
                   ExpandableContainer(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return new Column(children: <Widget>[
                            new ListTile(
                              title: new Text(subjectsFiltered[index].name,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                  textAlign: TextAlign.center),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => SubjectDetail(subject: subjectsFiltered[index])));}
                            ),
                            new Divider(color: Colors.black26),
                          ]);
                        },
                        itemCount: subjectsFiltered.length,
                      ),
                    )
                  ],
                ),

                // TAB Professor
                new Container(
                    padding: new EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                    child: ExpandableContainer(
                      child: ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          return new Column(children: <Widget>[
                            new ListTile(
                              title: new Text(GlobalState.professors[index].name,
                                  style: new TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Colors.black),
                                  textAlign: TextAlign.center),
                            ),
                            new Divider(color: Colors.black26),
                          ]);
                        },
                        itemCount: GlobalState.professors.length,
                      ),
                    ))
              ])
      ),
    ));
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  ExpandableContainer({
    @required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 550.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height - 100.0;
    return new AnimatedContainer(
      duration: new Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? screenHeight : collapsedHeight,
      child: new Container(
        child: child,
      ),
    );
  }
}


