import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{
  final String uid;
  DatabaseService({this.uid});

  final CollectionReference inventory = Firestore.instance.collection('inventory');
  final CollectionReference fish = Firestore.instance.collection('fish');
  final CollectionReference bugs = Firestore.instance.collection('bugs');
  final CollectionReference fossils = Firestore.instance.collection('fossils');

  Future<void> createDocument() async {
    return await inventory.document(uid).setData({'fish' : {}, 'bugs':{}, 'fossils': {} });
  }

  Future<void> addFish() async{

  }

  Future<void> removeFish() async {

  }


}