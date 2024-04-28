import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import '../models/note.dart';

class NoteProvider with ChangeNotifier {
  final Database db;
  List<Note> _notes = [];

  NoteProvider({required this.db}) {
    loadNotes();
  }

  List<Note> get notes => _notes;

  Future<void> loadNotes() async {
    final List<Map<String, dynamic>> notesMap = await db.query('notas');
    _notes = notesMap
        .map((noteMap) => Note(id: noteMap['id'], content: noteMap['content']))
        .toList();
    notifyListeners();
  }

  Future<void> insert(String content) async {
    final id = await db.insert('notas', {'content': content});
    final note = Note(id: id, content: content);
    _notes.add(note);
    notifyListeners();
  }

  Future<void> update(int id, String content) async {
    await db.update('notas', {'content': content},
        where: 'id = ?', whereArgs: [id]);
    final note = _notes.firstWhere((note) => note.id == id);
    note.content = content;
    notifyListeners();
  }

  Future<void> delete(int id) async {
    await db.delete('notas', where: 'id = ?', whereArgs: [id]);
    _notes.removeWhere((note) => note.id == id);
    notifyListeners();
  }
}
