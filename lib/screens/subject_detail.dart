import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_pdf_viewer/flutter_pdf_viewer.dart';
import 'package:project/model/exam.dart';
import 'package:project/model/subject.dart';
import '../config/global_state.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:url_launcher/url_launcher.dart';

StorageReference storageRef = FirebaseStorage.instance.ref();

class SubjectDetail extends StatefulWidget {
  final Subject subject;

  SubjectDetail({Key key, @required this.subject}) : super(key: key);

  @override
  SubjectDetailState createState() {
    return SubjectDetailState();
  }
}

class SubjectDetailState extends State<SubjectDetail> {
  List<DocumentSnapshot> p1;
  List<DocumentSnapshot> p2;
  List<DocumentSnapshot> pf;

  @override
  void initState() {
    super.initState();
    GlobalState.course.reference
        .collection(Exam.collectionName)
        .where("disciplina", isEqualTo: widget.subject.reference.documentID)
        .where("tipo", isEqualTo: "Prova 1")
        .orderBy("semestre", descending: true)
        .snapshots()
        .forEach((q) {
      setState(() {
        p1 = q.documents;
      });
    });
    GlobalState.course.reference
        .collection(Exam.collectionName)
        .where("disciplina", isEqualTo: widget.subject.reference.documentID)
        .where("tipo", isEqualTo: "Prova 2")
        .orderBy("semestre", descending: true)
        .snapshots()
        .forEach((q) {
      setState(() {
        p2 = q.documents;
      });
    });
    GlobalState.course.reference
        .collection(Exam.collectionName)
        .where("disciplina", isEqualTo: widget.subject.reference.documentID)
        .where("tipo", isEqualTo: "Prova Final")
        .orderBy("semestre", descending: true)
        .snapshots()
        .forEach((q) {
      setState(() {
        pf = q.documents;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("${widget.subject.name}"),
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: "Prova 1"),
              Tab(text: "Prova 2"),
              Tab(text: "Prova Final"),
            ],
          ),
        ),
        body: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.topCenter,
          child: TabBarView(
            children: [
              _buildTab(p1),
              _buildTab(p2),
              _buildTab(pf),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTab(List<DocumentSnapshot> tests) {
    if (tests == null) return Container();

    if (tests.length == 0)
      return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Não há provas"),
        ],
      );

    return _buildList(tests);
//    return Container(
//      padding: EdgeInsets.all(10.0),
//      alignment: Alignment.topCenter,
//      child: StreamBuilder<QuerySnapshot>(
//        stream: GlobalState.course.reference.collection(Exam.collectionName)
//            .where("disciplina", isEqualTo: widget.subject.reference.documentID)
//            .where("tipo", isEqualTo: tipo)
//            .orderBy("semestre", descending: true)
//            .snapshots(),
//        builder: (context, snapshot) {
//          if (!snapshot.hasData) return LinearProgressIndicator();
//
//          if(snapshot.data.documents.length == 0)
//            return Row(
//              mainAxisSize: MainAxisSize.max,
//              mainAxisAlignment: MainAxisAlignment.center,
//              crossAxisAlignment: CrossAxisAlignment.center,
//              children: <Widget>[
//                Text("Não há provas"),
//              ],
//            );
//          return _buildList(snapshot.data.documents);
//        },
//      ),
//    );
  }

  Widget _buildList(List<DocumentSnapshot> snapshot) {
    return Column(children: [
      Expanded(
        child: ListView(
          children: snapshot.map((data) {
            Exam exam = Exam.fromMap(data.data, data.reference);
            return _buildListItem(exam);
          }).toList(),
        ),
      ),
    ]);
  }

  Widget _buildListItem(Exam exam) {
    return Column(children: <Widget>[
      ListTile(
        title: Text(exam.title(),
            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
            textAlign: TextAlign.center),
        onTap: () {
          _getFile(exam.filename, exam.professor);
          //PdfViewer.loadAsset('assets/${GlobalState.pdfs[index].path}');
        },
      ),
      Divider(color: Colors.black26),
    ]);
  }

  Future _getFile(String filename, String professor) async {
    //TODO: manipular a espera para pegar o url de download e abrir o navegador
    StorageReference fileReference = storageRef.child('${widget.subject.name}/$professor/$filename');
    String url = (await fileReference.getDownloadURL()).toString();
    _launchURL(url);

  }

  _launchURL(String url) async{
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
