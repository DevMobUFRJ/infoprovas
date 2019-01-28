import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/config/globalState.dart';
import 'package:project/model/course.dart';
import 'package:project/screens/infoHome.dart';
import 'package:project/styles/style.dart';

class CourseSelection extends StatefulWidget {
  @override
  _CouseSelectionState createState() => _CouseSelectionState();
}

class _CouseSelectionState extends State<CourseSelection> {
  Course courseSelected;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset("assets/devmob-logo.png", //TODO Logo do Infoprovas
              height: 120.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _buildDropdown(),
            ],
          ),
          MaterialButton(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Text("Continuar"),
            ),
            color: Style.themePrincipal.primaryColor,
            textColor: Colors.white,
            onPressed: (){
              GlobalState.course = courseSelected;
              // Substitui a rota atual para que o usuário não volte mais pra cá
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => InfoHome()));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown(){
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection(Course.collectionName)
          .orderBy("nome")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        if (snapshot.data.documents.length == 0){
          return Text("Erro - Não há cursos cadastrados");
        }

        return _buildItem(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildItem(BuildContext context, List<DocumentSnapshot> data){
    return DropdownButton<Course>(
      items: data.map( (DocumentSnapshot doc) {
        Course course = Course.fromMap(doc.data, reference: doc.reference);

        return DropdownMenuItem<Course>(
          value: course,
          child: Text(course.nome),
        );
      }).toList(),
      hint: Text("Escolha um curso"),
      onChanged: (Course c){
        setState(() {
          courseSelected = c;
        });
      },
      value: courseSelected,
    );
  }
}

