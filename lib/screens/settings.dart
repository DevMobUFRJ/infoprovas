import 'package:flutter/material.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:dynamic_theme/dynamic_theme.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.mainTheme.primaryColor,
        title: Text("Configurações"),
      ),
      body: Column(
        children: <Widget>[
          SwitchListTile(
            value: Theme.of(context).brightness == Brightness.dark,
            onChanged: onChanged,
            title: Text("Tema escuro"),
          ),
        ],
      ),
    );
  }
}
