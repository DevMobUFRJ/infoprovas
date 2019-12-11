import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infoprovas/repository/professor_repository.dart';
import 'package:infoprovas/model/professor.dart';
import 'package:infoprovas/utils/app_provider.dart';
import 'package:infoprovas/widgets/centered_progress.dart';
import 'package:infoprovas/widgets/no_connection.dart';
import 'package:infoprovas/widgets/professor_tile.dart';
import 'package:provider/provider.dart';

class ProfessorTab extends StatefulWidget {
  @override
  _ProfessorTabState createState() => _ProfessorTabState();
}

class _ProfessorTabState extends State<ProfessorTab> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  AppProvider provider;

  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 2));
    provider.refreshProfessors();
    setState(() {});
    return null;
  }

  void tryAgain() => provider.refreshProfessors();

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: _refresh,
      child: FutureBuilder(
        future: provider.fetchProfessors(),
        builder: (_, AsyncSnapshot<List<Professor>> snapshot) {
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
                    ProfessorTile(snapshot.data[index]),
              );
            default:
              return CenteredProgress();
          }
        },
      ),
    );
  }
}
