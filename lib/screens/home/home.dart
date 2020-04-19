import 'package:critterpedia/models/user.dart';
import 'package:flutter/material.dart';
import 'package:critterpedia/services/authenticate.dart';
import 'package:critterpedia/screens/home/lists/bugs.dart';
import 'package:critterpedia/screens/home/lists/available.dart';
import 'package:critterpedia/screens/home/lists/fish.dart';
import 'package:critterpedia/screens/home/lists/fossils.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {



  int _selectedIndex = 0;
  final List<Widget> _widgetOptions = <Widget> [
    Available(),
    Fish(),
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
      appBar: AppBar(
        leading: IconButton(onPressed: (){}, icon: Icon(Icons.menu)),
          title: Text('Critterpedia'),
          actions: <Widget>[
            FlatButton(
              child: Text('log out'),
              onPressed: () async {
                AuthService _auth = AuthService();
                await _auth.signOut();
              },
            )
          ]),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
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
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[800],
        unselectedItemColor: Colors.black,
        //unselectedFontSize: 10,
        //showUnselectedLabels: true,
        onTap: _onItemTapped
      ),
    );
  }
}


//class Home extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(title: Text('Home'),
//          actions: <Widget>[
//            FlatButton(
//              child: Text('log out'),
//              onPressed: () async {
//                AuthService _auth = AuthService();
//                await _auth.signOut();
//              },
//            )
//          ]),
//        bottomNavigationBar: BottomAppBar(
//
//        )
//    );
//  }
//}
