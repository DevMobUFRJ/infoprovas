import 'package:flutter/material.dart';
import 'package:infoprovas/screens/home/home.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:infoprovas/screens/about/about_screen.dart';
import 'package:infoprovas/utils/app_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DynamicTheme(
      defaultBrightness: Brightness.light,
      data: (brightness) => ThemeData(
        primarySwatch: Colors.teal,
        brightness: brightness,
      ),
      themedWidgetBuilder: (context, theme) {
        return ChangeNotifierProvider(
          create: (_) => AppProvider(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'InfoProvas',
            theme: theme,
            home: Home(),
            routes: <String, WidgetBuilder>{
              'about': (context) => AboutScreen(),
            },
          ),
        );
      },
    );
  }
}
