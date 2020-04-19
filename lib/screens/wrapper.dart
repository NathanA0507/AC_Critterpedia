import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:critterpedia/models/user.dart';
import 'package:critterpedia/screens/authenticate/authenticate.dart';
import 'package:critterpedia/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    if(user == null){
      return Authenticate();
    } else{
      //Return home (temporary solution, will make it look nicer)
      return Home();
    }
  }
}
