import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/model/exam.dart';
import 'package:infoprovas/utils/database_helper.dart';
import 'package:infoprovas/screens/saved_exams.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class ExamView extends StatefulWidget {
  Exam _exam;

  ExamView(this._exam);

  @override
  _ExamViewState createState() => _ExamViewState();
}

class _ExamViewState extends State<ExamView> {
  String pathPDF = "";

  @override
  void initState() {
    super.initState();
    createFileOfPdfUrl().then((f) {
      setState(() {
        pathPDF = f.path;
      });
    });
  }

  Future<File> createFileOfPdfUrl() async {
    final url = "https://infoprovas.dcc.ufrj.br/provas/${widget._exam.id}.pdf";
    final filename = url.substring(url.lastIndexOf("/") + 1);

    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    var request = await client.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }

  void saveExam() async {
    // TODO: implementar salvar prova no dispositivo
    if (await DatabaseHelper.internal().saveExam(widget._exam)) {
      _launchURL(context,
          "https://infoprovas.dcc.ufrj.br/provaDownload.php?idProva=${widget._exam.id}");
    }
  }

  void showSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(message),
        ),
        backgroundColor: Style.mainTheme.primaryColor,
        duration: Duration(seconds: 3),
      ),
    );
  }

  Future<void> _launchURL(BuildContext context, String url) async {
    try {
      await launch(
        url,
        option: CustomTabsOption(
          toolbarColor: Style.mainTheme.primaryColor,
          enableDefaultShare: true,
          enableUrlBarHiding: true,
          showPageTitle: true,
          animation: CustomTabsAnimation(
            startEnter: 'slide_up',
            startExit: 'android:anim/fade_out',
            endEnter: 'android:anim/fade_in',
            endExit: 'slide_down',
          ),
          extraCustomTabs: <String>[
            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
            'org.mozilla.firefox',
          ],
        ),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return pathPDF == ""
        ? Scaffold(
            key: _scaffoldKey,
            body: Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Style.mainTheme.primaryColor),
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
                IconButton(
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
