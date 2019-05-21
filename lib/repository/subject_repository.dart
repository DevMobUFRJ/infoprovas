import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:infoprovas/model/subject.dart';

Future<Stream<Subject>> getSubject() async {
  final String url = 'http://infoprovas.esy.es/api.php?tipo=disciplinas';

  final client = new http.Client();
  try {
    final http.StreamedResponse streamedRest =
        await client.send(http.Request('get', Uri.parse(url)));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .expand((data) => (data as List))
        .map((data) => Subject.fromJSON(data));
  } catch (e) {
    return null;
  }
}
