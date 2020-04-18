import 'package:flutter/material.dart';
import 'package:critterpedia/screens/authenticate/register.dart';
import 'package:critterpedia/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

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
