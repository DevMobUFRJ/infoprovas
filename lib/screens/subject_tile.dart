import 'package:flutter/material.dart';
import '../model/subject.dart';

class subjectTile extends StatelessWidget {
  int period;
  final Subject _subject;
  subjectTile(this._subject, this.period);

  Widget _selectSubject(){
    if(period == 0){
      return _createTileSubject();
    }else if (period == 9 && _subject.period == 0) {
      return _createTileSubject();
    }else if ( _subject.period == period){
      return _createTileSubject();
    }else {
      return Container();
    }
  }

  Widget _createTileSubject(){
    return
      Column(
        children: <Widget>[
          ListTile(
            title: Text(_subject.name, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.black87),),
            onTap: () => print("${_subject.name}, ${_subject.period}, ${_subject.id}"),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8.0),
            child: Container(
              height: 0.5,
              color: Colors.black12,
            ),
          )
        ],
      );
  }

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      _selectSubject(),
    ],
  );
}


