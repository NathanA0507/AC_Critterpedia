import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:critterpedia/models/bugs.dart';
import 'package:critterpedia/models/fish.dart';
import 'package:critterpedia/models/user.dart';
import 'package:critterpedia/services/database.dart';
import 'package:critterpedia/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:critterpedia/screens/home/lists/fish.dart';
import 'package:critterpedia/screens/home/lists/bugs.dart';

/// Will show all fish/bugs that are currently available
class Available extends StatefulWidget {
  @override
  _AvailableState createState() => _AvailableState();
}

class _AvailableState extends State<Available> {
  @override
  Widget build(BuildContext context) {
    final fish = Provider.of<List<Fish>>(context) ?? [];
    final bugs = Provider.of<List<Bug>>(context) ?? [];
    final user = Provider.of<User>(context);
    final db = DatabaseService(uid: user.uid);
    var month = DateTime.now().month;
    var hour = DateTime.now().hour;
    return FutureBuilder<DocumentSnapshot>(
        future: db.inventory.document(user.uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Loading();
          } else {
            return Column(children: <Widget>[
              Text("Available Now!"),
              Text("Fish"),
              Expanded(
                child: ListView.builder(
                    itemCount: fish.length,
                    itemBuilder: (context, index) {
                      if (!fish[index].months_n.contains(_numToMonth(month))) {
                        return Container();
                      }
                      if (fish[index].startTime <= fish[index].endTime) {
                        if (!(hour >= fish[index].startTime &&
                            hour <= fish[index].endTime)) {
                          return Container();
                        }
                      } else {
                        if (!(hour <= fish[index].startTime ||
                            hour >= fish[index].endTime)) {
                          return Container();
                        }
                      }

                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return FishDetailScreen(fish[index]);
                            }));
                          },
                          leading: Image.asset(
                              'assets/fish/NH-Icon-${fish[index].name.toLowerCase().replaceAll(" ", '').replaceAll('-', '').replaceAll("'", '').replaceAll(".", '')}.png'),
                          title: Text(fish[index].name),
                          trailing: Checkbox(
                              value: snapshot.data['fish'][fish[index].docId] ??
                                  false,
                              onChanged: (val) async {
                                if (snapshot.data['fish'][fish[index].docId] !=
                                        null &&
                                    snapshot.data['fish'][fish[index].docId]) {
                                  await db.removeFish(fish[index].docId);
                                } else
                                  await db.addFish(fish[index].docId);
                                setState(() {});
                              }),
                        ),
                      );
                    }),
              ),
              SizedBox(
                height: 20,
              ),
              Text("Bugs"),
              Expanded(
                child: ListView.builder(
                    itemCount: bugs.length,
                    itemBuilder: (context, index) {
                      print(hour);

                      if (!bugs[index].months_n.contains(_numToMonth(month))) {
                        return Container();
                      }
                      if (bugs[index].startTime <= bugs[index].endTime) {
                        if (!(hour >= bugs[index].startTime &&
                            hour <= bugs[index].endTime)) {
                          return Container();
                        }
                      } else {
                        if (!(hour <= bugs[index].startTime ||
                            hour >= bugs[index].endTime)) {
                          return Container();
                        }
                      }

                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(builder: (context) {
                              return BugsDetailScreen(bugs[index]);
                            }));
                          },
                          leading: Image.asset(
                              'assets/bugs/NH-Icon-${bugs[index].name.toLowerCase().replaceAll(" ", '').replaceAll('-', '').replaceAll("'", '').replaceAll(".", '')}.png'),
                          title: Text(bugs[index].name),
                          trailing: Checkbox(
                              value: snapshot.data['bugs'][bugs[index].docId] ??
                                  false,
                              onChanged: (val) async {
                                if (snapshot.data['bugs'][bugs[index].docId] !=
                                        null &&
                                    snapshot.data['bugs'][bugs[index].docId]) {
                                  await db.removeBug(bugs[index].docId);
                                } else
                                  await db.addBug(bugs[index].docId);
                                setState(() {});
                              }),
                        ),
                      );
                    }),
              )
            ]);
          }
        });
  }
  ///[_numToMonth()] converts a number to a month
  ///
  /// Helper method to convert DateTime.now().month to a string
  static String _numToMonth(int month) {
    switch (month) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "Mar";
      case 4:
        return "Apr";
      case 5:
        return "May";
      case 6:
        return "Jun";
      case 7:
        return "Jul";
      case 8:
        return "Aug";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
    }
    return "";
  }
}
