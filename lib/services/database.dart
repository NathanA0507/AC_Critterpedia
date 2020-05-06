import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:critterpedia/models/fish.dart';
import 'package:critterpedia/models/bugs.dart';
import 'package:critterpedia/models/fossils.dart';

///DatabaseService handles all interactions with the database
class DatabaseService {
  ///[uid] is the UserId of the current user
  final String uid;

  DatabaseService({this.uid});

  ///[inventory] is a reference to the "inventory" table in Firebase
  final CollectionReference inventory =
      Firestore.instance.collection('inventory');

  ///[fishCollection] is a reference to the "fish" table in Firebase
  final CollectionReference fishCollection =
      Firestore.instance.collection('fish');

  ///[bugsCollection] is a reference to the "bugs" table in Firebase
  final CollectionReference bugsCollection =
      Firestore.instance.collection('bugs');

  ///[fossilsCollection] is a reference to the "fossils" table in Firebase
  final CollectionReference fossilsCollection =
      Firestore.instance.collection('fossils');

  ///[createDocument()] will create a new inventory document in firebase
  Future<void> createDocument() async {
    return await inventory
        .document(uid)
        .setData({'fish': {}, 'bugs': {}, 'fossils': {}});
  }

  ///[_fishListFromSnapshot] will take a [QuerySnapshot] and turn it into a
  ///list of [Fish]
  List<Fish> _fishListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      print(doc.data);
      return Fish(
          name: doc.data['name'] ?? '',
          startTime: doc.data['startTime'] ?? -1,
          endTime: doc.data['endTime'] ?? -1,
          value: doc.data['value'] ?? 0,
          months_n: doc.data['months_n'] ?? [dynamic],
          location: doc.data['location'] ?? '',
          docId: doc.documentID,
          shadowSize: doc.data['shadowSize'] ?? 'none');
    }).toList();
  }

  ///[fish] gets a stream of fish from the database
  Stream<List<Fish>> get fish {
    return fishCollection.snapshots().map(_fishListFromSnapshot);
  }

  ///[addFish] adds a fish to the user's inventory
  Future<void> addFish(String id) async {
    inventory.document(uid).updateData({"fish.$id": true});
  }

  ///[removeFish] removes a fish from the user's inventory
  Future<void> removeFish(String id) async {
    inventory.document(uid).updateData({"fish.$id": false});
  }

  ///[_bugsListFromSnapshot] takes a [QuerySnapshot] and returns a list of bugs
  List<Bug> _bugsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      print(doc.data);
      return Bug(
        name: doc.data['name'] ?? '',
        startTime: doc.data['startTime'] ?? -1,
        endTime: doc.data['endTime'] ?? -1,
        value: doc.data['value'] ?? 0,
        months_n: doc.data['months_n'] ?? [dynamic],
        location: doc.data['location'] ?? '',
        docId: doc.documentID,
      );
    }).toList();
  }

  ///[bugs] is a getter that returns a stream of bugs from the database
  Stream<List<Bug>> get bugs {
    return bugsCollection.snapshots().map(_bugsListFromSnapshot);
  }

  ///[addBug] adds a bug to the user's inventory
  Future<void> addBug(String id) async {
    inventory.document(uid).updateData({"bugs.$id": true});
  }

  ///[removeBug] removes a bug from the user's inventory
  Future<void> removeBug(String id) async {
    inventory.document(uid).updateData({"bugs.$id": false});
  }

  ///[_fossilsListFromSnapshot] takes a [QuerySnapshot] and returns a List of
  ///fossils
  List<Fossil> _fossilsListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      print(doc.data);
      return Fossil(
        name: doc.data['name'] ?? '',
        value: doc.data['value'] ?? 0,
        docId: doc.documentID,
      );
    }).toList();
  }

  ///[fossil] is a getter that returns a stream of fossils from the database
  Stream<List<Fossil>> get fossil {
    return fossilsCollection.snapshots().map(_fossilsListFromSnapshot);
  }

  ///[addFossil] adds a fossil to the user's inventory
  ///
  /// addFossil is different from the addBug and addFish methods because
  /// there can be excess fossils and that idea doesn't apply to bugs/fish,
  /// so instead of a boolean it stores a number in the database
  Future<void> addFossil(String id) async {
    inventory.document(uid).updateData(
        {"fossils.${id.replaceAll('.', '')}": FieldValue.increment(1)});
  }

  ///[removeFossil] removes a fossil from the user's inventory
  Future<void> removeFossil(String id) async {
    inventory
        .document(uid)
        .updateData({"fossils.$id": FieldValue.increment(-1)});
  }
}
