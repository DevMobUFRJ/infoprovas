import 'dart:async';
import 'dart:io';
import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'dart:convert';

Future<List> getSubject() async {
  final String url = 'https://infoprovas.dcc.ufrj.br/api.php?tipo=disciplinas';

  try {
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);

    IOClient ioClient = IOClient(httpClient);

    Response streamedRest = await ioClient.get(url);
    List subjects = json.decode(utf8.decode(streamedRest.bodyBytes));
    return subjects;
  } catch (e) {
    return null;
  }
}
