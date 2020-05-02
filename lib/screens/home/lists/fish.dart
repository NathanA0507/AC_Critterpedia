import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:critterpedia/models/user.dart';
import 'package:critterpedia/services/database.dart';
import 'package:critterpedia/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:critterpedia/models/fish.dart';

//Shows all fish in the game in a checklist style
class FishList extends StatefulWidget {
  @override
  _FishListState createState() => _FishListState();
}

class _FishListState extends State<FishList> {
  @override
  Widget build(BuildContext context) {
    final fish = Provider.of<List<Fish>>(context) ?? [];
    final user = Provider.of<User>(context);
    final db = DatabaseService(uid: user.uid);

    return FutureBuilder<DocumentSnapshot>(
        future: db.inventory.document(user.uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            print(snapshot);
            print(snapshot.data['fish']['sea-bass']);
            return ListView.builder(
                itemCount: fish.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                          'https://vignette.wikia.nocookie.net/animalcrossing/images/2/22/NH-Icon-seabass.png/revision/latest?cb=20200401003130'),
                      title: Text(fish[index].name),
                      trailing: Checkbox(
                          value: snapshot.data['fish'][fish[index].docId] ?? false,
                          onChanged: (val) async {
                            if(snapshot.data['fish'][fish[index].docId]!= null && snapshot.data['fish'][fish[index].docId]){
                              await db.removeFish(fish[index].docId);
                            }
                            else
                              await db.addFish(fish[index].docId);
                            setState((){});
                          }),
                    ),
                  );
                });
          }
        });
  }
}
