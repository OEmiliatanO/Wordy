import 'package:sqflite/sqflite.dart';
import 'package:wordy/module/vocabulary.dart';
import 'package:wordy/module/db.dart';
import 'dart:math';

class Cache{
  bool dirty = false;
  bool hasData = false;
  List<Vocabulary> list = [];
  Vocabulary randomOne = Vocabulary(0, "", "", "", "", ["","","","",""]);
  late Database db;

  Future<List<Vocabulary>> getAllVocab(Future<Database> source) async {
    if (!hasData || dirty) {
      db = await source;
      List<Map<String, dynamic>> allVocab = await db.rawQuery(
          "select * from vocab");
      list = List.generate(allVocab.length, (int index) {
        var row = allVocab[index];
        return Vocabulary(
          row["id"],
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
      randomOne = list[Random().nextInt(list.length)];
    }
    randomOne = list[Random().nextInt(list.length)];
    return list;
  }

  int lengthOfData(Future<Database> source) {
    return list.length;
  }

  void setDirty() {
    dirty = true;
  }

  bool needRefresh(){
    return dirty;
  }

  bool hasdata(){
    return hasData;
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
      var db = await BuiltinDb.accessDatabase();
      db.rawDelete("delete from vocab where id=0");
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
      return Vocabulary(row["id"], row["word"], row["pos"], row["trans"], row["meaning"],
          [row["example1"], row["example2"], row["example3"], row["example4"], row["example5"]]
      );
    });
  }

  static void insert({required String source, required Vocabulary vocab}) async {
    Database db;

    if (source == "builtin.sql") {
      bCache.setDirty();
      db = await BuiltinDb.accessDatabase();
    } else {
      uCache.setDirty();
      db = await UserDb.accessDatabase();
    }

    await db.rawInsert("insert into vocab values(${vocab.id}, ${vocab.word}, ${vocab.pos}, ${vocab.trans}, ${vocab.meaning}, ${vocab.examples[0]}, ${vocab.examples[1]}, ${vocab.examples[2]}, ${vocab.examples[3]}, ${vocab.examples[4]})");
  }

  static void update({required String source, required Vocabulary vocab}) async {
    Database db;

    if (source == "builtin.sql") {
      bCache.setDirty();
      db = await BuiltinDb.accessDatabase();
    } else {
      uCache.setDirty();
      db = await UserDb.accessDatabase();
    }
    await db.rawUpdate("update vocab set word=${vocab.word},pos=${vocab.pos},trans=${vocab.trans},meaning=${vocab.meaning},example1=${vocab.examples[0]},example2=${vocab.examples[1]},example3=${vocab.examples[2]},example4=${vocab.examples[3]},example5=${vocab.examples[4]} where id=${vocab.id}");
  }

  static void delete({required String source, required Vocabulary vocab}) async {
    Database db;

    if (source == "builtin.sql") {
      bCache.setDirty();
      db = await BuiltinDb.accessDatabase();
    } else {
      uCache.setDirty();
      db = await UserDb.accessDatabase();
    }
    //await db.rawDelete("delete from vocab where id=0");
    await db.rawDelete("delete from vocab where id=${vocab.id}");
  }

  static void flushuCache() {
    uCache.flush();
  }
  static void flushbCache() {
    bCache.flush();
  }

  static int getuDataNumber() {
    if (uCache.needRefresh()) {
      uCache.getAllVocab(UserDb.accessDatabase());
    }
    return uCache.lengthOfData(UserDb.accessDatabase());
  }
  static int getbDataNumber() {
    if (bCache.needRefresh()) {
      bCache.getAllVocab(UserDb.accessDatabase());
    }
    return bCache.lengthOfData(BuiltinDb.accessDatabase());
  }

  static Vocabulary randPick() {
    if (Random().nextInt(10000) % 2 == 0){
      if (!uCache.hasdata()){
        uCache.getAllVocab(UserDb.accessDatabase());
      }
      if (uCache.randomOne.word == "")
        print("uCache.randomOne.id=${uCache.randomOne.id}");
      return uCache.randomOne;
    }

    if (!bCache.hasdata()){
      bCache.getAllVocab(BuiltinDb.accessDatabase());
    }
    if (bCache.randomOne.word == "") {
      print("bCache.randomOne.id=${bCache.randomOne.id}");
    }
    return bCache.randomOne;
  }
}
