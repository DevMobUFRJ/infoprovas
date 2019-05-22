import 'package:flutter/material.dart';

class ShortenText extends StatelessWidget {
  String type;
  ShortenText(this.type);

  @override
  Widget build(BuildContext context) {
    switch(type){
      case "Prova 1":
        return Text("P1");
        break;
      case "Prova 2":
        return Text("P2");
        break;
      case "Prova 3":
        return Text("P3");
        break;
      case "2ª Chamada":
        return Text("2ªCh");
        break;
      case "Prova Final":
        return Text("PF");
        break;
    };
  }
}
