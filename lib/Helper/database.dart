import '../Model/Notes.dart';
import 'package:random_color/random_color.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class database {
  static Database _db;

  Future<Database> initDatabase() async {
    _db = await openDatabase(
      join(await getDatabasesPath(), 'notes.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE notes(ID INTEGER PRIMARY KEY, title TEXT, dateTime TEXT, note TEXT,isDone INTEGER,color INTEGER)",
        );
      },
      version: 1,
    );
    return _db;
  }

  Future<List<Notes>> get AllNotes async {
    return database._db.query('notes').then((value) => List<Notes>.generate(
        value.length, (index) => Notes.FromMap(value[index])));
  }

  Future<List<Notes>> _NotesFilterByDone(int done) async {
    return database._db
        .query('notes', where: "isDone = ?", whereArgs: [done]).then((value) =>
            List<Notes>.generate(
                value.length, (index) => Notes.FromMap(value[index])));
  }

  Future<List<Notes>> get doneNotes {
    return _NotesFilterByDone(1);
  }

  Future<List<Notes>> get unDoneNotes {
    return _NotesFilterByDone(0);
  }

  Future<List<Notes>> get NotesAfter async {
    return await AllNotes.then((value) => value
        .where((element) => element.dateTime.isAfter(DateTime.now()))
        .toList());
  }

  Future<List<Notes>> get NotesBefore async {
    return await AllNotes.then((value) => value
        .where((element) => element.dateTime.isBefore(DateTime.now()))
        .toList());
  }

  Future<int> addNote(
      DateTime time, String title, String note, bool isDone) async {
    return await _db.insert(
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

  Future<int> delete(int id) async {
    return await _db.delete('notes', where: "ID = ?", whereArgs: [id]);
  }

  Future<int> inverseDone(Notes note) async {
    await Edit(note, newIsDone: !note.isDone);
  }

  Future<int> Edit(Notes note,
      {String newTitle,
      String newNote,
      DateTime newDatetime,
      bool newIsDone}) async {
    return await _db.update(
        "notes",
        Notes(
                dateTime: newDatetime == null ? note.dateTime : newDatetime,
                note: newNote == null ? note.note : newNote,
                title: newTitle == null ? note.title : newTitle,
                isDone: newIsDone == null ? note.isDone : newIsDone,
                color: note.color)
            .toMap(),
        where: "ID = ?",
        whereArgs: [note.ID]);
  }

  Future<void> closeDatabase() {
    _db.close();
  }
}
