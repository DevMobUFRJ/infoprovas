import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:infoprovas/model/exam.dart';

// pega as provas de uma determinada disciplina
// entrada: id da disciplina
// saida: stream de provas, basicamente uma "lista" de provas
Future<Stream<Exam>> getSubjectExams(int id) async {
  final String url = 'http://infoprovas.esy.es/api.php?tipo=disciplina&id=$id';

  final client = new http.Client();

  try {
    final http.StreamedResponse streamedRest =
        await client.send(http.Request('get', Uri.parse(url)));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((data) {
      try {
        return data as List;
      } catch (e) {
        return [];
      }
    }).map((data) => Exam.fromJSON(data));
  } catch (e) {
    return null;
  }
}
