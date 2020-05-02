import 'package:critterpedia/models/user.dart';
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


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = <Widget> [
    Available(),
    StreamProvider<List<Fish>>.value(
      value: DatabaseService().fish,
      child: FishList()),
    Bugs(),
    Fossils()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user.uid);

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
            ]
          )
        )
      ),
      appBar: AppBar(
        title: Text('Critterpedia'),
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
              icon: Icon(Icons.home),
              title: Text('Home')
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.fish),
              title: Text('Fish')
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bug),
              title: Text('Bugs')
          ),
          BottomNavigationBarItem(
              icon: FaIcon(FontAwesomeIcons.bone),
              title: Text('Fossils')
          )
        ]
      ),
    );
  }
}

