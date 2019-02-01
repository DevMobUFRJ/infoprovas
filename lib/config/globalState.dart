import 'package:project/model/course.dart';
import '../model/professor.dart';
import '../model/subject.dart';
import '../model/pdf.dart';

class GlobalState {
  final Map<dynamic, dynamic> _data = <dynamic, dynamic>{};

  static GlobalState instance = new GlobalState._();
  GlobalState._();

  set(dynamic key,dynamic value) => _data[key] = value;
  get(dynamic key) => _data[key];

  static Course course;

  /// Preenchido quando o curso é selecionado. Ver abaixo o método [setCourse]
  static List<String> periods = [];

  static List<Subject> subjects = [
    new Subject("Calculo Infinitesimal I", 1, 1),
    new Subject("Computação I", 2, 1),
    new Subject("Fundamentos da Computação Digital", 3, 1),
    new Subject("Números Inteiros e Criptografia", 4, 1),
    new Subject("Sistemas de Informação", 5, 1),
    new Subject("Sistemas de Informação 2", 5, 2)
  ];
  static List<Professor> professors = [
    new Professor("Adraina Santarosa Vivacqua", 1),
    new Professor("Adriano Joaquim de Oliveira Cruz", 2),
    new Professor("Ageu Cavalcanti Pacheco Junior", 3),
    new Professor("Alexandre Soares", 4),
    new Professor("Alexis Hermández", 5),
    new Professor("Aline Martins Paes", 6),
    new Professor("André Saraiva", 7),
    new Professor("Angela Maria Gonçalves Leal", 8),
    new Professor("Antonio Carlos Gay Thomé", 9),
    new Professor("Carla Amor Divino Moreira Delgado", 10)
  ];

  static List<PDF> pdfs = [
    new PDF("2016 - 2º Semestre Adriano Joaquim de Oliveira Cruz", "test1.pdf"),
    new PDF("2016 - 1º Semestre Silvana Rossetto", "test2.pdf"),
    new PDF("2016 - 1º Semestre Adriano Joaquim de Oliveira Cruz", "test3.pdf")
  ];


  getSubjects() => subjects;

  /// Inicializa o curso com o curso selecionado pelo usuário, além de
  /// outras variáveis relacionadas com a seleção.
  static void setCourse(Course newCourse){
    course = newCourse;
    periods = [];
    for(int i = 0; i < course.periodos; i++){
      periods.add((i+1).toString() + "º Período");
    }
    periods.add("Eletivas");
  }
}
