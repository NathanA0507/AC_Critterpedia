import 'package:flutter/material.dart';
import 'package:critterpedia/screens/authenticate/register.dart';
import 'package:critterpedia/screens/authenticate/sign_in.dart';

///[Authenticate] is a kind of "wrapper" that shows either the [Register] class
///or the [SignIn] class depending on what view the user has
class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

///[_AuthenticateState] is the state for [Authenticate]
class _AuthenticateState extends State<Authenticate> {
  bool showRegister = true;

  void toggleView() {
    setState(() {
      showRegister = !showRegister;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showRegister){
      return Register(toggleView: toggleView,);
    }
    return SignIn(toggleView: toggleView,);

  }

}
