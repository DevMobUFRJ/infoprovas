import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infoprovas/styles/style.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.mainTheme.accentColor,
        title: Text("Fale Conosco"),
        elevation: 2.0,
      ),
      body: Material(
        child: Center(
          child: TextFormField(
            decoration: InputDecoration(
              labelText: "Email",
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(),
              ),
            ),
            validator: (value) =>
                value.isEmpty ? "Email deve ser preenchido" : null,
            keyboardType: TextInputType.emailAddress,
          ),
        ),
      ),
    );
  }
}
