import 'package:cloud_firestore/cloud_firestore.dart';

class Course {
  static const String collectionName = "cursos";

  String nome;
  int periodos;

  DocumentReference reference;

  Course({this.nome, this.periodos, this.reference});

  Course.fromMap(Map<String, dynamic> map, {this.reference}) :
      nome = map['nome'] ?? '',
      periodos = map['periodos'] ?? 0;

  //Métodos necessários para fazer o dropdown funcionar
  bool operator ==(o) => o is Course && nome == o.nome && periodos == o.periodos;
  int get hashCode => nome.hashCode + periodos;

  String toString() => "Nome: " + this.nome + " / " + this.periodos.toString() + " periodos";
}