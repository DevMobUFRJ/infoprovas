import 'professor.dart';
import 'subject.dart';
import 'pdf.dart';

class Exam {
  num id;
  String periodYearSemester; // Ex.: 2016-2
  PDF pdf;
  Professor professor;
  Subject subject;

  Exam(this.id, this.periodYearSemester, this.pdf, this.professor, this.subject);
}