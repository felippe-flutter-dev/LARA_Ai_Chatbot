import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  static final AppDatabase _instance = AppDatabase._internal();
  factory AppDatabase() => _instance;
  AppDatabase._internal();

  Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _open();
    return _db!;
  }

  Future<Database> _open() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'lara_ai.db');

    return await openDatabase(
      path,
      version: 3,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE conversations(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          userId TEXT,
          title TEXT,
          lastMessage TEXT,
          createdAt INTEGER,
          updateAt INTEGER
        )
      ''');

        await db.execute('''
        CREATE TABLE messages(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          conversationId INTEGER,
          text TEXT,
          isUser INTEGER,
          createdAt INTEGER,
          FOREIGN KEY(conversationId) REFERENCES conversations(id) ON DELETE CASCADE
        )
      ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute(
            'ALTER TABLE conversations ADD COLUMN lastMessage TEXT DEFAULT ""',
          );
          await db.execute(
            'ALTER TABLE conversations ADD COLUMN updateAt INTEGER DEFAULT 0',
          );
        }
        if (oldVersion < 3) {
          await db.execute(
            'ALTER TABLE conversations ADD COLUMN userId TEXT DEFAULT ""',
          );
        }
      },
    );
  }

  Future<void> close() async {
    await _db?.close();
    _db = null;
  }
}
