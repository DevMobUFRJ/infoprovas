class Subject {
  final int id;
  final String name;
  final int period;

  Subject.fromJSON(Map<String, dynamic> jsonMap):
        id = int.parse(jsonMap['id']),
        name = jsonMap['nome'],
        period = int.parse(jsonMap['periodo']);
}