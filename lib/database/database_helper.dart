import 'package:medicineremindertrialapp/models/medicationmodel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'medications.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      // onUpgrade: _onUpgrade, // Uncomment and implement if schema changes in future
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
      '''
      CREATE TABLE medications (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        dosage TEXT,
        time TEXT,
        instructions TEXT
      )
      ''',
    );
  }

  // Optional: Handle schema upgrades
  // Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
  //   // Implement upgrade logic here
  // }

  Future<int> insertMedication(Medication medication) async {
    Database db = await database;
    return await db.insert('medications', medication.toJson());
  }

  Future<int> updateMedication(Medication medication) async {
    Database db = await database;
    return await db.update(
      'medications',
      medication.toJson(),
      where: 'id = ?',
      whereArgs: [medication.id],
    );
  }

  Future<List<Medication>> getMedications() async {
    Database db = await database;
    List<Map<String, dynamic>> maps = await db.query('medications');
    return List.generate(maps.length, (i) {
      return Medication.fromJson(maps[i]);
    });
  }

  Future<int> deleteMedication(int id) async {
    Database db = await database;
    return await db.delete('medications', where: 'id = ?', whereArgs: [id]);
  }
}
