import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

///Fish filter holds the info as to how the user wants to filter the fish by
class FishFilter with ChangeNotifier{
  bool sea;
  bool river;
  bool pond;
  List<String> months;
  int startHour;
  int endHour;

  FishFilter({
    this.sea = true,
    this.river = true,
    this.pond = true,
    this.months = const [],
    this.startHour = 0,
    this.endHour = 23,
  });

  void redraw(){
    notifyListeners();
  }

  toString() {
    return "sea: $sea, river: $river, pond: $pond, months: $months, startHour: $startHour "
        "endHour: $endHour ";
  }
}

///BugFilter holds the info as to how the user wants to filter the bugs by
class BugFilter with ChangeNotifier {
  bool flying;
  bool flowers;
  bool ground;
  bool trees;
  bool other;
  List<String> months;
  int startHour;
  int endHour;

  BugFilter(
      {this.flying = true,
      this.flowers = true,
      this.ground = true,
      this.trees = true,
      this.other = true,
      this.months = const [],
      this.startHour = 0,
      this.endHour = 23});

  void redraw(){
    notifyListeners();
  }
}
