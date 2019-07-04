import 'dart:async';
import 'dart:io';
import 'package:http/io_client.dart';
import 'dart:convert';
import 'package:infoprovas/model/exam.dart';

// pega as provas de uma determinada disciplina ou professor
// entrada: id da disciplina/professor, e um dos seguintes tipos:
// professor ou disciplina
// saida: stream de provas, basicamente uma "lista" de provas
// ou retorna vazio caso não possua nenhuma prova
// ou null caso não possua conexão com a internet
Future<Stream<Exam>> getExams(int id, String type) async {
  final String url = 'https://infoprovas.dcc.ufrj.br/api.php?tipo=$type&id=$id';
  try {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    IOClient ioClient = IOClient(httpClient);

    final streamedRest = await ioClient.get(url);
    List<dynamic> exams = json.decode(utf8.decode(streamedRest.bodyBytes));
    return Stream.fromIterable(exams.map((data) => Exam.fromJSON(data)));
  } on SocketException {
    return null;
  } catch (e) {
    return Stream.fromIterable([]);
  }
}
