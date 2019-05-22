import 'package:flutter/material.dart';
import 'package:infoprovas/screens/about.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/screens/saved_exams.dart';
import 'package:infoprovas/screens/settings.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
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
          _ItemDrawer(
            text: "Provas Salvas",
            icon: Icons.save_alt,
            onPressed: () => openSavedExamsScreen(),
          ),
          _ItemDrawer(
            text: "Configurações",
            icon: Icons.settings,
            onPressed: () => openSettingsScreen(),
          ),
          Expanded(
            child: Container(),
          ), //Spacer
          Divider(
            height: 0,
          ),
          _ItemDrawer(
            text: "Sobre",
            icon: Icons.help,
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => About()));
            },
          ),
        ],
      ),
    );
  }

  void openSavedExamsScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SavedExams()));
  }
  void openSettingsScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Settings()));
  }
}

class _ItemDrawer extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  _ItemDrawer({
    this.icon,
    this.text,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        color: Style.mainTheme.primaryColor,
      ),
      title: Text(
        text,
      ),
      onTap: onPressed,
    );
  }
}
