import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:infoprovas/screens/home/home_body.dart';
import 'package:infoprovas/screens/drawer/drawer_screen.dart';
import 'package:infoprovas/screens/search/search_screen.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:infoprovas/utils/app_provider.dart';
import 'package:provider/provider.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  AppProvider provider;
  static String title = "InfoProvas";
  bool isSearching = false;

  TextEditingController _query = TextEditingController();
  AnimationController _animationController;

  Widget leading;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        if (isSearching) {
          closeSearch();
          return false;
        }
        return true;
      },
      child: Scaffold(
        key: _scaffoldKey,
        drawer: DrawerScreen(),
        appBar: AppBar(
          backgroundColor: Style.mainTheme.primaryColor,
          title: appBarContent(),
          leading: isSearching ? backButton() : menuButton(),
          elevation: 0.0,
          actions: <Widget>[actionAnimated()],
        ),
        body: isSearching ? SearchScreen(query: _query.text) : HomeBody(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    leading = menuButton();
  }

  Widget actionAnimated() => AnimatedCrossFade(
        firstChild: searchButton(),
        secondChild: clearButton(),
        crossFadeState:
            isSearching ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: Duration(milliseconds: 500),
      );

  Widget searchButton() => IconButton(
        icon: Icon(Icons.search, color: Colors.white),
        onPressed: () {
          _animationController.forward();
          provider.populateSearchList();
          setState(() {
            isSearching = true;
            leading = backButton();
          });
        },
      );

  Widget clearButton() => IconButton(
        icon: Icon(
          Icons.close,
          color: Colors.white,
        ),
        onPressed: () {
          _query.text = '';
        },
      );

  Widget appBarTitle() => Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title),
        ],
      );

  Widget appBarContent() {
    return AnimatedCrossFade(
      firstChild: appBarTitle(),
      secondChild: textField(),
      duration: Duration(milliseconds: 500),
      crossFadeState:
          isSearching ? CrossFadeState.showSecond : CrossFadeState.showFirst,
    );
  }

  Widget textField() {
    return TextField(
      onChanged: (value) {
        setState(() {
          SearchScreen(query: _query.text);
        });
      },
      controller: _query,
      enabled: isSearching,
      decoration: InputDecoration.collapsed(
          hintStyle: TextStyle(color: Colors.white70), hintText: 'Busca'),
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
      ),
    );
  }

  Widget menuButton() {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: _animationController,
        ),
        onPressed: () {
          _scaffoldKey.currentState.openDrawer();
        });
  }

  Widget backButton() {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: _animationController,
      ),
      onPressed: () => closeSearch(),
    );
  }

  void closeSearch() {
    _animationController.reverse();
    setState(() {
      isSearching = false;
    });
  }

  String removeAccent(String name) {
    switch (name[0]) {
      case "Á":
        return "A" + name.substring(1);
      case "É":
        return "E" + name.substring(1);
      case "Í":
        return "I" + name.substring(1);
      case "Ó":
        return "O" + name.substring(1);
      case "Ú":
        return "U" + name.substring(1);
      default:
        return name;
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
