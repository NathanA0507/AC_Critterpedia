///Bug holds the information for each bug from Firestore for use in the program.
class Bug {
  String docId;
  int startTime;
  int endTime;
  int value;
  List<dynamic> months_n;
  String location;
  String name;

  String get timeAvailable{
    if(startTime == 0 && endTime == 24){
      return "All Day";
    }
    else{
      String currAnsw = '';
      if (startTime < 12 && startTime != 0)
        currAnsw += '$startTime AM - ';
      else{
        currAnsw += '${startTime % 12} PM - ';
      }
      if (endTime < 12 && startTime != 0)
        currAnsw += '$endTime AM';
      else{
        currAnsw += '${endTime % 12} PM';
      }
      return currAnsw;
    }
  }

  Bug(
      {this.startTime,
        this.endTime,
        this.location,
        this.months_n,
        this.value,
        this.name,
        this.docId});
}
