// Contém as informações de uma prova, tais como:
// ID da prova (id que está na database do infoprovas),
// ano e período pertencente a prova,
// nome do Professor e tipo (Prova 1, Prova 2, etc).
// Serve pra facilitar quando o usuário desejar salvar a prova
// e assim mostrar na tela "Provas salvas"
class Test {
  int id, year, semester;
  String professorName, type, subject;

  Test(this.id, this.year, this.semester, this.professorName, this.type, this.subject);

//  Test.map(dynamic obj) {
//    this.id = obj['idTest'];
//    this.year = obj['year'];
//    this.semester = obj['semester'];
//    this.professorName = obj['professorName'];
//    this.type = obj['type'];
//  }

  // Transforma a classe em um map
  // saida: map que contém o valor pra cada campo da classe
  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['idTest'] = id;
    map['year'] = year;
    map['semester'] = semester;
    map['professorName'] = professorName;
    map['type'] = type;
    map['subject'] = subject;

    return map;
  }

  // Salva os campos do map em cada variável da classe
  // entrada: um mapa (tabela do sqflite)
  Test.fromMap(Map<String, dynamic> map) {
    this.id = map['idTest'];
    this.year = map['year'];
    this.semester = map['semester'];
    this.professorName = map['professorName'];
    this.type = map['type'];
    this.subject = map['subject'];
  }
}