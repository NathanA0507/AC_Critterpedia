import 'package:flutter/material.dart';
import 'package:critterpedia/models/filter.dart';

class FishFilterOptions extends StatefulWidget {
  final FishFilter filter;
  FishFilterOptions(this.filter);

  @override
  _FishFilterOptionsState createState() => _FishFilterOptionsState();
}

class _FishFilterOptionsState extends State<FishFilterOptions> {
  FishFilter tempFishFilter = FishFilter(
      sea: false,
      river: false,
      pond: false,
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
                              value: tempFishFilter.sea ?? false,
                              onChanged: (val) {
                                setState(() {
                                  tempFishFilter.sea = val;
                                });
                              },
                            ),
                            Text("Sea")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: tempFishFilter.river ?? false,
                              onChanged: (val) {
                                setState(() {
                                  tempFishFilter.river = val;
                                });
                              },
                            ),
                            Text("River")
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: tempFishFilter.pond ?? false,
                              onChanged: (val) {
                                setState(() {
                                  tempFishFilter.pond = val;
                                });
                              },
                            ),
                            Text("Pond")
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
                              value: items[tempFishFilter.startHour ?? 0].value,
                              items: items,
                              //isExpanded: true,
                              onChanged: (String curr) {
                                setState(() {
                                 tempFishFilter.startHour = _timeToNum(curr);
                                });
                              },
                            ),
                            Text(" to "),
                            DropdownButton(
                              itemHeight: 60,
                              value: items[tempFishFilter.endHour ?? 0].value,
                              items: items,
                              //isExpanded: true,
                              onChanged: (String curr) {
                                setState(() {
                                  tempFishFilter.endHour = _timeToNum(curr);
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
                        color: (tempFishFilter?.months?.contains("Jan") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Jan"),
                        onPressed: () {
                          if (tempFishFilter.months.contains("Jan")) {
                            tempFishFilter.months.remove("Jan");
                          } else {
                            tempFishFilter.months.add("Jan");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempFishFilter?.months?.contains("Feb") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Feb"),
                        onPressed: () {
                          print(tempFishFilter.months);
                          if (tempFishFilter.months.contains("Feb")) {
                            tempFishFilter.months.remove("Feb");
                          } else {
                            tempFishFilter.months.add("Feb");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempFishFilter?.months?.contains("Mar") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Mar"),
                        onPressed: () {
                          print(tempFishFilter.months);
                          if (tempFishFilter.months.contains("Mar")) {
                            tempFishFilter.months.remove("Mar");
                          } else {
                            tempFishFilter.months.add("Mar");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempFishFilter?.months?.contains("Apr") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Apr"),
                        onPressed: () {
                          print(tempFishFilter.months);
                          if (tempFishFilter.months.contains("Apr")) {
                            tempFishFilter.months.remove("Apr");
                          } else {
                            tempFishFilter.months.add("Apr");
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
                        color: (tempFishFilter?.months?.contains("May") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("May"),
                        onPressed: () {
                          print(tempFishFilter.months);
                          if (tempFishFilter.months.contains("May")) {
                            tempFishFilter.months.remove("May");
                          } else {
                            tempFishFilter.months.add("May");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempFishFilter?.months?.contains("Jun") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Jun"),
                        onPressed: () {
                          print(tempFishFilter.months);
                          if (tempFishFilter.months.contains("Jun")) {
                            tempFishFilter.months.remove("Jun");
                          } else {
                            tempFishFilter.months.add("Jun");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempFishFilter?.months?.contains("Jul") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Jul"),
                        onPressed: () {
                          print(tempFishFilter.months);
                          if (tempFishFilter.months.contains("Jul")) {
                            tempFishFilter.months.remove("Jul");
                          } else {
                            tempFishFilter.months.add("Jul");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempFishFilter?.months?.contains("Aug") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Aug"),
                        onPressed: () {
                          print(tempFishFilter.months);
                          if (tempFishFilter.months.contains("Aug")) {
                            tempFishFilter.months.remove("Aug");
                          } else {
                            tempFishFilter.months.add("Aug");
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
                        color: (tempFishFilter?.months?.contains("Sep") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Sep"),
                        onPressed: () {
                          print(tempFishFilter.months);
                          if (tempFishFilter.months.contains("Sep")) {
                            tempFishFilter.months.remove("Sep");
                          } else {
                            tempFishFilter.months.add("Sep");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempFishFilter?.months?.contains("Oct") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Oct"),
                        onPressed: () {
                          print(tempFishFilter.months);
                          if (tempFishFilter.months.contains("Oct")) {
                            tempFishFilter.months.remove("Oct");
                          } else {
                            tempFishFilter.months.add("Oct");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempFishFilter?.months?.contains("Nov") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Nov"),
                        onPressed: () {
                          print(tempFishFilter.months);
                          if (tempFishFilter.months.contains("Nov")) {
                            tempFishFilter.months.remove("Nov");
                          } else {
                            tempFishFilter.months.add("Nov");
                          }
                          setState(() {

                          });
                        }),
                    RaisedButton(
                        color: (tempFishFilter?.months?.contains("Dec") ?? false)
                            ? Colors.green
                            : Colors.grey,
                        child: Text("Dec"),
                        onPressed: () {
                          print(tempFishFilter.months);
                          if (tempFishFilter.months.contains("Dec")) {
                            tempFishFilter.months.remove("Dec");
                          } else {
                            tempFishFilter.months.add("Dec");
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
                        widget.filter.sea = true;
                        widget.filter.river = true;
                        widget.filter.pond = true;

                        Navigator.pop(context);
                      }
                    ),
                    FlatButton(
                      color: Colors.green[400],
                      child: Text("Apply Filter"),
                      onPressed: (){
                        widget.filter.startHour = tempFishFilter.startHour;
                        widget.filter.endHour = tempFishFilter.endHour;
                        widget.filter.months = tempFishFilter.months;
                        widget.filter.sea = tempFishFilter.sea;
                        widget.filter.river = tempFishFilter.river;
                        widget.filter.pond = tempFishFilter.pond;

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
