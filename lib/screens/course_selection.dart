import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:project/config/global_state.dart';
import 'package:project/model/course.dart';
import 'package:project/screens/home.dart';
import 'package:project/styles/style.dart';

class CourseSelection extends StatefulWidget {
  @override
  _CourseSelectionState createState() => _CourseSelectionState();
}

class _CourseSelectionState extends State<CourseSelection> {
  Course courseSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(
              "assets/logo.png",
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
            color: Style.mainTheme.primaryColor,
            textColor: Colors.white,
            onPressed: () {
              GlobalState.setCourse(courseSelected);
              // Substitui a rota atual para que o usuário não volte mais pra cá
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Home()));
            },
          ),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance
          .collection(Course.collectionName)
          .orderBy("nome")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        if (snapshot.data.documents.length == 0) {
          return Text("Erro - Não há cursos cadastrados");
        }

        return _buildItem(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildItem(BuildContext context, List<DocumentSnapshot> data) {
    return DropdownButton<Course>(
      items: data.map((DocumentSnapshot doc) {
        Course course = Course.fromMap(doc.data, reference: doc.reference);

        return DropdownMenuItem<Course>(
          value: course,
          child: Text(course.name),
        );
      }).toList(),
      hint: Text("Escolha um curso"),
      onChanged: (Course c) {
        setState(() {
          courseSelected = c;
        });
      },
      value: courseSelected,
    );
  }
}
