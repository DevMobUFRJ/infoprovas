class Subject {
  final int id;
  final String nome;
  final int periodo;

  Subject.fromJSON(Map<String, dynamic> jsonMap):
        id = int.parse(jsonMap['id']),
        nome = jsonMap['nome'],
        periodo = int.parse(jsonMap['periodo']);
}