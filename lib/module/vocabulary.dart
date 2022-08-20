// schema of the database
class Vocabulary{
  String word = "", pos = "", trans = "", meaning = "";
  List<String> examples = [];

  Vocabulary(this.word, this.pos, this.trans, this.meaning, this.examples);
}