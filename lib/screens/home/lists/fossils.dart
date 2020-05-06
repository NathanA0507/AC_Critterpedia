import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:critterpedia/models/fossils.dart';
import 'package:critterpedia/models/user.dart';
import 'package:critterpedia/services/database.dart';
import 'package:critterpedia/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Shows all fossils in the game in a checklist style
class FossilList extends StatefulWidget {
  @override
  _FossilListState createState() => _FossilListState();
}

class _FossilListState extends State<FossilList> {
  @override
  Widget build(BuildContext context) {
    final fossils = Provider.of<List<Fossil>>(context) ?? [];
    final user = Provider.of<User>(context);
    final db = DatabaseService(uid: user.uid);

    return FutureBuilder<DocumentSnapshot>(
        future: db.inventory.document(user.uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            return ListView.builder(
                itemCount: fossils.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Column(children: <Widget>[
                      ListTile(
                        onTap: () {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (context) {
                            return FossilDetailScreen(fossils[index]);
                          }));
                        },
                        leading: Image.asset(
                            'assets/fossils/NH-Furniture-${fossils[index].name.toLowerCase().replaceAll(" ", '').replaceAll('-', '').replaceAll("'", '').replaceAll(".", '')}.png'),
                        title: Text(fossils[index].name),
                        trailing: Text(
                            'Amount: ${snapshot.data['fossils'][fossils[index].docId] ?? 0}',
                            style: TextStyle(fontSize: 15)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          FlatButton(
                            child: Text("Add"),
                            onPressed: () async {
                              db.addFossil(fossils[index].docId);
                              setState(() {});
                            },
                          ),
                          FlatButton(
                            child: Text("Subtract"),
                            onPressed: () async {
                              db.removeFossil(fossils[index].docId);
                              setState(() {});
                            },
                          )
                        ],
                      )
                    ]),
                  );
                });
          }
        });
  }
}

///FossilDetailScreen is a detailed view of fossils
class FossilDetailScreen extends StatelessWidget {
  final Fossil fossil;

  FossilDetailScreen(this.fossil);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(fossil.name)),
        body:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image.asset(
                  'assets/fossils/NH-Furniture-${fossil.name.toLowerCase().replaceAll(" ", '').replaceAll('-', '').replaceAll("'", '').replaceAll(".", '')}.png'),
              Text("Price: ${fossil.value} Bells"),
            ],
          ),
        ]));
  }
}
