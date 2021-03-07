import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:posta_courier/models/city_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class CitiesDBProvider {
  CitiesDBProvider._();

  static final CitiesDBProvider db = CitiesDBProvider._();

  static Database _database;

  static Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  static initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "CityDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Cities ("
          "id INTEGER PRIMARY KEY,"
          "name_en TEXT"
          ")");
    });
  }

  static newCity(City city) async {
    final db = await database;
    var res = await db.insert("Cities", city.toMap());
    return res;
  }

  static deleteAll() async {
    final db = await database;
    db.delete("Cities");
  }

  Future<List<City>> getAllCities() async {
    final db = await database;
    var res = await db.query("Cities");
    List<City> list =
        res.isNotEmpty ? res.map((c) => City.fromJson(c)).toList() : [];
    return list;
  }
}
