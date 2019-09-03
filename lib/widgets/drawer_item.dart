import 'package:flutter/material.dart';
import 'package:infoprovas/styles/style.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  DrawerItem({this.icon, this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Style.mainTheme.primaryColor),
      title: Text(text),
      onTap: onPressed,
    );
  }
}
