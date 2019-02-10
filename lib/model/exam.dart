import 'package:cloud_firestore/cloud_firestore.dart';

class Exam {
  static const String collectionName = "provas";

  String periodYearSemester; // Ex.: 2016-2
  String professor;
  String subject;
  String filename;
  String examType; //"Prova 1", "Prova 2" ou "Prova Final"

  DocumentReference reference;

  Exam(this.periodYearSemester,this.professor, this.subject, this.filename, {this.reference});

  Exam.fromMap(Map<String, dynamic> map, this.reference) :
      periodYearSemester = map['semestre'] ?? '',
      professor = map['professor'] ?? '',
      subject = map['disciplina'] ?? '',
      filename = map['arquivo'] ?? '',
      examType = map['tipo'] ?? '';

  Map<String, dynamic> toMap() =>
      {
        'semestre': periodYearSemester,
        'professor': professor,
        'subject': subject,
        'arquivo': filename,
        'tipo': examType,
      };

  String title() => this.periodYearSemester + " - Professor ou Disciplina";
}