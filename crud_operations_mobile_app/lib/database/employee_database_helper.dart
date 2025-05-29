import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/employee.dart';

// This is where I create a local database using sqflite plugin which is similar to sqlite
class EmployeeDatabaseHelper {
  static final EmployeeDatabaseHelper _instance =
      EmployeeDatabaseHelper._internal();
  factory EmployeeDatabaseHelper() => _instance;
  EmployeeDatabaseHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    _db ??= await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'employee.db');

    return await openDatabase(
      path,
      version: 4, // 👈 Bump the version from 1 to 2
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE employees (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT,
        lastName TEXT,
        role TEXT,
        roleDescription TEXT,
        dob TEXT,
        phone TEXT,
        email TEXT
      )
    ''');
      },
    );
  }

  // api for getting employees (Read)
  Future<List<Employee>> getEmployees() async {
    final db = await database;
    final result = await db.query(
      'employees',
      orderBy: 'id DESC',
    ); // to get newest data first I have added this query
    return result.map((e) => Employee.fromMap(e)).toList();
  }

  // api for adding employees (Create)
  Future<int> insertEmployee(Employee emp) async {
    final db = await database;
    return await db.insert('employees', emp.toMap());
  }

  // api for updating employees (Update)
  Future<int> updateEmployee(Employee emp) async {
    final db = await database;
    return await db.update(
      'employees',
      emp.toMap(),
      where: 'id = ?',
      whereArgs: [emp.id],
    );
  }

  // api for deleting employees (Delete)
  Future<int> deleteEmployee(int id) async {
    final db = await database;
    return await db.delete('employees', where: 'id = ?', whereArgs: [id]);
  }
}
