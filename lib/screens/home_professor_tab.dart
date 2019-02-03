import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/config/globalState.dart';

class ProfessorTab extends StatefulWidget {
  @override
  _ProfessorTabState createState() => _ProfessorTabState();
}

class _ProfessorTabState extends State<ProfessorTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Column(children: <Widget>[
              ListTile(
                title: Text(GlobalState.professors[index].name,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                  ),
                  textAlign: TextAlign.center
                ),
              ),
              Divider(color: Colors.black26),
            ]);
          },
          itemCount: GlobalState.professors.length,
        ),

    );
  }

}