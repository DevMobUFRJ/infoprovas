import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:project/model/subject.dart';
import 'package:project/styles/style.dart';
import 'package:project/widgets/subject_tile.dart';

class SubjectsTab extends StatefulWidget {
  List<Subject> _subject = <Subject>[];
  SubjectsTab(this._subject);

  @override
  _SubjectsTabState createState() => _SubjectsTabState(_subject);
}

class _SubjectsTabState extends State<SubjectsTab> {
  List<Subject> _subject = <Subject>[];

  _SubjectsTabState(this._subject);

  int _selectedPeriod = 1;

  @override
  Widget build(BuildContext context) {
    return loadingSubjectTiles();
  }

  Widget loadingSubjectTiles() {
    return _subject.isEmpty
        ? Center(
            child: CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(Style.mainTheme.primaryColor),
          ))
        : Container(
            child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: selectorPeriod(),
            ),
            Flexible(
              child: Center(
                  child: ListView.builder(
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                itemCount: _subject.length,
                itemBuilder: (context, index) =>
                    SubjectTile(_subject[index], _selectedPeriod),
              )),
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
                                          FixedExtentScrollController(
                                        initialItem: _selectedPeriod,
                                      ),
                                      itemExtent: 48.0,
                                      backgroundColor: Colors.white,
                                      onSelectedItemChanged: (int index) {
                                        setState(() {
                                          _selectedPeriod = index;
                                        });
                                      },
                                      children: List<Widget>.generate(10,
                                          (int index) {
                                        return selectorText(index);
                                      }),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    }))));
  }

  Widget selectorText(int selectedPeriod) {
    if (selectedPeriod == 0) {
      return myText("Todas as Disciplinas", FontWeight.w600, Colors.black,
          fontSize: 16.0);
    } else if (selectedPeriod == 9) {
      return myText("Eletivas", FontWeight.w600, Colors.black, fontSize: 16.0);
    } else {
      return myText("$selectedPeriodº Periodo", FontWeight.w600, Colors.black,
          fontSize: 16.0);
    }
  }

  Widget myText(String text, FontWeight fontWeight, Color colors,
      {double fontSize}) {
    return Center(
      child: Text(text,
          style: new TextStyle(
              fontWeight: fontWeight, fontSize: fontSize, color: colors)),
    );
  }

  Widget cupertinoText(int selectedPeriod) {
    String text;

    if (selectedPeriod == 0) {
      text = "Todas as Disciplinas";
    } else if (selectedPeriod == 9) {
      text = "Eletivas";
    } else {
      text = "$selectedPeriodº Periodo";
    }

    return Stack(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          child: myText(text, FontWeight.w700, Colors.white),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Container(
            alignment: Alignment.centerRight,
            child: Icon(Icons.arrow_drop_down, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
