import 'package:sqflite/sqflite.dart';
import 'package:wordy/module/vocabulary.dart';
import 'package:wordy/module/db.dart';

class Cache{
  bool dirty = false;
  bool hasData = false;
  List<Vocabulary> list = [];
  late Database db;

  Future<List<Vocabulary>> getAllVocab(Future<Database> source) async {
    if (!hasData || dirty) {
      db = await source;
      List<Map<String, dynamic>> allVocab = await db.rawQuery(
          "select * from vocab");
      list = List.generate(allVocab.length, (int index) {
        var row = allVocab[index];
        return Vocabulary(
            row["word"],
            row["pos"] ?? "",
            row["trans"] ?? "",
            row["meaning"] ?? "",
            [
              row["example1"] ?? "",
              row["example2"] ?? "",
              row["example3"] ?? "",
              row["example4"] ?? "",
              row["example5"] ?? "",
            ]
        );
      });
      hasData = true;
      dirty = false;
    }
    return list;
  }

  void setDirty() {
    dirty = true;
  }

  void flush() {
    hasData = false;
    dirty = false;
  }
}

class VocabDistributor{
  static Cache uCache = Cache();
  static Cache bCache = Cache();

  static Future<List<Vocabulary>> getAllVocab({required String source}) async {
    if (source == "builtin.sql") {
      return bCache.getAllVocab(BuiltinDb.accessDatabase());
    } else {
      return uCache.getAllVocab(UserDb.accessDatabase());
    }
  }

  static Future<List<Vocabulary>> search({required String source, required String target}) async {
    Database db;

    if (source == "builtin.sql") {
      db = await BuiltinDb.accessDatabase();
    } else {
      db = await UserDb.accessDatabase();
    }

    List<Map<String, dynamic>> vocabs = await db.rawQuery("select * from vocab where word like $target or trans like $target");

    return List.generate(vocabs.length, (index) {
      var row = vocabs[index];
      return Vocabulary(row["word"], row["pos"], row["trans"], row["meaning"],
          [row["example1"], row["example2"], row["example3"], row["example4"], row["example5"]]
      );
    });
  }

  static void update({required String source, required Vocabulary vocab}) async{
    Database db;

    if (source == "builtin.sql") {
      bCache.setDirty();
      db = await BuiltinDb.accessDatabase();
    } else {
      uCache.setDirty();
      db = await UserDb.accessDatabase();
    }

    await db.rawInsert("insert into vocab values(${vocab.word}, ${vocab.pos}, ${vocab.trans}, ${vocab.meaning}, ${vocab.examples[0]}, ${vocab.examples[1]}, ${vocab.examples[2]}, ${vocab.examples[3]}, ${vocab.examples[4]})");
  }

  static void flushuCache(){
    uCache.flush();
  }
  static void flushbCache(){
    bCache.flush();
  }
}
