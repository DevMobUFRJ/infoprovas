import 'package:flutter/material.dart';

class InfoHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeState();
  }
}

String periodoTitulo = "Periodo";

class HomeState extends State<InfoHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          drawer: Drawer(),
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          appBar: new AppBar(
            backgroundColor: Color.fromARGB(255, 0, 0xA8, 0xA1),
            title: Text("Info Provas"),
            elevation: 2.0,
            bottom: new TabBar(indicatorColor: Colors.white, tabs: [
              new Tab(text: "Disciplina"),
              new Tab(text: "Professor"),
            ]),
          ),
          body: new ListView(
            padding: EdgeInsets.all(10.0),
            children: <Widget>[
              new Cartao(),
              ExpandableContainer(
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return new Column(children: <Widget>[
                      new ListTile(
                        title: new Text("Matéria ${index + 1}",
                            style: new TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                            textAlign: TextAlign.center),
                        subtitle: new Text(
                          "Alguma outra coisa",
                          style: new TextStyle(color: Colors.black),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      new Divider(color: Colors.black26),
                    ]);
                  },
                  itemCount: 8,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Cartao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Card(
      color: Color.fromARGB(255, 255, 255, 255),
      elevation: 5.0,
      margin: EdgeInsets.symmetric(vertical: 4.0, horizontal: 0.0),
      child: new Column(
        children: <Widget>[
          new ExpandableListView(
            title: periodoTitulo,
          )
        ],
      ),
    );
  }
}

class ExpandableList extends StatelessWidget {
  final list = new List.generate(10, (i) => "Item ${i + 1}");
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemBuilder: (context, i) => new ExpansionTile(
            title: new Text("Header ${i + 1}"),
            children: list
                .map((val) => new ListTile(
                      title: new Text(val),
                    ))
                .toList(),
          ),
      itemCount: 5,
    );
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  ExpandableContainer({
    @required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 550.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height-100.0;
    return new AnimatedContainer(
      duration: new Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ?  screenHeight : collapsedHeight,
      child: new Container(
        child: child,
      ),
    );
  }
}

class ExpandableListView extends StatefulWidget {
  final String title;

  const ExpandableListView({Key key, this.title}) : super(key: key);

  @override
  _ExpandableListViewState createState() => new _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView> {
  bool expandFlag = false;
  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: new EdgeInsets.symmetric(horizontal: 7.0),
      margin: new EdgeInsets.symmetric(
        vertical: 5.0,
      ),
      child: new Column(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.symmetric(horizontal: 5.0),
            child: new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Container(
                    child: new Text(
                  widget.title.toString(),
                  style: new TextStyle(
                    color: Colors.black87,
                    fontSize: 16.0,
                  ),
                  textAlign: TextAlign.justify,
                )),
                new IconButton(
                    icon: new Container(
                      height: 50.0,
                      width: 50.0,
                      child: new Center(
                        child: new Icon(
                          expandFlag
                              ? Icons.keyboard_arrow_up
                              : Icons.keyboard_arrow_down,
                          color: Colors.black87,
                          size: 30.0,
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        expandFlag = !expandFlag;
                      });
                    }),
              ],
            ),
          ),
          new ExpandableContainer(
              expanded: expandFlag,
              child: new ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return new Container(
                    child: new ListTile(
                      title: new Text(
                        "Periodo ${index + 1}",
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            fontWeight: FontWeight.normal,
                            color: Colors.black45),
                      ),
                      onTap: () {
                        setState(() {
                          expandFlag = !expandFlag;
                        });
                      },
                    ),
                  );
                },
                itemCount: 8,
              ))
        ],
      ),
    );
  }
}
