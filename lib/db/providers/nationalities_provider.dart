import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:posta_courier/models/nationality_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class NationalitiesDBProvider {
  NationalitiesDBProvider._();

  static final NationalitiesDBProvider db = NationalitiesDBProvider._();

  static Database _database;

  static Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDB();
    return _database;
  }

  static initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "NationalitiesDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Nationalities ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT"
          ")");
    });
  }

  static newNationality(NationalityDetails newNationality) async {
    final db = await database;
    var res = await db.insert("Nationalities", newNationality.toMap());
    return res;
  }

  static deleteAll() async {
    final db = await database;
    db.delete("Nationalities");
  }

  Future<List<NationalityDetails>> getAllNationalities() async {
    final db = await database;
    var res = await db.query("Nationalities");
    List<NationalityDetails> list = res.isNotEmpty
        ? res.map((c) => NationalityDetails.fromJson(c)).toList()
        : [];
    return list;
  }


}
