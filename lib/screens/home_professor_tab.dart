import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/config/global_state.dart';
import 'package:project/styles/style.dart';
import 'package:project/model/professor.dart';
import 'professor_tile.dart';
import 'package:project/repository/professor_repository.dart';

class ProfessorTab extends StatefulWidget {
  @override
  _ProfessorTabState createState() => _ProfessorTabState();
}

class _ProfessorTabState extends State<ProfessorTab> {
  List<Professor> _professor = <Professor>[];

  @override
  void initState() {
    super.initState();
    listenForProfessor();
  }

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        itemCount: _professor.length,
        itemBuilder: (context, index) =>
            ProfessorTile(_professor[index]),

    );
  }

  void listenForProfessor() async {
    final Stream<Professor> stream = await getProfessor();
    stream.listen((Professor professor) =>
        setState(() => _professor.add(professor))
    );
  }
}
