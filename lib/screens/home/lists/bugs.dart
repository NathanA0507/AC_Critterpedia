import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:critterpedia/models/bugs.dart';
import 'package:critterpedia/models/user.dart';
import 'package:critterpedia/services/database.dart';
import 'package:critterpedia/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:critterpedia/models/filter.dart';

///Shows all bugs in the game in a checklist style
class BugList extends StatefulWidget {
  final BugFilter filter;

  BugList(this.filter);

  @override
  _BugListState createState() => _BugListState();
}

class _BugListState extends State<BugList> {
  @override
  Widget build(BuildContext context) {
    final bugs = Provider.of<List<Bug>>(context) ?? [];
    final user = Provider.of<User>(context);
    final db = DatabaseService(uid: user.uid);
    return Consumer<BugFilter>(builder: (context, filter, child) {
      return FutureBuilder<DocumentSnapshot>(
          future: db.inventory.document(user.uid).get(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Loading();
            } else {
              return ListView.builder(
                  itemCount: bugs.length,
                  itemBuilder: (context, index) {
                    if (filter != null) {
                      if (!(filter.months
                                  .toSet()
                                  .intersection(bugs[index].months_n.toSet())
                                  .length >
                              0) ||
                          filter.months.isEmpty) {
                        return Container();
                      }
                      int i = filter.startHour;
                      var inRange = false;
                      print(bugs[index].name);
                      while (i != filter.endHour) {
                        if (bugs[index].startTime <= bugs[index].endTime) {
                          print(i);
                          if (i >= bugs[index].startTime &&
                              i <= bugs[index].endTime) {
                            print('True1');
                            inRange = true;
                            break;
                          }
                        } else {
                          if (i <= bugs[index].startTime ||
                              i >= bugs[index].endTime) {
                            print('True2');
                            inRange = true;
                            break;
                          }
                        }
                        i++;
                        if (i == 24) {
                          i = 0;
                        }
                      }
                      if (filter.startHour == filter.endHour) {
                        if (bugs[index].startTime <= bugs[index].endTime) {
                          if (filter.startHour >= bugs[index].startTime &&
                              filter.endHour <= bugs[index].endTime) {
                            inRange = true;
                          }
                        } else {
                          if (filter.startHour <= bugs[index].startTime ||
                              filter.endHour >= bugs[index].endTime) {
                            inRange = true;
                          }
                        }
                      }
                      if (!inRange) {
                        return Container();
                      }
                      print(bugs[index].name);
                      print(bugs[index].location);
                      bool flowers = bugs[index].location.contains("Flowers");
                      bool flying = bugs[index].location.contains("Flying");
                      bool ground = bugs[index].location.contains("Ground");
                      bool trees = bugs[index].location.contains("Tree");
                      print("$flowers \n$flying \n$ground \n$trees");

                      if (!filter.flowers && flowers) {
                        return Container();
                      }
                      if (!filter.flying && flying) {
                        return Container();
                      }
                      if (!filter.ground && ground) {
                        return Container();
                      }
                      if (!filter.trees && trees) {
                        return Container();
                      }
                      if (!filter.other &&
                          !flowers &&
                          !flying &&
                          !ground &&
                          !trees) {
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
                  });
            }
          });
    });
  }
}

///Shows a detailed view of a bug
class BugsDetailScreen extends StatelessWidget {
  final Bug bug;

  BugsDetailScreen(this.bug);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(bug.name)),
        body: Column(
          children: <Widget>[
            Image.asset(
                'assets/bugs/NH-Icon-${bug.name.toLowerCase().replaceAll(" ", '').replaceAll('-', '').replaceAll("'", '').replaceAll(".", '')}.png'),
            Text("Price: ${bug.value} Bells"),
            SizedBox(height: 10),
            Text("Location: ${bug.location}"),
            SizedBox(height: 10),
            Text("Time available: ${bug.timeAvailable}"),
            SizedBox(height: 10),
            Text("Seasonality"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 40,
                  width: 50,
                  child: Card(
                      color: (bug.months_n.contains("Jan"))
                          ? Colors.green[400]
                          : Colors.grey,
                      child: Center(
                          child: Text(
                        "Jan",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))),
                ),
                Container(
                  height: 40,
                  width: 50,
                  child: Card(
                      color: (bug.months_n.contains("Feb"))
                          ? Colors.green[400]
                          : Colors.grey,
                      child: Center(
                          child: Text(
                        "Feb",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))),
                ),
                Container(
                  height: 40,
                  width: 50,
                  child: Card(
                      color: (bug.months_n.contains("Mar"))
                          ? Colors.green[400]
                          : Colors.grey,
                      child: Center(
                          child: Text(
                        "Mar",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))),
                ),
                Container(
                  height: 40,
                  width: 50,
                  child: Card(
                      color: (bug.months_n.contains("Apr"))
                          ? Colors.green[400]
                          : Colors.grey,
                      child: Center(
                          child: Text(
                        "Apr",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 40,
                  width: 50,
                  child: Card(
                      color: (bug.months_n.contains("May"))
                          ? Colors.green[400]
                          : Colors.grey,
                      child: Center(
                          child: Text(
                        "May",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))),
                ),
                Container(
                  height: 40,
                  width: 50,
                  child: Card(
                      color: (bug.months_n.contains("Jun"))
                          ? Colors.green[400]
                          : Colors.grey,
                      child: Center(
                          child: Text(
                        "Jun",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))),
                ),
                Container(
                  height: 40,
                  width: 50,
                  child: Card(
                      color: (bug.months_n.contains("Jul"))
                          ? Colors.green[400]
                          : Colors.grey,
                      child: Center(
                          child: Text(
                        "Jul",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))),
                ),
                Container(
                  height: 40,
                  width: 50,
                  child: Card(
                      color: (bug.months_n.contains("Aug"))
                          ? Colors.green[400]
                          : Colors.grey,
                      child: Center(
                          child: Text(
                        "Aug",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: 40,
                  width: 50,
                  child: Card(
                      color: (bug.months_n.contains("Sep"))
                          ? Colors.green[400]
                          : Colors.grey,
                      child: Center(
                          child: Text(
                        "Sep",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))),
                ),
                Container(
                  height: 40,
                  width: 50,
                  child: Card(
                      color: (bug.months_n.contains("Oct"))
                          ? Colors.green[400]
                          : Colors.grey,
                      child: Center(
                          child: Text(
                        "Oct",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))),
                ),
                Container(
                  height: 40,
                  width: 50,
                  child: Card(
                      color: (bug.months_n.contains("Nov"))
                          ? Colors.green[400]
                          : Colors.grey,
                      child: Center(
                          child: Text(
                        "Nov",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))),
                ),
                Container(
                  height: 40,
                  width: 50,
                  child: Card(
                      color: (bug.months_n.contains("Dec"))
                          ? Colors.green[400]
                          : Colors.grey,
                      child: Center(
                          child: Text(
                        "Dec",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ))),
                )
              ],
            ),
          ],
        ));
  }
}
