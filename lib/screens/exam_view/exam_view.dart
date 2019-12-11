import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/widgets.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/utils/database_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:infoprovas/utils/main_functions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:outline_material_icons/outline_material_icons.dart';

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
  bool saving = false;
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
      String dir = (await getApplicationDocumentsDirectory()).path;
      String url = "$dir/${widget._exam.id}.pdf";
//      String url =
//          "/data/user/0/ufrj.devmob.infoprovas/app_flutter/${widget._exam.id}.pdf";
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
    setState(() {
      saving = true;
    });
    if (await DatabaseHelper.internal().saveExam(widget._exam)) {
      await downloadFile(false).then((f) {
        setState(() {
          if (f != null) isSaved = true;
          saving = false;
        });
      });
    } else {
      setState(() {
        isSaved = false;
      });
    }
  }

  // compartilha o arquivo da prova (mesmo se não for prova salva)
  // utilizando a biblioteca esys_flutter_share
  void shareExam() async {
    String url = "";
    if (isSaved) {
      String dir = (await getApplicationDocumentsDirectory()).path;
      url = "$dir/${widget._exam.id}.pdf";
//      url =
//          "/data/user/0/ufrj.devmob.infoprovas/app_flutter/${widget._exam.id}.pdf";
    } else {
      String dir = (await getTemporaryDirectory()).path;
      url = "$dir/${widget._exam.id}.pdf";
    }
    String text =
        "${widget._exam.type} de ${widget._exam.subject} de ${widget._exam.year}-${widget._exam.semester}"
        "\nBaixe o app InfoProvas para encontrar mais provas.\nLink: https://play.google.com/store/apps/details?id=ufrj.devmob.infoprovas";
    final ByteData bytes = await rootBundle.load(url);
    await Share.file(
        'Compartilhar',
        "${getShortType(widget._exam.type).toLowerCase()}_${(widget._exam.year).toString().substring(2, 4)}_${widget._exam.semester}.pdf",
        bytes.buffer.asUint8List(),
        'application/pdf',
        text: text);
  }

  Widget actionButton() {
    if (isSaved) {
      return Tooltip(
        verticalOffset: 0,
        message: "Prova salva",
        preferBelow: false,
        child: IconButton(
            icon: Icon(OMIcons.cloudDone, color: Colors.white),
            onPressed: null),
      );
    } else if (saving) {
      return IconButton(
          icon: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          ),
          onPressed: null);
    } else {
      return IconButton(
        icon: Icon(
          OMIcons.cloudDownload,
          color: Colors.white,
        ),
        onPressed: () {
          saveExam();
        },
      );
    }
  }

  Widget shareButton() {
    return Tooltip(
      message: "Compartilhar",
      verticalOffset: 0,
      child: IconButton(
        icon: Icon(OMIcons.share, color: Colors.white),
        onPressed: shareExam,
      ),
    );
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
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(OMIcons.cloudOff),
                      Text("Não foi possível conectar a rede"),
                    ],
                  ),
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
                shareButton(),
                actionButton(),
              ],
            ),
            path: pathPDF,
          );
  }
}
