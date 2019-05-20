import 'dart:async';
import 'package:flutter/material.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/styles/github_icon.dart';
import 'package:infoprovas/styles/facebook_icon.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';

class About extends StatelessWidget {
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
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new AppBar(
        backgroundColor: Style.mainTheme.accentColor,
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
                physics: ScrollPhysics(parent: BouncingScrollPhysics()),
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image.asset(
                        "assets/devmob-logo.png",
                        width: 80,
                      ),
                    ],
                  ),
                  Container(
                    height: 8.0,
                  ),
                  Text(
                    "App desenvolvido por DevMob UFRJ\n"
                    "Nome da Pessoa / Nomeie Outra Pessoa",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 15,
                    ),
                  ),
                  Divider(
                    color: Colors.black45,
                    height: 28,
                  ),
                  Text(
                    "Infoprovas",
                    style: TextStyle(
                      fontSize: 20,
                      color: Style.mainTheme.primaryColorDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      "O InfoProvas é um projeto do CAInfo, Centro Acadêmico do curso de Ciência da Computação. "
                      "Anteriormente, consistindo apenas de um site.\nO InfoProvas conta com provas antigas de "
                      "professores e disciplinas, com o objetivo principal de auxiliar os alunos nos estudos, "
                      "permitindo uma preparação mais efetiva e objetiva, trazendo resultados melhores pros alunos, "
                      "pro curso, e pra universidade.",
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Divider(
                    color: Colors.black45,
                    height: 28,
                  ),
                  Text(
                    "DevMob",
                    style: TextStyle(
                      fontSize: 20,
                      color: Style.mainTheme.primaryColorDark,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Text(
                      "O aplicativo foi desenvolvido pelo DevMob, Grupo de Desenvolvimento de Aplicativos do "
                      "Departamento de Ciência da Computação da UFRJ. O app foi desenvolvido em Flutter, e o seu "
                      "código fonte está aberto, disponível no GitHub do grupo.",
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Divider(
                    color: Colors.black45,
                    height: 28,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Facebook.facebook),
                        disabledColor: Colors.black54,
                        color: Colors.black54,
                        iconSize: 40,
                        onPressed: () => _launchURL(
                            context, "http://facebook.com/devmobufrj"),
                      ),
                      IconButton(
                        icon: Icon(Git.github),
                        disabledColor: Colors.black54,
                        color: Colors.black54,
                        iconSize: 40,
                        onPressed: () => _launchURL(
                            context, "https://github.com/DevMobUFRJ"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
