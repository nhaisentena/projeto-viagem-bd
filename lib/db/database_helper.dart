import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/Carro.dart';
import '../models/Destino.dart';
import '../models/PrecioCombustible.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance= DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();



  factory DatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path=join(await getDatabasesPath(), 'viaje.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }





  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE carro (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nombre TEXT,
        autonomia REAL
      )
    ''');
    await db.execute('''
      CREATE TABLE destino (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        identificacion TEXT,
        distanciaKm REAL
      )
    ''');
    await db.execute('''
      CREATE TABLE precio_combustible (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        precioPorLitro REAL,
        combustible TEXT
      )
    ''');
  }





  Future<int> insertCarro(Carro carro) async {
    final db= await database;
    return await db.insert('carro', {
      'nombre': carro.nombre,
      'autonomia': carro.autonomia,
    });
  }

  Future<int> insertDestino(Destino destino) async {
    final db= await database;
    return await db.insert('destino', {
      'identificacion': destino.identificacion,
      'distanciaKm': destino.distanciaKm,
    });
  }

  Future<int> insertPrecioCombustible(PrecioCombustible precioCombustible) async {
    final db= await database;
    return await db.insert('precio_combustible', {
      'precioPorLitro': precioCombustible.precioPorLitro,
      'combustible': precioCombustible.combustible,
    });
  }

  

  Future<List<Map<String, dynamic>>> getAllCarros() async {
    final db= await database;
    return await db.query('carro');
  }

  Future<List<Map<String, dynamic>>> getAllDestinos() async {
    final db= await database;
    return await db.query('destino');
  }

  Future<List<Map<String, dynamic>>> getAllPreciosCombustible() async {
    final db= await database;
    return await db.query('precio_combustible');
  }
}
