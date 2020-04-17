import 'package:cloud_firestore/cloud_firestore.dart';

class Login{
  String _username;
  String _password;

  String get username => _username;

  String get password => _password;

  set username(String username){
    this._username = username;
  }

  set password(String password){
    this._password = password;
  }

  Future<bool> validate() async {
    if(_username == null || _password == null){
      return false;
    }
    print("\n\n\nHello\n\n\n");
    print(Firestore.instance
        .collection('users')
        .where("username", isEqualTo: "$_username")
        .snapshots());
    return true;

  }
}