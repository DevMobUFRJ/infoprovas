import 'package:cloud_firestore/cloud_firestore.dart';
class Course {
  static const String collectionName = "cursos";

  String name;
  int periods;

  DocumentReference reference;

  Course({this.name, this.periods, this.reference});

  Course.fromMap(Map<String, dynamic> map, {this.reference}) :
      name = map['nome'] ?? '',
      periods = map['periodos'] ?? 0;

  //Métodos necessários para fazer o dropdown funcionar
  bool operator ==(o) => o is Course && name == o.name && periods == o.periods;
  int get hashCode => name.hashCode + periods;

  String toString() => "Nome: " + this.name + " / " + this.periods.toString() + " periodos";
}