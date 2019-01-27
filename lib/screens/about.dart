import 'package:flutter/material.dart';
import 'package:project/styles/style.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  _launchURL(String url) async{
    if (await canLaunch(url)) {
      await launch(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        title: Text("Sobre"),
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: ListView(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        GestureDetector(
                          child: Image.asset("assets/devmob-logo.png", width: 80,),
                          onTap: () => _launchURL("http://facebook.com/devmobufrj"),
                        ),
                      ],
                    ),
                    Container(
                      height: 8.0,
                    ),
                    Text("App desenvolvido por DevMob UFRJ\n"
                        "Nome da Pessoa / Nomeie Outra Pessoa",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                      ),
                    ),
                    Divider(color: Colors.black45, height: 28,),
                    Text("Infoprovas",
                      style: TextStyle(
                        fontSize: 20,
                        color: Style.themePrincipal.primaryColorDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text("O InfoProvas é um projeto do CAInfo, Centro Acadêmico do curso de Ciência da Computação. "
                          "Anteriormente, consistindo apenas de um site.\nO InfoProvas conta com provas antigas de "
                          "professores e disciplinas, com o objetivo principal de auxiliar os alunos nos estudos, "
                          "permitindo uma preparação mais efetiva e objetiva, trazendo resultados melhores pros alunos, "
                          "pro curso, e pra universidade.",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Divider(color: Colors.black45, height: 28,),
                    Text("DevMob",
                      style: TextStyle(
                        fontSize: 20,
                        color: Style.themePrincipal.primaryColorDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Text("O aplicativo foi desenvolvido pelo DevMob, Grupo de Desenvolvimento de Aplicativos do "
                          "Departamento de Ciência da Computação da UFRJ. O app foi desenvolvido em Flutter, e o seu "
                          "código fonte está aberto, disponível no GitHub do grupo.",
                        textAlign: TextAlign.justify,
                      ),
                    ),
                    Divider(color: Colors.black45, height: 28,),
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}