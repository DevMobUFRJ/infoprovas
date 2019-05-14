import 'package:flutter/material.dart';
import 'package:project/styles/style.dart';
import 'package:project/model/test.dart';
import 'package:project/widgets/test_tile.dart';
import 'package:project/utils/database_helper.dart';

class SavedTests extends StatefulWidget {
  @override
  _SavedTestsState createState() => _SavedTestsState();
}

class _SavedTestsState extends State<SavedTests> {

  // função pra teste, salva uma nova prova na database
  void saveNewTest() async {
    List<Test> list = await DatabaseHelper.internal().getSavedTests();
    Test test;
    if (list.length == 0) {
      test = Test(1, 2015, 1, "Adriano", "Prova 1", "Computação 1");
    } else {
      Test lastTest = await DatabaseHelper.internal().getLastTest();
      test = Test(lastTest.id + 1, lastTest.year + 1, 1, "Adriano", "Prova 1",
          "Computação 1");
    }
    await DatabaseHelper.internal().saveTest(test);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Provas Salvas"),
        backgroundColor: Style.mainTheme.primaryColor,
        elevation: 0.0,
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Style.mainTheme.primaryColor,
        onPressed: saveNewTest,
      ),
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: DatabaseHelper.internal().getSavedTests(),
      builder: (_, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            physics: ScrollPhysics(parent: BouncingScrollPhysics()),
            itemCount: snapshot.data.length,
            itemBuilder: (_, int index) {
              Test test = snapshot.data[index];
              return TestTile(test);
            },
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
