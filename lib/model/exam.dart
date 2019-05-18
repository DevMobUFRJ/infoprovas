// Contém as informações de uma prova, tais como:
// ID da prova (id que está na database do infoprovas),
// ano e período pertencente a prova,
// nome do Professor e tipo (Prova 1, Prova 2, etc).
// Serve pra facilitar quando o usuário desejar salvar a prova
// e assim mostrar na tela "Provas salvas"
class Exam {
  int id, year, semester;
  String professorName, type, subject;

  Exam(this.id, this.year, this.semester, this.type, this.professorName,
      this.subject);

  @override
  String toString() =>
      "Id: $id, ano: $year, semestre: $semester, professor: $professorName, tipo: $type, disciplina: $subject";

  // Transforma a classe em um map
  // saida: map que contém o valor pra cada campo da classe
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['idExam'] = id;
    map['year'] = year;
    map['semester'] = semester;
    map['professorName'] = professorName;
    map['type'] = type;
    map['subject'] = subject;

    return map;
  }

  // Salva os campos do map em cada variável da classe
  // entrada: um mapa (tabela do sqflite)
  Exam.fromMap(Map<String, dynamic> map) {
    this.id = map['idExam'];
    this.year = map['year'];
    this.semester = map['semester'];
    this.professorName = map['professorName'];
    this.type = map['type'];
    this.subject = map['subject'];
  }

  // Salva os campos do json (api) no objeto Exam
  // entrada: map de json da api
  Exam.fromJSON(Map<String, dynamic> jsonMap)
      : id = int.parse(jsonMap['provaID']),
        professorName = jsonMap['nomeProfessor'],
        type = jsonMap['nome'],
        year = int.parse(jsonMap['ano']),
        semester = int.parse(jsonMap['periodo']),
        subject = jsonMap['disciplina'];
}
