import 'dart:async';
import 'dart:io';
import 'package:http/io_client.dart';
import 'dart:convert';
import 'package:infoprovas/model/subject.dart';

Future<Stream<Subject>> getSubject() async {
  final String url = 'https://infoprovas.dcc.ufrj.br/api.php?tipo=disciplinas';

  try {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    IOClient ioClient = IOClient(httpClient);

    final streamedRest = await ioClient.get(url);
    List<dynamic> subjects = json.decode(utf8.decode(streamedRest.bodyBytes));
    return Stream.fromIterable(subjects.map((data) => Subject.fromJSON(data)));
  } catch (e) {
    return null;
  }
}
