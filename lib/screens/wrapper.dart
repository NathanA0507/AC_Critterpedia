import 'package:critterpedia/models/filter.dart';
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
      return MultiProvider(
          providers: [
            Provider<FishFilter>(
                create: (_) => FishFilter(months: ['Jan'])),
            Provider<BugFilter>(
              create: (_) => BugFilter(),
            )
          ],
          child: Home());
    }
  }
}
