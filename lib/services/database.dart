import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:critterpedia/models/fish.dart';
import 'package:critterpedia/models/bugs.dart';
import 'package:critterpedia/models/fossils.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference inventory = Firestore.instance.collection('inventory');
  final CollectionReference fishCollection = Firestore.instance.collection('fish');
  final CollectionReference bugsCollection = Firestore.instance.collection('bugs');
  final CollectionReference fossilsCollection = Firestore.instance.collection('fossils');

  Future<void> createDocument() async {
    return await inventory.document(uid).setData({'fish' : {}, 'bugs':{}, 'fossils': {} });
  }

  List<Fish> _fishListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      print(doc.data);
      return Fish(
        name: doc.data['name'] ?? '',
        startTime: doc.data['startTime'] ?? -1,
        endTime: doc.data['endTime'] ?? -1,
        value: doc.data['value'] ?? 0,
        months_n: doc.data['months_n'] ?? [dynamic],
        location: doc.data['location'] ?? '',
        docId: doc.documentID,
        shadowSize: doc.data['shadowSize'] ?? 'none'
      );
    }).toList();
  }

  Stream<List<Fish>> get fish{
    return fishCollection.snapshots().map(_fishListFromSnapshot);
  }


  Future<void> addFish(String id) async{
    inventory.document(uid).updateData({"fish.$id": true});
  }

  Future<void> removeFish(String id) async {
    inventory.document(uid).updateData({"fish.$id":false});
  }


  List<Bug> _bugsListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
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

  Stream<List<Bug>> get bugs{
    return bugsCollection.snapshots().map(_bugsListFromSnapshot);
  }


  Future<void> addBug(String id) async{
    inventory.document(uid).updateData({"bugs.$id": true});
  }

  Future<void> removeBug(String id) async {
    inventory.document(uid).updateData({"bugs.$id":false});
  }

  List<Fossil> _fossilsListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      print(doc.data);
      return Fossil(
        name: doc.data['name'] ?? '',
        value: doc.data['value'] ?? 0,
        docId: doc.documentID,
      );
    }).toList();
  }

  Stream<List<Fossil>> get fossil{
    return fossilsCollection.snapshots().map(_fossilsListFromSnapshot);
  }


  Future<void> addFossil(String id) async{
    inventory.document(uid).updateData({"fossils.${id.replaceAll('.', '')}": FieldValue.increment(1)});
  }

  Future<void> removeFossil(String id) async {
    inventory.document(uid).updateData({"fossils.$id": FieldValue.increment(-1)});
  }


  Future<Map<String, bool>> inventoryMap(String type) async {
    var inv = await inventory.document(uid).get();
    var data = inv.data;
    return Map<String, bool>.from(data);
  }


}