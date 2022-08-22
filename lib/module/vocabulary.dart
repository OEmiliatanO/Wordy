// schema of the database
class Vocabulary{
  int id;
  String word = "", pos = "", trans = "", meaning = "";
  List<String> examples = [];

  Vocabulary(this.id,this.word, this.pos, this.trans, this.meaning, this.examples);
}