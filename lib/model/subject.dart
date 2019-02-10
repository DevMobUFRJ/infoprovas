import 'package:cloud_firestore/cloud_firestore.dart';

class Subject {
  static const String collectionName = "disciplinas";

  num id;
  String name;
  num periodNumber;
  bool elective;

  DocumentReference reference;

  Subject(this.name, this.id, [this.periodNumber = 1, this.elective = false]);

  Subject.fromMap(Map<String, dynamic> map, {this.reference}) :
      this.name = map['nome'] ?? '',
      this.periodNumber = map['periodo'] ?? 0,
      this.elective = map['eletiva'] ?? false;
}