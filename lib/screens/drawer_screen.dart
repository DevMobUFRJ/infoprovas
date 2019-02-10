import 'package:flutter/material.dart';
import 'package:project/config/global_state.dart';
import 'package:project/styles/style.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return  Drawer(
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
                      Text("Curso",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 13.0,
                        ),
                      ),
                      Text(GlobalState.course.name,
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
            text: "Provas",
            icon: Icons.library_books,
            onPressed: () => Navigator.pop(context),
          ),
          _ItemDrawer(
            text: "Provas Salvas",
            icon: Icons.save_alt,
            onPressed: () => Navigator.pushNamed(context, 'savedtests'),
          ),
          _ItemDrawer(
            text: "Enviar Prova",
            icon: Icons.note_add,
            onPressed: () => Navigator.pushNamed(context, 'send'),
          ),
          Expanded(child: Container(),), //Spacer
          Divider(color: Colors.black45, height: 0,),
          _ItemDrawer(
            text: "Sobre",
            icon: Icons.help,
            onPressed: (){
              Navigator.pushNamed(context, 'about');
            },
          )
        ]
      ),
    );
  }
}


class _ItemDrawer extends StatelessWidget{
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
        style: TextStyle(
            color: Colors.black54
        ),
      ),
      onTap: onPressed,
    );
  }
}