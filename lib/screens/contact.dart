import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  // função para enviar email -> abre tela do gmail ou similar
  // entrada: receiver -> destinatário, subject -> assunto
  // body -> corpo do email
  // TODO: tratar erro de não poder enviar
  _sendEmail(String receiver, String subject, String body) async {
    var url = 'mailto:$receiver?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.mainTheme.accentColor,
        title: Text("Fale Conosco"),
        elevation: 2.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(
                labelText: "Assunto",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(),
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(5)),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Mensagem",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Style.mainTheme.primaryColor,
        onPressed: () {
          print("enviando...");
          _sendEmail("devmob@dcc.ufrj.br", "assunto", "corpo");
        },
        child: Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }
}
