import 'package:flutter/material.dart';
import 'package:infoprovas/screens/about.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/screens/saved_exams.dart';
import 'package:infoprovas/screens/contact.dart';
import 'package:outline_material_icons/outline_material_icons.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:infoprovas/widgets/drawer_item.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  void changeBrightness() {
    DynamicTheme.of(context).setBrightness(
        Theme.of(context).brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark);
  }

  void onChanged(bool value) {
    setState(() {
      changeBrightness();
    });
  }

  void openSavedExamsScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SavedExams()));
  }

  void openContactScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ContactScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(16.0),
                  height: 100.0,
                  color: Style.mainTheme.primaryColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        "Curso",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.0,
                        ),
                      ),
                      Text(
                        "Ciência da Computação",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          DrawerItem(
            text: "Provas Salvas",
            icon: Icons.save_alt,
            onPressed: () {
              Navigator.of(context).pop();
              openSavedExamsScreen();
            },
          ),
          DrawerItem(
            text: "Fale Conosco",
            icon: OMIcons.feedback,
            onPressed: () {
              Navigator.of(context).pop();
              openContactScreen();
            },
          ),
          Divider(),
          SwitchListTile(
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: onChanged,
            title: Text("Tema escuro"),
          ),
          Expanded(
            child: Container(),
          ), //Spacer
          Divider(
            height: 0,
          ),
          DrawerItem(
            text: "Sobre",
            icon: OMIcons.info,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => About()));
            },
          ),
        ],
      ),
    );
  }
}
