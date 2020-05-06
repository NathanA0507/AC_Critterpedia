///User takes the Firebase_Auth user and converts it to a simpler form with just
///the [uid].
class User {
  ///[uid] is the UserID for firestore and is guaranteed to be unique.
  final String uid;

  User({this.uid});
}
