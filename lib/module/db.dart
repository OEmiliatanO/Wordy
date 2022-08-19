import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Vocabulary{
  int id = 0;
  String word = "", pos = "", trans = "", meaning = "";
  List<String> examples = [];

  Vocabulary(this.id, this.word, this.pos, this.trans, this.meaning, this.examples);
}// schema

class Db{
  static Future<Database> accessDatabase(String dbName) async{
    String dbPath = join(await getDatabasesPath(), dbName);

    var exists = await databaseExists(dbPath);
    if (!exists)
    {
      try {
        await Directory(dirname(dbPath)).create(recursive: true);
      } catch (_) {}
	    ByteData data = await rootBundle.load(join("assets", dbName));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes, flush: true);
	  }

    return await openDatabase(dbPath);
  }
}

class VocabDistributor{
  // all vocab cache
  bool dirty = false;
  bool hasData = false;
  static List<Vocabulary> list = [];

  // select database
  String database;
  VocabDistributor({required this.database});

  Future<List<Vocabulary>> getAllVocab() async {
    if (!hasData || dirty) {
      var db = await Db.accessDatabase(database);
      List<Map<String, dynamic>> allVocab = await db.rawQuery("select * from vocab");
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
    }

    return list;
  }

  Future<List<Vocabulary>> search(String target) async{
    var db = await Db.accessDatabase(database);
    List<Map<String, dynamic>> vocabs = await db.rawQuery("select * from vocab where word like $target or trans like $target");

    return List.generate(vocabs.length, (index) {
      var row = vocabs[index];
      return Vocabulary(row["id"], row["word"], row["pos"], row["trans"], row["meaning"], row["examples"]);
    });
  }

  // TODO: update the database
  void update(Vocabulary target) async{
    dirty = true;
  }

  void flushVocab(){
    hasData = false;
    dirty = false;
  }
}
