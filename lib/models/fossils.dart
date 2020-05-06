///Fossil holds the information for each fossil from Firestore for use in the program.
class Fossil {
  String name;
  int value;
  String docId;

  Fossil({this.name, this.value, docId}) {
    this.docId = docId.toString().replaceAll('.', '');
  }
}
