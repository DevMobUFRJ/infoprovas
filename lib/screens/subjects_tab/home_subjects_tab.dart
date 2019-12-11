import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:infoprovas/model/subject.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/utils/app_provider.dart';
import 'package:infoprovas/widgets/centered_progress.dart';
import 'package:infoprovas/widgets/no_connection.dart';
import 'package:infoprovas/screens/subjects_tab/subject_tile.dart';
import 'package:provider/provider.dart';

class SubjectsTab extends StatefulWidget {
  @override
  _SubjectsTabState createState() => _SubjectsTabState();
}

class _SubjectsTabState extends State<SubjectsTab> {
  int _selectedPeriod = 0;
  AppProvider provider;

  void tryAgain() => provider.refreshSubjects();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return FutureBuilder(
      future: provider.fetchSubjects(),
      builder: (_, AsyncSnapshot<List> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CenteredProgress();
          case ConnectionState.none:
            return NoConnection(tryAgain);
          case ConnectionState.done:
            if (!snapshot.hasData) return NoConnection(tryAgain);
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: selectorPeriod(),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (_, index) {
                      return SubjectTile(Subject.fromJSON(snapshot.data[index]),
                          _selectedPeriod);
                    },
                  ),
                ),
              ],
            );
          default:
            return CenteredProgress();
        }
      },
    );
  }

  Widget selectorPeriod() {
    return Material(
      borderRadius: BorderRadius.all(Radius.circular(100.0)),
      elevation: 3.0,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(100.0)),
            color: Style.mainTheme.primaryColor),
        child: CupertinoButton(
          child: cupertinoText(_selectedPeriod),
          padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
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
                          scrollController: FixedExtentScrollController(
                            initialItem: _selectedPeriod,
                          ),
                          itemExtent: 48.0,
                          backgroundColor: Colors.white,
                          onSelectedItemChanged: (int index) {
                            setState(() {
                              _selectedPeriod = index;
                            });
                          },
                          children: List<Widget>.generate(
                            10,
                            (int index) {
                              return selectorText(index);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget selectorText(int selectedPeriod) {
    switch (selectedPeriod) {
      case 0:
        return cupertinoPickerText(
            "Todas as Disciplinas", FontWeight.w600, Colors.black,
            fontSize: 16.0);
      case 9:
        return cupertinoPickerText("Eletivas", FontWeight.w600, Colors.black,
            fontSize: 16.0);
      default:
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

    if (selectedPeriod == 0)
      text = "Todas as Disciplinas";
    else if (selectedPeriod == 9)
      text = "Eletivas";
    else
      text = "$selectedPeriodº Periodo";

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
