import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:project/model/subject.dart';
import 'package:project/model/test.dart';

Future<Stream<Test>> getTests(int id) async {
  final String url = 'http://infoprovas.esy.es/api.php?tipo=disciplina&id=$id';

  final client = new http.Client();
  final streamedRest = await client.send(http.Request('get', Uri.parse(url)));

  return streamedRest.stream
      .transform(utf8.decoder)
      .transform(json.decoder)
      .expand((data) => (data as List))
      .map((data) => Test.fromJSON(data));

}