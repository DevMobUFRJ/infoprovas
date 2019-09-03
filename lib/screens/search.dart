import 'package:flutter/material.dart';
import 'package:infoprovas/model/professor.dart';
import 'package:infoprovas/model/search_item.dart';
import 'package:infoprovas/model/subject.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/widgets/search_tile.dart';
import 'package:floating_search_bar/floating_search_bar.dart';

class SearchPage extends SearchDelegate<SearchItem> {
  final List<SearchItem> searchList;
  final List<Professor> professor;
  final List<Subject> subject;

  SearchPage({this.searchList, this.professor, this.subject});


  @override
  ThemeData appBarTheme(BuildContext context) {
    assert(context != null);
    final ThemeData theme = Theme.of(context);
    assert(theme != null);
    return theme.copyWith(
      hintColor: Colors.white,
      cursorColor: Color.fromARGB(2500, 255, 255, 255),
      primaryColor: Style.mainTheme.primaryColor,
      primaryIconTheme: theme.primaryIconTheme.copyWith(color: Colors.white),
      primaryColorBrightness: theme.primaryColorBrightness,
      textTheme: theme.textTheme.copyWith(
          title: theme.textTheme.title
              .copyWith(color: theme.primaryTextTheme.title.color)),
      primaryTextTheme: theme.textTheme,
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear, color: Colors.white,),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.white,),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return returnList();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return returnList();
  }

  Widget returnList() {
    var results =
        searchList.where((a) => a.name.toLowerCase().contains(query)).toList();

    return results.length == 0 || results.length == searchList.length
        ? Center(
            child: Text("Sem resultados"),
          )
        : ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) => SearchTile(
              name: results[index].name,
              type: results[index].type,
              professor: identical(results[index].type, "professor")
                  ? professor
                      .where((professor) =>
                          identical(results[index].name, professor.name))
                      .first
                  : null,
              subject: identical(results[index].type, "subject")
                  ? subject
                      .where((subject) =>
                          identical(results[index].name, subject.name))
                      .first
                  : null,
            ),
          );
  }
}
