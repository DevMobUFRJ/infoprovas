import 'package:flutter/material.dart';

class SendPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return new PageState();
  }
}

class PageState extends State<SendPage>{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      home: DefaultTabController(
        length: 1,
        child: Scaffold(
          drawer: Drawer(),
          backgroundColor: Color.fromARGB(255, 0x40, 0x40, 0x40),
          appBar: new AppBar(
            backgroundColor: Color.fromARGB(255, 0, 0xA8, 0xA1),
            title: Text("Info Provas"),
            elevation: 2.0,
            bottom: new TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(text: "Disciplina"),
                Tab(text: "Professor"),
              ]
            ),
          ),
            body: new ListView(
              children: <Widget>[
                new ListTile(
                  title: new Text("Matéria 1",style: new TextStyle(fontWeight: FontWeight.w400, color: Colors.white),textAlign: TextAlign.center),
                  subtitle: new Text("Alguma outra coisa", style: new TextStyle(color: Colors.white),textAlign: TextAlign.center,),
                ),
                new Divider(color: Colors.white30),

              ],
            ),
            ),
      ),
          );
  }
}