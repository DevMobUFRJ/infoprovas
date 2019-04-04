class Professor {
  final int id;
  final String name;

  Professor.fromJSON(Map<String, dynamic> jsonMap):
        id = int.parse(jsonMap['id']),
        name = jsonMap['nome'];
}