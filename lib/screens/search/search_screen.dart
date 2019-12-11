import 'package:flutter/material.dart';
import 'package:infoprovas/model/professor.dart';
import 'package:infoprovas/model/search_item.dart';
import 'package:infoprovas/model/subject.dart';
import 'package:infoprovas/utils/app_provider.dart';
import 'package:infoprovas/widgets/search_tile.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  final String query;

  SearchScreen({@required this.query});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    AppProvider provider = Provider.of<AppProvider>(context);
    List<SearchItem> results = provider.searchList
        .where((a) => a.name.toLowerCase().contains(widget.query))
        .toList();

    return results.length == 0 || results.length == provider.searchList.length
        ? Center(
            child: Text("Sem resultados"),
          )
        : Consumer<AppProvider>(
            builder: (_, value, child) {
              return ListView.builder(
                itemCount: results.length,
                itemBuilder: (context, index) => SearchTile(
                  name: results[index].name,
                  type: results[index].type,
                  professor: identical(results[index].type, "professor")
                      ? value.professors
                          .where((professor) =>
                              identical(results[index].name, professor.name))
                          .first
                      : null,
                  subject: identical(results[index].type, "subject")
                      ? provider.subjects
                          .where((subject) =>
                              identical(results[index].name, subject.name))
                          .first
                      : null,
                ),
              );
            },
          );
  }
}
