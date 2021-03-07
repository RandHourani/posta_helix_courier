import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:posta_courier/models/car_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ColorsDBProvider {
  ColorsDBProvider._();

  static final ColorsDBProvider db = ColorsDBProvider._();

  static Database _database;

  static Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  static initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ColorsDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Colors ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT"
          ")");
    });
  }

  static newColor(ColorModelDetails newClient) async {
    final db = await database;
    var res = await db.insert("Colors", newClient.toMap());
    return res;
  }

  static deleteAll() async {
    final db = await database;
    db.delete("Colors");
  }

  Future<List<ColorModelDetails>> getAllColors() async {
    final db = await database;
    var res = await db.query("Colors");
    List<ColorModelDetails> list = res.isNotEmpty
        ? res.map((c) => ColorModelDetails.fromJson(c)).toList()
        : [];
    return list;
  }


}
