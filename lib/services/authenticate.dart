import 'package:critterpedia/models/user.dart';
import 'package:critterpedia/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

///[AuthService] handles interactions between FirebaseAuth
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ///[_userFromFirebaseUser] makes a [User] from a FirebaseUser
  ///
  /// This conversion is done because we only need the uid from
  /// the firebase user and not any of the other information
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  ///[user] gets a [User] stream depending on the authentication status
  Stream<User> get user{
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  ///[signInWithEmailAndPassword] signs in a user or returns null if there is
  ///no user with that info
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e){
      print(e.toString());
      return null;
    }
  }

  ///[registerWithEmailAndPassword] will register a user with FirebaseAuth and
  ///will return null if it is not possible to do so
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await DatabaseService(uid: user.uid).createDocument();
      return _userFromFirebaseUser(user);
    } catch (e){
      print(e.toString());
      return null;
    }
  }

  ///[signOut] will sign a user out of the app
  Future signOut() async {
    try{
      return await _auth.signOut();
    } catch(e){
      print(e.toString());
      return null;
    }
  }
}