import 'package:flutter/material.dart';
import '../model/subject.dart';

class subjectTile extends StatelessWidget {
  int periodo;
  final Subject _disciplina;
  subjectTile(this._disciplina, this.periodo);

  Widget _buildDisciplina(){
    if(periodo == 0){
      return
        Column(
          children: <Widget>[
            ListTile(
              title: Text(_disciplina.nome, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.black87),),
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
    }else if (periodo == 9 && _disciplina.periodo == 0) {
      return
        Column(
          children: <Widget>[
            ListTile(
              title: Text(_disciplina.nome, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.black87),),
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
    }else if ( _disciplina.periodo == periodo){
      return
        Column(
          children: <Widget>[
            ListTile(
              title: Text(_disciplina.nome, textAlign: TextAlign.center, style: TextStyle(fontSize: 20, color: Colors.black87),),
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
    }else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) => Column(
    children: <Widget>[
      _buildDisciplina(),
    ],
  );
}


