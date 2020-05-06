import 'package:flutter/material.dart';
import 'package:critterpedia/models/filter.dart';

///Shows options for filtering bugs in a BottomSheet
class BugFilterOptions extends StatefulWidget {
  ///[filter] is the same filter that the BugList screen uses
  final BugFilter filter;
  BugFilterOptions(this.filter);

  @override
  _BugFilterOptionsState createState() => _BugFilterOptionsState();
}

class _BugFilterOptionsState extends State<BugFilterOptions> {
  BugFilter tempBugFilter = BugFilter(
      ground: false,
      flowers: false,
      flying: false,
      trees: false,
      other: false,
      startHour: 0,
      endHour: 23,
      months: []);

  @override
  Widget build(BuildContext context) {

    List<String> times = [
      '12 AM',
      "1 AM",
      '2 AM',
      '3 AM',
      '4 AM',
      '5 AM',
      '6 AM',
      '7 AM',
      '8 AM',
      '9 AM',
      '10 AM',
      '11 AM',
      '12 PM',
      '1 PM',
      '2 PM',
      '3 PM',
      '4 PM',
      '5 PM',
      '6 PM',
      '7 PM',
      '8 PM',
      '9 PM',
      '10 PM',
      '11 PM'
    ];
    List<DropdownMenuItem<String>> items = [];
    for (var i = 0; i < times.length; i++) {
      items.add(DropdownMenuItem(value: times[i], child: Text(times[i])));
    }

    return Form(
        child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text("Location"),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: tempBugFilter.flowers ?? false,
                              onChanged: (val) {
                                setState(() {
                                  tempBugFilter.flowers = val;
                                });
                              },
                            ),
                            Text("Flowers"),
                            Checkbox(
                              value: tempBugFilter.flying ?? false,
                              onChanged: (val) {
                                setState(() {
                                  tempBugFilter.flying = val;
                                });
                              },
                            ),
                            Text("Flying")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: tempBugFilter.ground ?? false,
                              onChanged: (val) {
                                setState(() {
                                  tempBugFilter.ground = val;
                                });
                              },
                            ),
                            Text("Ground"),
                            Checkbox(
                              value: tempBugFilter.trees ?? false,
                              onChanged: (val) {
                                setState(() {
                                  tempBugFilter.trees = val;
                                });
                              },
                            ),
                            Text("Trees")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Checkbox(
                              value: tempBugFilter.other ?? false,
                              onChanged: (val) {
                                setState(() {
                                  tempBugFilter.other = val;
                                });
                              },
                            ),
                            Text("Other")
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text("Time"),
                        Row(
                          children: <Widget>[
                            DropdownButton(
                              itemHeight: 60,
                              value: items[tempBugFilter.startHour ?? 0].value,
                              items: items,
                              //isExpanded: true,
                              onChanged: (String curr) {
                                setState(() {
                                  tempBugFilter.startHour = _timeToNum(curr);
                                });
                              },
                            ),
                            Text(" to "),
                            DropdownButton(
                              itemHeight: 60,
                              value: items[tempBugFilter.endHour ?? 0].value,
                              items: items,
                              //isExpanded: true,
                              onChanged: (String curr) {
                                setState(() {
                                  tempBugFilter.endHour = _timeToNum(curr);
                                });
                              },
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                Text("Months"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        color: (tempBugFilter?.months?.contains("Jan") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Jan"),
                        onPressed: () {
                          if (tempBugFilter.months.contains("Jan")) {
                            tempBugFilter.months.remove("Jan");
                          } else {
                            tempBugFilter.months.add("Jan");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempBugFilter?.months?.contains("Feb") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Feb"),
                        onPressed: () {
                          print(tempBugFilter.months);
                          if (tempBugFilter.months.contains("Feb")) {
                            tempBugFilter.months.remove("Feb");
                          } else {
                            tempBugFilter.months.add("Feb");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempBugFilter?.months?.contains("Mar") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Mar"),
                        onPressed: () {
                          print(tempBugFilter.months);
                          if (tempBugFilter.months.contains("Mar")) {
                            tempBugFilter.months.remove("Mar");
                          } else {
                            tempBugFilter.months.add("Mar");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempBugFilter?.months?.contains("Apr") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Apr"),
                        onPressed: () {
                          print(tempBugFilter.months);
                          if (tempBugFilter.months.contains("Apr")) {
                            tempBugFilter.months.remove("Apr");
                          } else {
                            tempBugFilter.months.add("Apr");
                          }
                          setState(() {

                          });
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        color: (tempBugFilter?.months?.contains("May") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("May"),
                        onPressed: () {
                          print(tempBugFilter.months);
                          if (tempBugFilter.months.contains("May")) {
                            tempBugFilter.months.remove("May");
                          } else {
                            tempBugFilter.months.add("May");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempBugFilter?.months?.contains("Jun") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Jun"),
                        onPressed: () {
                          print(tempBugFilter.months);
                          if (tempBugFilter.months.contains("Jun")) {
                            tempBugFilter.months.remove("Jun");
                          } else {
                            tempBugFilter.months.add("Jun");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempBugFilter?.months?.contains("Jul") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Jul"),
                        onPressed: () {
                          print(tempBugFilter.months);
                          if (tempBugFilter.months.contains("Jul")) {
                            tempBugFilter.months.remove("Jul");
                          } else {
                            tempBugFilter.months.add("Jul");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempBugFilter?.months?.contains("Aug") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Aug"),
                        onPressed: () {
                          print(tempBugFilter.months);
                          if (tempBugFilter.months.contains("Aug")) {
                            tempBugFilter.months.remove("Aug");
                          } else {
                            tempBugFilter.months.add("Aug");
                          }
                          setState(() {

                          });
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                        color: (tempBugFilter?.months?.contains("Sep") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Sep"),
                        onPressed: () {
                          print(tempBugFilter.months);
                          if (tempBugFilter.months.contains("Sep")) {
                            tempBugFilter.months.remove("Sep");
                          } else {
                            tempBugFilter.months.add("Sep");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempBugFilter?.months?.contains("Oct") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Oct"),
                        onPressed: () {
                          print(tempBugFilter.months);
                          if (tempBugFilter.months.contains("Oct")) {
                            tempBugFilter.months.remove("Oct");
                          } else {
                            tempBugFilter.months.add("Oct");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempBugFilter?.months?.contains("Nov") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Nov"),
                        onPressed: () {
                          print(tempBugFilter.months);
                          if (tempBugFilter.months.contains("Nov")) {
                            tempBugFilter.months.remove("Nov");
                          } else {
                            tempBugFilter.months.add("Nov");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempBugFilter?.months?.contains("Dec") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Dec"),
                        onPressed: () {
                          print(tempBugFilter.months);
                          if (tempBugFilter.months.contains("Dec")) {
                            tempBugFilter.months.remove("Dec");
                          } else {
                            tempBugFilter.months.add("Dec");
                          }
                          setState(() {
                          });
                        })
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.grey,
                      child: Text("Cancel"),
                      onPressed: () => Navigator.pop(context),
                    ),
                    FlatButton(
                        color: Colors.greenAccent,
                        child: Text("Remove Filter"),
                        onPressed: () {
                          widget.filter.startHour = 0;
                          widget.filter.endHour = 23;
                          widget.filter.months = ['Jan', 'Feb','Mar','Apr','May',
                            'Jun','Jul','Aug','Sep','Oct','Nov','Dec'];
                          widget.filter.flying = true;
                          widget.filter.flowers = true;
                          widget.filter.ground = true;
                          widget.filter.trees = true;
                          widget.filter.other = true;

                          Navigator.pop(context);
                        }
                    ),
                    FlatButton(
                      color: Colors.green[400],
                      child: Text("Apply Filter"),
                      onPressed: (){
                        widget.filter.startHour = tempBugFilter.startHour;
                        widget.filter.endHour = tempBugFilter.endHour;
                        widget.filter.months = tempBugFilter.months;
                        widget.filter.flying = tempBugFilter.flying;
                        widget.filter.trees = tempBugFilter.trees;
                        widget.filter.flowers = tempBugFilter.flowers;
                        widget.filter.ground = tempBugFilter.ground;
                        widget.filter.other = tempBugFilter.other;

                        Navigator.pop(context);
                      },
                    )
                  ],
                )
              ],
            )));
  }

  int _timeToNum(String time){
    switch(time){
      case "12 AM" : return 0;
      case "12 PM" : return 12;
      default:
        if(time.substring(time.length-3).trim() == "PM"){
          return 12 + int.parse(time.substring(0,time.length-3));
        }
        return int.parse(time.substring(0,time.length-3));
    }
  }
}
