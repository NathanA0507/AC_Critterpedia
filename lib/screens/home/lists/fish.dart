import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:critterpedia/models/fish.dart';
import 'package:critterpedia/models/user.dart';
import 'package:critterpedia/services/database.dart';
import 'package:critterpedia/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) {
                              return FishDetailScreen(fish[index]);
                            }));
                      },
                      leading: Image.asset('assets/fish/NH-Icon-${fish[index].name.toLowerCase().replaceAll(" ", '').replaceAll('-', '').replaceAll("'",'').replaceAll(".",'')}.png'),
                      title: Text(fish[index].name),
                      trailing: Checkbox(
                          value: snapshot.data['fish'][fish[index].docId] ??
                              false,
                          onChanged: (val) async {
                            if (snapshot.data['fish'][fish[index].docId] !=
                                null &&
                                snapshot.data['fish'][fish[index].docId]) {
                              await db.removeFish(fish[index].docId);
                            }
                            else
                              await db.addFish(fish[index].docId);
                            setState(() {});
                          }),
                    ),
                  );
                });
          }
        });
  }
}

class FishDetailScreen extends StatelessWidget {

  final Fish fish;

  FishDetailScreen(this.fish);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(fish.name)),
      body: Column(
        children: <Widget>[
          Image.asset('assets/fish/NH-Icon-${fish.name.toLowerCase().replaceAll(" ", '').replaceAll('-', '').replaceAll("'",'').replaceAll(".",'')}.png'),
          Text("Price: ${fish.value} Bells"),
          SizedBox(height: 10),
          Text("Shadow size: ${fish.shadowSize}"),
          SizedBox(height: 10),
          Text("Location: ${fish.location}"),
          SizedBox(height: 10),
          Text("Time available: ${fish.timeAvailable}"),
          SizedBox(height: 10),
          Text("Seasonality"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 40,
                width: 50,
                child: Card(color: (fish.months_n.contains("Jan")) ? Colors.green[400] : Colors.grey,
                    child: Center(child: Text("Jan",style: TextStyle(fontSize: 20, color: Colors.white),))),
              ),
              Container(
                height: 40,
                width: 50,
                child: Card(color: (fish.months_n.contains("Feb")) ? Colors.green[400] : Colors.grey,
                    child: Center(child: Text("Feb",style: TextStyle(fontSize: 20, color: Colors.white),))),
              ),
              Container(
                height: 40,
                width: 50,
                child: Card(color: (fish.months_n.contains("Mar")) ? Colors.green[400] : Colors.grey,
                    child: Center(child: Text("Mar",style: TextStyle(fontSize: 20, color: Colors.white),))),
              ),
              Container(
                height: 40,
                width: 50,
                child: Card(color: (fish.months_n.contains("Apr")) ? Colors.green[400] : Colors.grey,
                    child: Center(child: Text("Apr",style: TextStyle(fontSize: 20, color: Colors.white),))),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 40,
                width: 50,
                child: Card(color: (fish.months_n.contains("May")) ? Colors.green[400] : Colors.grey,
                    child: Center(child: Text("May",style: TextStyle(fontSize: 20, color: Colors.white),))),
              ),
              Container(
                height: 40,
                width: 50,
                child: Card(color: (fish.months_n.contains("Jun")) ? Colors.green[400] : Colors.grey,
                    child: Center(child: Text("Jun",style: TextStyle(fontSize: 20, color: Colors.white),))),
              ),
              Container(
                height: 40,
                width: 50,
                child: Card(color: (fish.months_n.contains("Jul")) ? Colors.green[400] : Colors.grey,
                    child: Center(child: Text("Jul",style: TextStyle(fontSize: 20, color: Colors.white),))),
              ),
              Container(
                height: 40,
                width: 50,
                child: Card(color: (fish.months_n.contains("Aug")) ? Colors.green[400] : Colors.grey,
                    child: Center(child: Text("Aug",style: TextStyle(fontSize: 20, color: Colors.white),))),
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                height: 40,
                width: 50,
                child: Card(color: (fish.months_n.contains("Sep")) ? Colors.green[400] : Colors.grey,
                    child: Center(child: Text("Sep",style: TextStyle(fontSize: 20, color: Colors.white),))),
              ),
              Container(
                height: 40,
                width: 50,
                child: Card(color: (fish.months_n.contains("Oct")) ? Colors.green[400] : Colors.grey,
                    child: Center(child: Text("Oct",style: TextStyle(fontSize: 20, color: Colors.white),))),
              ),
              Container(
                height: 40,
                width: 50,
                child: Card(color: (fish.months_n.contains("Nov")) ? Colors.green[400] : Colors.grey,
                    child: Center(child: Text("Nov",style: TextStyle(fontSize: 20, color: Colors.white),))),
              ),
              Container(
                height: 40,
                width: 50,
                child: Card(color: (fish.months_n.contains("Dec")) ? Colors.green[400] : Colors.grey,
                    child: Center(child: Text("Dec",style: TextStyle(fontSize: 20, color: Colors.white),))),
              )
            ],
          ),
        ],
      )
    );
  }
}

