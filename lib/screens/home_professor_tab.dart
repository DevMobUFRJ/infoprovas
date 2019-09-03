import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/model/professor.dart';
import 'package:infoprovas/widgets/professor_tile.dart';

class ProfessorTab extends StatefulWidget {
  final List<Professor> _professor;
  ProfessorTab(this._professor);

  @override
  _ProfessorTabState createState() => _ProfessorTabState();
}

class _ProfessorTabState extends State<ProfessorTab> {

  @override
  Widget build(BuildContext context) {
    return loadingProfessorTiles();
  }

  Widget loadingProfessorTiles() {
    return widget._professor.isEmpty
        ? Center(child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Style.mainTheme.primaryColor),
          ))
        : ListView.builder(
            physics: ScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: widget._professor.length,
            itemBuilder: (context, index) => ProfessorTile(widget._professor[index]),
          );
  }
}
