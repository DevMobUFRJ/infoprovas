import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'dart:convert';

Future<List> getProfessor() async {
  final String url = 'https://infoprovas.dcc.ufrj.br/api.php?tipo=professores';

  try {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    IOClient ioClient = IOClient(httpClient);

    final Response streamedRest = await ioClient.get(url);
    List professors = json.decode(utf8.decode(streamedRest.bodyBytes));
    return professors;
  } catch (e) {
    return null;
  }
}
