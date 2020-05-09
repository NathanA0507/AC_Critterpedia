import 'package:critterpedia/models/filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:critterpedia/models/user.dart';
import 'package:critterpedia/screens/authenticate/authenticate.dart';
import 'package:critterpedia/screens/home/home.dart';

///[Wrapper] will determine whether to show the "LogIn" screen or the "Home" screen
///
///It does this depending on if the user is signed in or not. This is automatic,
///so the user will not need to sign in again until they sign out
class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    final allMonths = ['Jan','Feb','Mar','Apr','May','Jun','Jul','Aug','Sep','Oct'
    'Nov','Dec'];
    print(user);

    if(user == null){
      return Authenticate();
    } else{
      return MultiProvider(
          providers: [
            ChangeNotifierProvider<FishFilter>(
                create: (_) => FishFilter(months: allMonths)),
            ChangeNotifierProvider<BugFilter>(
              create: (_) => BugFilter(months: allMonths),
            )
          ],
          child: Home());
    }
  }
}
