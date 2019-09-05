import 'package:flutter/material.dart';
import 'package:infoprovas/model/professor.dart';
import 'package:infoprovas/model/search_item.dart';
import 'package:infoprovas/model/subject.dart';
import 'package:infoprovas/widgets/search_tile.dart';

class SearchScreen extends StatefulWidget {
  final List<SearchItem> searchList;
  final List<Professor> professor;
  final List<Subject> subject;
  final String query;

  SearchScreen({this.searchList, this.professor, this.subject, this.query});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    var results = widget.searchList
        .where((a) => a.name.toLowerCase().contains(widget.query))
        .toList();

    return results.length == 0 || results.length == widget.searchList.length
        ? Center(
            child: Text("Sem resultados"),
          )
        : ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) => SearchTile(
              name: results[index].name,
              type: results[index].type,
              professor: identical(results[index].type, "professor")
                  ? widget.professor
                      .where((professor) =>
                          identical(results[index].name, professor.name))
                      .first
                  : null,
              subject: identical(results[index].type, "subject")
                  ? widget.subject
                      .where((subject) =>
                          identical(results[index].name, subject.name))
                      .first
                  : null,
            ),
          );
  }
}
