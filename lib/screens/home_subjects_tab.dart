import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/model/subject.dart';
import 'package:project/styles/style.dart';
import 'subject_tile.dart';
import 'package:project/repository/subject_repository.dart';

class SubjectsTab extends StatefulWidget {
  @override
  _SubjectsTabState createState() => _SubjectsTabState();
}

class _SubjectsTabState extends State<SubjectsTab> {
  List<Subject> _subject = <Subject>[];

  @override
  void initState() {
    super.initState();
    listenForSubject();
  }

  int _selectedPeriod = 0;

  @override
  Widget build(BuildContext context) {
    return new Container(
        child: Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: selectorPeriod(),
      ),
      Flexible(
        child: ListView.builder(
          itemCount: _subject.length,
          itemBuilder: (context, index) => subjectTile(_subject[index], _selectedPeriod),
        ),
      )
    ]));
  }

  Widget selectorPeriod() {
    return Material(
        borderRadius: BorderRadius.all(Radius.circular(100.0)),
        elevation: 3.0,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                color: Style.mainTheme.primaryColor),
            child: new SizedBox(
                width: double.infinity,
                // height: double.infinity,
                child: CupertinoButton(
                    child: cupertinoText(_selectedPeriod),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                    pressedOpacity: 0.5,
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
                                        });
                                      },
                                      children: new List<Widget>.generate(10,
                                          (int index) {
                                            return selectorText(index);
                                          }
                                        ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }))));
  }

  void listenForSubject() async {
    final Stream<Subject> stream = await getSubject();
    stream.listen((Subject subject) => setState(() => _subject.add(subject)));
  }

  Widget selectorText(int selectedPeriod) {
    if (selectedPeriod == 0) {
      return new Center(
        child: new Text("Todas as Disciplinas",
            style: new TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                color: Colors.black)),
      );
    } else if (selectedPeriod == 9) {
      return new Center(
        child: new Text("Eletivas",
            style: new TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                color: Colors.black)),
      );
    } else {
      return new Center(
        child: new Text("$selectedPeriodº Periodo",
            style: new TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                color: Colors.black)),
      );
    }
  }

  Widget cupertinoText(int selectedPeriod) {
    if (selectedPeriod == 0) {
      return Text("Todas as Disciplinas",
          style:
              new TextStyle(fontWeight: FontWeight.w700, color: Colors.white));
    } else if (selectedPeriod == 9) {
      return Text("Eletivas",
          style:
              new TextStyle(fontWeight: FontWeight.w700, color: Colors.white));
    } else {
      return Text("$selectedPeriodº Periodo",
          style:
              new TextStyle(fontWeight: FontWeight.w700, color: Colors.white));
    }
  }
}
