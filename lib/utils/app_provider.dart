import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:infoprovas/model/professor.dart';
import 'package:infoprovas/model/search_item.dart';
import 'package:infoprovas/model/subject.dart';
import 'package:infoprovas/repository/professor_repository.dart';
import 'package:infoprovas/repository/subject_repository.dart';

class AppProvider with ChangeNotifier {
  List subjects, professors;
  List<SearchItem> searchList = <SearchItem>[];

  Future refreshProfessors() async {
    professors = await getProfessor();
    notifyListeners();
  }

  Future refreshSubjects() async {
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

  void populateSearchList() async {
    searchList.clear();
    if (subjects == null) {
      await refreshSubjects();
      populateSearchList();
    } else if (professors == null) {
      await refreshProfessors();
      populateSearchList();
    } else {
      subjects.forEach((subject) => searchList.add(
          SearchItem(name: Subject.fromJSON(subject).name, type: "subject")));
      professors.forEach((professor) => searchList.add(SearchItem(
          name: Professor.fromJSON(professor).name, type: "professor")));
    }
  }
}
