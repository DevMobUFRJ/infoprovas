import 'package:flutter/material.dart';

class ShortenText extends StatelessWidget {
  String type;
  ShortenText(this.type);

  @override
  Widget build(BuildContext context) {
    switch(type){
      case "Prova 1":
        return Text("P1");
      case "Prova 2":
        return Text("P2");
      case "Prova 3":
        return Text("P3");
      case "2ª Chamada":
        return Text("2ªCh");
      case "Prova Final":
        return Text("PF");
      case "Outros":
        return Text("Outros");
      default:
        return Text(type);
    }
  }
}
