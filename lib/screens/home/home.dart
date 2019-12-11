import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:infoprovas/model/search_item.dart';
import 'package:infoprovas/screens/professors_tab/home_professor_tab.dart';
import 'package:infoprovas/screens/subjects_tab/home_subjects_tab.dart';
import 'package:infoprovas/screens/drawer_screen.dart';
import 'package:infoprovas/screens/search_screen.dart';
import 'package:infoprovas/styles/style.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:infoprovas/repository/professor_repository.dart';
import 'package:infoprovas/repository/subject_repository.dart';
import 'package:infoprovas/model/professor.dart';
import 'package:infoprovas/model/subject.dart';
import 'package:infoprovas/utils/app_provider.dart';
import 'package:provider/provider.dart';

GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> with TickerProviderStateMixin {
  static String title = "InfoProvas";
  bool isSearching = false;

  List<Subject> _subject = <Subject>[];
  List<Professor> _professor = <Professor>[];

  TextEditingController _query = TextEditingController();
  AnimationController _animationController;

  Widget leading;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isSearching) {
          closeSearch();
          return false;
        }
        return true;
      },
      child: ChangeNotifierProvider(
        create: (_) => AppProvider(),
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
          body: isSearching
              ? SearchScreen(query: _query.text)
              : DefaultTabController(
                  length: 2,
                  child: Column(
                    children: <Widget>[
                      Material(
                        elevation: 2.0,
                        child: Container(
                          width: double.maxFinite,
                          color: Style.mainTheme.primaryColor,
                          child: Column(
                            children: <Widget>[
                              TabBar(
                                isScrollable: true,
                                indicatorSize: TabBarIndicatorSize.label,
                                indicator: BubbleTabIndicator(
                                  indicatorColor: Colors.white,
                                  indicatorHeight: 20.0,
                                  tabBarIndicatorSize:
                                      TabBarIndicatorSize.label,
                                ),
                                unselectedLabelColor: Colors.white,
                                labelColor: Style.mainTheme.primaryColor,
                                tabs: [
                                  Tab(child: Text("Disciplinas")),
                                  Tab(child: Text("Professores")),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          children: [
                            SubjectsTab(),
                            ProfessorTab(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
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
          AppProvider provider = Provider.of<AppProvider>(context);
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

  void listenForSubject() async {
    try {
      _subject.addAll(await getSubject());
      setState(() {
        _subject.sort(
            (a, b) => removeAccent(a.name).compareTo(removeAccent(b.name)));
      });
    } catch (e) {
      onFailedConnection();
    }
  }

  void listenForProfessor() async {
    try {
      _professor.addAll(await getProfessor());
      _professor
          .sort((a, b) => removeAccent(a.name).compareTo(removeAccent(b.name)));
      setState(() {});
    } catch (e) {}
  }

  void onFailedConnection() {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.only(left: 8),
          child: Text(
            "Não foi possível conectar a rede",
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Style.mainTheme.primaryColor,
        duration: Duration(minutes: 5),
        action: SnackBarAction(
          label: "Tentar novamente",
          textColor: Colors.white,
          onPressed: () {
            setState(() {
              listenForProfessor();
              listenForSubject();
            });
          },
        ),
      ),
    );
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
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    leading = menuButton();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }
}
