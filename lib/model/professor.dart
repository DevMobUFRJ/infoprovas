import 'package:cloud_firestore/cloud_firestore.dart';

class Professor {

  static const String collectionName = "professores";
  num id;
  String name;

  DocumentReference reference;

  Professor(this.name, this.id);

  Professor.fromMap(Map<String, dynamic> map, {this.reference}) :
  this.name = map['nome'] ?? '';
}
