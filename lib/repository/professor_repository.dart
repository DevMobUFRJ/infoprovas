import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:infoprovas/model/professor.dart';

Future<Stream<Professor>> getProfessor() async {
  final String url = 'http://infoprovas.esy.es/api.php?tipo=professores';

  final client = http.Client();

  try {
    final http.StreamedResponse streamedRest =
        await client.send(http.Request('get', Uri.parse(url)));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((data) => (data as List))
        .map((data) => Professor.fromJSON(data));
  } catch (e) {
    return null;
  }
}
