import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:infoprovas/model/search_item.dart';
import 'package:infoprovas/repository/professor_repository.dart';
import 'package:infoprovas/repository/subject_repository.dart';

class AppProvider with ChangeNotifier {
  List subjects, professors;
  List<SearchItem> searchList = <SearchItem>[];

  void refreshProfessors() async {
    professors = await getProfessor();
    notifyListeners();
  }

  void refreshSubjects() async {
    subjects = await getSubject();
    notifyListeners();
  }

  Future<List> fetchSubjects() async {
    if (subjects != null) return subjects;
    subjects = await getSubject();
    return subjects;
  }

  Future<List> fetchProfessors() async {
    if (professors != null) return professors;
    professors = await getProfessor();
    return professors;
  }

  void populateSearchList() {
    searchList.clear();
    subjects.forEach((subject) =>
        searchList.add(SearchItem(name: subject.name, type: "subject")));
    professors.forEach((professor) =>
        searchList.add(SearchItem(name: professor.name, type: "professor")));
  }
}
