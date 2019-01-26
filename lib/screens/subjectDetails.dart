import 'package:flutter/material.dart';
import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';

import 'package:project/model/subject.dart';
import '../config/globalState.dart';
import '../styles/style.dart';


class SubjectDetail extends StatelessWidget {
  final Subject subject;

  SubjectDetail({Key key, @required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: Style.themePrincipal,
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  title: new Center(child: Text("${subject.name}")),
                  bottom: new TabBar(indicatorColor: Colors.white, tabs: [
                    new Tab(text: "Prova 1"),
                    new Tab(text: "Prova 2"),
                    new Tab(text: "Prova Final"),
                  ]),
                ),
                body: TabBarView(
                  children: [
                    new Container( padding: EdgeInsets.all(10.0), child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        return new Column(children: <Widget>[
                          new ListTile(
                            title: new Text(GlobalState.pdfs[index].name,
                                style: new TextStyle(
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black),
                                textAlign: TextAlign.center),
                            onTap: () {
                              PdfViewer.loadAsset('assets/${GlobalState.pdfs[index].path}');
                            },
                          ),
                          new Divider(color: Colors.black26),
                        ]);
                      },
                      itemCount: GlobalState.pdfs.length,
                    ),
                    ),
                    new Container( padding: EdgeInsets.all(10.0), child: Text("Prova 2 - Teste")),
                    new Container( padding: EdgeInsets.all(10.0), child: Text("Prova Final - Teste")),
                  ],
                )
            )
        )
    );
  }
}