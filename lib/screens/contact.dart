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

  final _emailSubject = TextEditingController();
  final _emailBody = TextEditingController();
  String _dropDownSelected = "Outros";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.mainTheme.accentColor,
        title: Text("Fale Conosco"),
        elevation: 0.0,
      ),
      body: ListView(
        physics: ScrollPhysics(parent: BouncingScrollPhysics()),
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 5,right: 5,bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Categoria",style: TextStyle(fontSize: 16),),
                      DropdownButton(
                        items: _dropDownItem(),
                        value: _dropDownSelected,
                        onChanged: (value) {
                          _dropDownSelected = value;
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  controller: _emailSubject,
                  decoration: InputDecoration(
                    alignLabelWithHint: false,
                    labelText: "Assunto",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Padding(padding: EdgeInsets.all(5)),
                TextFormField(
                  keyboardType: TextInputType.multiline,
                  minLines: 8,
                  maxLines: null,
                  controller: _emailBody,
                  decoration: InputDecoration(
                    labelText: "Mensagem",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Style.mainTheme.primaryColor,
        onPressed: () {
          print("enviando...");
          _sendEmail("devmob@dcc.ufrj.br", "[${_dropDownSelected}] InfoProvas - ${_emailSubject.text}", _emailBody.text);
        },
        child: Icon(
          Icons.send,
          color: Colors.white,
        ),
      ),
    );
  }
  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> optionsList = ["Bugs", "Opiniões", "Outros"];
    return optionsList
        .map((value) => DropdownMenuItem(
      value: value,
      child: Text(value),
    ))
        .toList();
  }
}
