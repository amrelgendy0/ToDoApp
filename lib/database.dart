import 'package:Sqlflite_test/Notes.dart';
import 'package:random_color/random_color.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class database {
  static Database db;
  Future<List<Notes>> get dataReversed async {
    return database.db.query('notes').then((value) => List<Notes>.generate(
        value.length, (index) => Notes.FromMap(value[index])));
  }

  Future<List<Notes>> get NotesDone async {
    return await dataReversed
        .then((value) => value.where((element) => element.isDone).toList());
  }

  Future<List<Notes>> get NotesNotDone async {
    return await dataReversed
        .then((value) => value.where((element) => !element.isDone).toList());
  }

  Future<List<Notes>> get CommingNotes async {
    return await dataReversed.then((value) => value
        .where((element) => element.dateTime.isAfter(DateTime.now()))
        .toList());
  }

  Future<List<Notes>> get PassedNotes async {
    return await dataReversed.then((value) => value
        .where((element) => element.dateTime.isBefore(DateTime.now()))
        .toList());
  }

  Future<int> addNote(
      DateTime time, String title, String note, bool isDone) async {
    return await db.insert(
        'notes',
        Notes(
                dateTime: time,
                note: note,
                title: title,
                isDone: isDone,
                color: RandomColor().randomColor(
                    colorBrightness: const ColorBrightness.custom(const Range(
                        ((ColorBrightness.maxBrightness +
                                ColorBrightness.minBrightness) ~/
                            1.2),
                        ColorBrightness.maxBrightness))))
            .toMap());
  }

//  Future<int> deleteNote(int id) async {
//    return await db.delete('notes', where: "id = ?", whereArgs: [id]);
//  }

  Future<int> deleteNoteByForce(Notes note) async {
    return await db.delete('notes',
        where:
            "note = ? AND title = ? AND isDone = ? AND dateTime = ? And color = ?",
        whereArgs: [
          note.note,
          note.title,
          note.isDone ? 1 : 0,
          note.dateTime.toString(),
          note.color.value
        ]);
  }

  Future<int> inverseDone(Notes note) async {
    return await db.update(
        "notes",
        Notes(
                dateTime: note.dateTime,
                note: note.note,
                title: note.title,
                isDone: !note.isDone,
                color: note.color)
            .toMap(),
        where:
            "note = ? AND title = ? AND isDone = ? AND dateTime = ? And color = ?",
        whereArgs: [
          note.note,
          note.title,
          note.isDone ? 1 : 0,
          note.dateTime.toString(),
          note.color.value
        ]);
  }

  Future<Database> initDatabase() async {
    db = await openDatabase(
      join(await getDatabasesPath(), 'noote.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE notes(ID INTEGER PRIMARY KEY, title TEXT, dateTime TEXT, note TEXT,isDone INTEGER,color INTEGER)",
        );
      },
      version: 1,
    );
    return db;
  }
}
