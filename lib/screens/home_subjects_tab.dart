import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:infoprovas/model/subject.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/widgets/subject_tile.dart';

class SubjectsTab extends StatefulWidget {
  final List<Subject> _subject;
  SubjectsTab(this._subject);

  @override
  _SubjectsTabState createState() => _SubjectsTabState();
}

class _SubjectsTabState extends State<SubjectsTab> {
  int _selectedPeriod = 0;

  @override
  Widget build(BuildContext context) {
    return loadingSubjectTiles();
  }

  Widget loadingSubjectTiles() {
    return widget._subject.isEmpty
        ? Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(Style.mainTheme.primaryColor),
            ),
          )
        : Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: selectorPeriod(),
                ),
                Expanded(
                  child: Center(
                    child: ListView.builder(
                      physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                      itemCount: widget._subject.length,
                      itemBuilder: (context, index) =>
                          SubjectTile(widget._subject[index], _selectedPeriod),
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  Widget selectorPeriod() {
    return Material(
        borderRadius: BorderRadius.all(Radius.circular(100.0)),
        elevation: 3.0,
        child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100.0)),
                color: Style.mainTheme.primaryColor),
            child: SizedBox(
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
      return cupertinoPickerText(
          "Todas as Disciplinas", FontWeight.w600, Colors.black,
          fontSize: 16.0);
    } else if (selectedPeriod == 9) {
      return cupertinoPickerText("Eletivas", FontWeight.w600, Colors.black,
          fontSize: 16.0);
    } else {
      return cupertinoPickerText(
          "$selectedPeriodº Periodo", FontWeight.w600, Colors.black,
          fontSize: 16.0);
    }
  }

  Widget cupertinoPickerText(String text, FontWeight fontWeight, Color colors,
      {double fontSize}) {
    return Center(
      child: Text(text,
          style: TextStyle(
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
          child: cupertinoPickerText(text, FontWeight.w700, Colors.white),
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
