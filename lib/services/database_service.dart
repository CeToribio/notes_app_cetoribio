import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> createDatabase() async {
  final String databasePath = await getDatabasesPath();
  final String path = join(databasePath, 'notas.db');

  return openDatabase(path, version: 1,
      onCreate: (Database db, int version) async {
    await db
        .execute('CREATE TABLE notas(id INTEGER PRIMARY KEY, content TEXT)');
  });
}

Future<void> insertNote(Database db, String content) async {
  await db.insert('notas', {'content': content});
}

Future<List<Map<String, dynamic>>> getNotes(Database db) async {
  return await db.query('notas');
}

Future<void> updateNote(Database db, int id, String content) async {
  await db.update('notas', {'content': content},
      where: 'id = ?', whereArgs: [id]);
}

Future<void> deleteNote(Database db, int id) async {
  await db.delete('notas', where: 'id = ?', whereArgs: [id]);
}
