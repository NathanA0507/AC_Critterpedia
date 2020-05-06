class Fossil {
  String name;
  int value;
  String docId;

  Fossil({this.name, this.value, docId}) {
    this.docId = docId.toString().replaceAll('.', '');
  }
}
