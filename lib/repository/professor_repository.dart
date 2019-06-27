import 'dart:async';
import 'dart:io';
import 'package:http/io_client.dart';
import 'dart:convert';
import 'package:infoprovas/model/professor.dart';

Future<Stream<Professor>> getProfessor() async {
  final String url = 'http://infoprovas.esy.es/api.php?tipo=professores';

  try {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    IOClient ioClient = IOClient(httpClient);

    final streamedRest = await ioClient.get(url);
    List<dynamic> subjects = json.decode(utf8.decode(streamedRest.bodyBytes));
    return Stream.fromIterable(
        subjects.map((data) => Professor.fromJSON(data)));
  } catch (e) {
    return null;
  }
}
