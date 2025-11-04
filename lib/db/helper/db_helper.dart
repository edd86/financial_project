import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../schemes/db_schemes.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  // Private constructor
  DatabaseHelper._internal();

  // Singleton factory constructor
  factory DatabaseHelper() {
    return _instance;
  }

  // Database getter
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize database
  Future<Database> _initDatabase() async {
    // Obtiene la ruta del archivo de la base de datos
    // Validaro de entorno - Windows, linux, ios, androi
    String path = join(await getDatabasesPath(), 'financial_database.db');

    // Open/create the database at a given path
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onConfigure: _onConfigure,
    );
  }

  // Configure database for foreign key support
  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // Create tables and insert initial data
  Future<void> _onCreate(Database db, int version) async {
    // Execute all table creation scripts
    for (String scheme in dbSchemes) {
      await db.execute(scheme);
    }
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    db.close();
    _database = null;
  }

  // Exportar base de datos
  Future<File> exportDatabase() async {
    final path = await getDatabasesPath();
    final file = File(join(path, 'financial_database.db'));
    return file;
  }
}
