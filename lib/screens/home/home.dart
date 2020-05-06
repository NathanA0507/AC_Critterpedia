import 'package:critterpedia/models/bugs.dart';
import 'package:critterpedia/models/filter.dart';
import 'package:critterpedia/services/database.dart';
import 'package:flutter/material.dart';
import 'package:critterpedia/services/authenticate.dart';
import 'package:critterpedia/screens/home/lists/bugs.dart';
import 'package:critterpedia/screens/home/lists/available.dart';
import 'package:critterpedia/screens/home/lists/fish.dart';
import 'package:critterpedia/screens/home/lists/fossils.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:critterpedia/models/fish.dart';
import 'package:critterpedia/models/fossils.dart';
import 'package:critterpedia/screens/home/filters/fish_filter.dart';
import 'package:critterpedia/screens/home/filters/bug_filter.dart';

///[Home] holds all the Lists of items and allows users to swap between them
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static FishFilter fishFilter;
  static BugFilter bugFilter;
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget>[
    MultiProvider(providers: [
      StreamProvider<List<Fish>>.value(value: DatabaseService().fish),
      StreamProvider<List<Bug>>.value(value: DatabaseService().bugs)
    ], child: Available()),
    StreamProvider<List<Fish>>.value(
        value: DatabaseService().fish, child: FishList(fishFilter)),
    StreamProvider<List<Bug>>.value(
        value: DatabaseService().bugs, child: BugList(bugFilter)),
    StreamProvider<List<Fossil>>.value(
        value: DatabaseService().fossil, child: FossilList())
  ];

  ///[_onItemTapped()] changes the view based on the index the user selects
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  ///[_rebuildAllChildren()] will rebuild all children when called
  ///
  /// This method is a bit of a hack but it allows for filtering to work since
  /// I could not figure out how to automatically rebuild after the filtering
  /// goes through
  void _rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }

    (context as Element).visitChildren(rebuild);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: Container(
              color: Colors.green[50],
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text("Hello"),
                    RaisedButton(
                      color: Colors.green,
                      child: Text('log out'),
                      onPressed: () async {
                        AuthService _auth = AuthService();
                        await _auth.signOut();
                      },
                    )
                  ]))),
      appBar: AppBar(
        title: Text('Critterpedia'),
        actions: <Widget>[
          (_selectedIndex == 1 || _selectedIndex == 2)
              ? FlatButton.icon(
                  icon: Icon(Icons.filter_list),
                  label: Text("Filter"),
                  onPressed: () async {
                    switch (_selectedIndex) {
                      case 1:
                        var fish = Provider.of<FishFilter>(context);
                        await showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return FishFilterOptions(fish);
                            });
                        _rebuildAllChildren(context);
                        break;
                      case 2:
                        var bugs = Provider.of<BugFilter>(context);
                        await showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return BugFilterOptions(bugs);
                            });
                        _rebuildAllChildren(context);
                        break;
                    }
                  },
                )
              : Container()
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.green[50],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.green[800],
          unselectedItemColor: Colors.black,
          unselectedFontSize: 14,
          selectedFontSize: 14,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          onTap: _onItemTapped,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(Icons.home), title: Text('Home')),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.fish), title: Text('Fish')),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.bug), title: Text('Bugs')),
            BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.bone), title: Text('Fossils'))
          ]),
    );
  }
}
