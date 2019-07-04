import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/utils/database_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ExamView extends StatefulWidget {
  final Exam _exam;

  ExamView(this._exam);

  @override
  _ExamViewState createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  String pathPDF = "";
  bool isSaved = false;
  bool connectionFailed = false;

  @override
  void initState() {
    super.initState();
    isExamSaved().then((result) {
      setState(() {
        isSaved = result;
      });
      requestServer();
    });
  }

  // função para verificar se há conexão com a rede
  // se downloadFile falhar e retornar null, connectionFailed ficará = true e
  // então a screen mostrará um texto avisando sobre a falha.
  requestServer() {
    setState(() {
      connectionFailed = false;
    });
    downloadFile(true).then((f) {
      setState(() {
        if (f == null) {
          connectionFailed = true;
        } else {
          pathPDF = f.path;
        }
      });
    });
  }

  // função para baixar o arquivo do servidor ou abrir o arquivo salvo no dispositivo.
  // entrada: uma bool temp -> se for true indica que o arquivo a ser baixado
  // deve ser salvo na memoria temporaria, caso contrário salvará na memoria
  // permanente do dispositivo.
  // saida: file -> um arquivo, retornará null se não foi possível baixar o arquivo,
  // não é possível retornar null caso o arquivo esteja salvo no dispositivo.
  Future<File> downloadFile(bool temp) async {
    if (isSaved) {
      String url =
          "/data/user/0/ufrj.devmob.infoprovas/app_flutter/${widget._exam.id}.pdf";
      File file = File(url);
      return file;
    }
    try {
      String url = "https://infoprovas.dcc.ufrj.br/provas/${widget._exam.id}.pdf";
      final filename = url.substring(url.lastIndexOf("/") + 1);

      HttpClient client = new HttpClient();
      client.badCertificateCallback =
          ((X509Certificate cert, String host, int port) => true);
      var request = await client.getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      String dir = temp
          ? (await getTemporaryDirectory()).path
          : (await getApplicationDocumentsDirectory()).path;
      File file = File('$dir/$filename');
      await file.writeAsBytes(bytes);
      return file;
    } catch (e) {
      return null;
    }
  }

  Future<bool> isExamSaved() async =>
      await DatabaseHelper.internal().getExam(widget._exam.id) != null;

  // salva a prova no sqlite e caso seja bem sucedido, chamará a função
  // para baixar o arquivo.
  void saveExam() async {
    if (await DatabaseHelper.internal().saveExam(widget._exam)) {
      await downloadFile(false).then((f) {
        setState(() {
          if (f != null) isSaved = true;
        });
      });
    } else {
      setState(() {
        isSaved = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return pathPDF == ""
        ? connectionFailed
            ? Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Style.mainTheme.primaryColor,
                  title: Text("InfoProvas"),
                  elevation: 0.0,
                  actions: <Widget>[
                    IconButton(
                        icon: Icon(Icons.refresh), onPressed: requestServer)
                  ],
                ),
                body: Center(
                  child: Text("Não foi possível conectar a rede"),
                ),
              )
            : Scaffold(
                key: _scaffoldKey,
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Style.mainTheme.primaryColor,
                  title: Text("InfoProvas"),
                  elevation: 0.0,
                ),
                body: Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Style.mainTheme.primaryColor),
                  ),
                ),
              )
        : PDFViewerScaffold(
            key: _scaffoldKey,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Style.mainTheme.primaryColor,
              title: Text("InfoProvas"),
              elevation: 0.0,
              actions: <Widget>[
                isSaved
                    ? IconButton(
                        icon: Icon(
                          Icons.check,
                          color: Colors.white,
                        ),
                        onPressed: null)
                    : IconButton(
                        icon: Icon(
                          Icons.save,
                          color: Colors.white,
                        ),
                        onPressed: saveExam,
                      )
              ],
            ),
            path: pathPDF,
          );
  }
}
