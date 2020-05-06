class FishFilter{
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

  toString() {
    return "sea: $sea, river: $river, pond: $pond, months: $months, startHour: $startHour "
        "endHour: $endHour ";
  }
}

class BugFilter{
  bool flying;
  bool flowers;
  bool ground;
  bool trees;
  bool other;
  List<String> months;
  int startHour;
  int endHour;
  BugFilter({
    this.flying = true,
    this.flowers = true,
    this.ground = true,
    this.trees = true,
    this.other = true,
    this.months = const [],
    this.startHour = 0,
    this.endHour = 23
  });

}