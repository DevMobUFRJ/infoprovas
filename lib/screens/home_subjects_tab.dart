import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/config/globalState.dart';
import 'package:project/model/subject.dart';
import 'package:project/screens/subjectDetails.dart';
import 'package:project/styles/style.dart';

class SubjectsTab extends StatefulWidget {
  @override
  _SubjectsTabState createState() => _SubjectsTabState();
}

//List<Subject> subjectsFiltered = GlobalState.subjects.where((i) => i.periodNumber == ( 1)).toList();

class _SubjectsTabState extends State<SubjectsTab> {
  int _selectedPeriod = 0;
  GlobalState store = GlobalState.instance;

  @override
  Widget build(BuildContext context) {
    return new ListView(
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
                                          //subjectsFiltered = GlobalState.subjects.where((i) => i.periodNumber == (index + 1)).toList();
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
          child: _buildSubjectsList(),
//          child: ListView.builder(
//            itemBuilder: (BuildContext context, int index) {
//              return new Column(children: <Widget>[
//                new ListTile(
//                    title: new Text(subjectsFiltered[index].name,
//                        style: new TextStyle(
//                            fontWeight: FontWeight.w400,
//                            color: Colors.black),
//                        textAlign: TextAlign.center),
//                    onTap: () {
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (_) => SubjectDetail(subject: subjectsFiltered[index])));}
//                ),
//                new Divider(color: Colors.black26),
//              ]);
//            },
//            itemCount: subjectsFiltered.length,
//          ),
        )
      ],
    );
  }

  Widget _buildSubjectsList() {
    return StreamBuilder<QuerySnapshot>(
      stream: GlobalState.course.reference.collection(Subject.collectionName)
          .orderBy("nome")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        if(snapshot.data.documents.length == 0)
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Não há disciplinas"),
            ],
          );

        return _buildList(snapshot.data.documents);
      },
    );
  }

  Widget _buildList(List<DocumentSnapshot> snapshot) {
    return Column(
        children: [
          Expanded(
            child:  ListView(
              children: snapshot.map((data){
                Subject subject = Subject.fromMap(data.data, reference: data.reference);

                // Seleção 0 representa todas, e a última posição é eletivas.
                if(_selectedPeriod != 0 && _selectedPeriod != GlobalState.periods.length-1) {
                  if (subject.periodNumber != _selectedPeriod)
                    return null;
                } else if (_selectedPeriod == GlobalState.periods.length-1){
                  // Se for o último, é lista de eletivas
                  if (!subject.eletiva)
                    return null;
                }

                return _buildListItem(subject);
              }).where((w) => w != null).toList(),
            ),
          ),
        ]
    );
  }

  Widget _buildListItem(Subject subject) {
    return Column(children: <Widget>[
      ListTile(
        title: Text(subject.name,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black
          ),
          textAlign: TextAlign.center
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SubjectDetail(subject: subject))
          );
        }
      ),
      Divider(color: Colors.black26)
    ]);
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