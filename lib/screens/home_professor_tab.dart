import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project/styles/style.dart';
import 'package:project/model/professor.dart';
import 'professor_tile.dart';

class ProfessorTab extends StatefulWidget {
  List<Professor> _professor = <Professor>[];
  ProfessorTab(this._professor);

  @override
  _ProfessorTabState createState() => _ProfessorTabState(_professor);
}

class _ProfessorTabState extends State<ProfessorTab> {
  List<Professor> _professor = <Professor>[];

  _ProfessorTabState(this._professor);

  @override
  Widget build(BuildContext context) {
    return loadingProfessorTiles();
  }

  Widget loadingProfessorTiles() {
    return _professor.isEmpty
        ? Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Style.mainTheme.primaryColor),
          ))
        : ListView.builder(
            itemCount: _professor.length,
            itemBuilder: (context, index) => ProfessorTile(_professor[index]),
          );
  }
}
