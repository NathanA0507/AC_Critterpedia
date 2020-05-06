import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:critterpedia/models/user.dart';
import 'package:critterpedia/screens/wrapper.dart';
import 'package:critterpedia/services/authenticate.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Critterpedia',
        theme: ThemeData(
          primarySwatch: Colors.green,
          backgroundColor: Colors.green[200]
        ),
        home: Wrapper(),
      ),
    );
  }
}
