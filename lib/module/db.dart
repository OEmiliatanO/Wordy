import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Vocabulary{
  int id = 0;
  String word = "", pos = "", trans = "";
  List<String> examples = [];

  Vocabulary(this.id, this.word, this.pos, this.trans, this.examples);
}// schema

class Db{
  static Future<Database> accessDatabase() async{
    String dbPath = join(await getDatabasesPath(), 'words.sql');

    var exists = await databaseExists(dbPath);
    if (!exists)
    {
      try {
        await Directory(dirname(dbPath)).create(recursive: true);
      } catch (_) {}
	    ByteData data = await rootBundle.load(join("assets", "words.sql"));
      List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(dbPath).writeAsBytes(bytes, flush: true);
	  }

    var db = await openDatabase(dbPath);

    return db;
  }
}

class VocabFactory{
  Future<List<Vocabulary>> allVocab() async {
    var db = await Db.accessDatabase();

    List<Map<String, dynamic>> maps = await db.rawQuery("select * from vocab");
    var list = List.generate(maps.length, (int index) {
      var row = maps[index];
      return Vocabulary(
        index,
        row["word"],
        row["pos"],
        row["trans"],
        [
          row["example1"] ?? "",
          row["example2"] ?? "",
          row["example3"] ?? "",
          row["example4"] ?? "",
          row["example5"] ?? "",
        ]
      );
    });
    return list;
  }
}
