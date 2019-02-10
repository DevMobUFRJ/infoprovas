import 'package:flutter/material.dart';

/// Tema padrão do app, aplicado no MaterialApp no arquivo main.dart e
/// ao longo do app quando são necessárias cores para botões, textos etc.
class Style {

  // ===== TEMA PADRÃO ===== //
  static ThemeData mainTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Color.fromARGB(255, 0, 0xA8, 0xA1),
    accentColor: const Color.fromARGB(255, 0, 0xA8, 0xA1),
    primarySwatch: Colors.blue,
    primaryColorDark: const Color.fromARGB(255, 42, 92, 102),
    dividerColor: const Color.fromARGB(0, 0, 0, 0),
  );

  // ===== CORES EXTRAS ===== //
}