import 'package:flutter/material.dart';
import 'package:infoprovas/model/professor.dart';
import 'package:infoprovas/utils/app_provider.dart';
import 'package:infoprovas/widgets/centered_progress.dart';
import 'package:infoprovas/widgets/no_connection.dart';
import 'package:infoprovas/screens/professors_tab/professor_tile.dart';
import 'package:provider/provider.dart';

class ProfessorTab extends StatefulWidget {
  @override
  _ProfessorTabState createState() => _ProfessorTabState();
}

class _ProfessorTabState extends State<ProfessorTab> {
  AppProvider provider;

  void tryAgain() => provider.refreshProfessors();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return FutureBuilder(
      future: provider.fetchProfessors(),
      builder: (_, AsyncSnapshot<List> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return CenteredProgress();
          case ConnectionState.none:
            return NoConnection(tryAgain);
          case ConnectionState.done:
            if (!snapshot.hasData) return NoConnection(tryAgain);
            return ListView.builder(
              physics: ScrollPhysics(parent: BouncingScrollPhysics()),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) =>
                  ProfessorTile(Professor.fromJSON(snapshot.data[index])),
            );
          default:
            return CenteredProgress();
        }
      },
    );
  }
}
