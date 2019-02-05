import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/config/global_state.dart';
import 'package:project/styles/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project/model/professor.dart';

class ProfessorTab extends StatefulWidget {
  @override
  _ProfessorTabState createState() => _ProfessorTabState();
}

class _ProfessorTabState extends State<ProfessorTab> {
  int _selectedPeriod = 0;
  GlobalState store = GlobalState.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: <Widget>[
          Flexible(
            child: _buildProfessorList(),
          ),
        ],
      ),
    );
//    return Container(
//      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
//        child: ListView.builder(
//          itemBuilder: (BuildContext context, int index) {
//            return Column(children: <Widget>[
//              ListTile(
//                title: Text(GlobalState.professors[index].name,
//                  style: TextStyle(
//                    fontWeight: FontWeight.w400,
//                    color: Colors.black
//                  ),
//                  textAlign: TextAlign.center
//                ),
//              ),
//              Divider(color: Colors.black26),
//            ]);
//          },
//          itemCount: GlobalState.professors.length,
//        ),
//
//    );
  }

  Widget _buildProfessorList() {
    return StreamBuilder<QuerySnapshot>(
      stream: GlobalState.course.reference
          .collection(Professor.collectionName)
          .orderBy("nome")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        if (snapshot.data.documents.length == 0) {
          return Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text("Não há professores"),
            ],
          );
        }

        return _buildList(snapshot.data.documents);
      },
    );
  }

  Widget _buildList(List<DocumentSnapshot> snapshot) {
    return ListView(
      shrinkWrap: true,
      children: snapshot
          .map((data) {
            Professor professor =
                Professor.fromMap(data.data, reference: data.reference);
            return _buildListItem(professor);
          })
          .where((w) => w != null)
          .toList(),
    );
  }

  Widget _buildListItem(Professor professor) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text(
            professor.name,
            style: TextStyle(fontWeight: FontWeight.w400, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          onTap: () {
            //TODO: abrir tela de provas no Firebase do professor
          },
        ),
        Divider(color: Colors.black26),
      ],
    );
  }
}
