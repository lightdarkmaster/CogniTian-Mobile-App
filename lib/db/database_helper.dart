import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _db;
  DatabaseHelper._();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB('conversations.db');
    return _db!;
  }

  Future<Database> _initDB(String fileName) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, fileName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE conversations(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        prompts TEXT,
        messages TEXT
      )
    ''');
  }

  Future<int> insertConversation({
    required String title,
    required List<String> prompts,
    required List<Map<String, String>> messages,
  }) async {
    final db = await database;
    return await db.insert('conversations', {
      'title': title,
      'prompts': prompts.join('||'),
      'messages': jsonEncode(messages),
    });
  }

  Future<List<Map<String, dynamic>>> fetchAll() async {
    final db = await database;
    return await db.query('conversations', orderBy: 'id DESC');
  }

  Future<List<Map<String, String>>> fetchMessages(int id) async {
    final db = await database;
    final res = await db.query('conversations',
        columns: ['messages'], where: 'id = ?', whereArgs: [id]);
    if (res.isNotEmpty) {
      final List list = jsonDecode(res.first['messages'] as String);
      return list.map((e) => Map<String, String>.from(e)).toList();
    }
    return [];
  }
}
