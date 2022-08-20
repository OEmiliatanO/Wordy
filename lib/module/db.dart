import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DB{
  static late Database db;
  static bool hasData = false;

  static Future<Database> initDatabase() {
    // TODO: implement initDatabase
    throw UnimplementedError();
  }

  static Future<Database> accessDatabase() {
    // TODO: implement accessDatabase
    throw UnimplementedError();
  }

  static void flush() {
    // TODO: implement flush
  }
}

class UserDb extends DB{
  static late Database db;
  static bool hasData = false;

  static Future<Database> initDatabase() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, "user.sql");

    var exists = await databaseExists(path);
    if (!exists){
      db = await openDatabase(
        join(path),
        onCreate: (db, version) {
          return db.execute("create table vocab(word TEXT,pos TEXT,trans TEXT,meaning TEXT,example1 TEXT,example2 TEXT,example3 TEXT,example4 TEXT,example5 TEXT)");
        },
        version: 2,
      );
    }
    else {
      db = await openDatabase(path);
    }

    hasData = true;
    return db;
  }

  static Future<Database> accessDatabase() async {
    if (hasData) {
      return db;
    } else {
      return await initDatabase();
    }
  }

  static void flush() {
    hasData = false;
  }
}

class BuiltinDb extends DB{
  static late Database db;
  static bool hasData = false;

  static Future<Database> initDatabase() async {
    var dbPath = await getDatabasesPath();
    var path = join(dbPath, "builtin.sql");

    await deleteDatabase(path);

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    // Copy from asset
    ByteData data = await rootBundle.load(join("assets", "builtin.sql"));
    List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    await File(path).writeAsBytes(bytes, flush: true);

    db = await openDatabase(path);
    hasData = true;
    return db;
  }

  static Future<Database> accessDatabase() async {
    if (hasData) {
      return db;
    } else {
      return await initDatabase();
    }
  }

  static void flush() {
    hasData = false;
  }
}