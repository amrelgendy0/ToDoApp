import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Model/Notes.dart';
import './SingleNoteScreen.dart';
import '../Helper/database.dart';

enum dataTybes { NotesNotDone, AllNotes, NotesDone, NotesBefore, NotesAfter }

class NotesScreen extends StatefulWidget {
  NotesScreen(this._tybe);
  dataTybes _tybe;
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: handleData,
      builder: (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
        if (!snapshot.hasData)
          return Center(child: const CircularProgressIndicator());
        else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (ctx, index) {
              Notes _note = snapshot.data[index];
              return Dismissible(
                background: Container(
                  color: _note.isDone ? Colors.red : Colors.green,
                  child: Icon(
                    _note.isDone ? Icons.do_not_disturb_on : Icons.done,
                    size: 40,
                  ),
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 6,
                  ),
                ),
                confirmDismiss: (direction) {
                  setState(() {
                    database().inverseDone(_note);
                  });
                },
                key: ValueKey(index),
                child: Container(
                  color: _note.color,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 6,
                  ),
                  child: ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return SingleNoteScreen(_note);
                      }));
                    },
                    onLongPress: () {
                      return showDialog(
                        context: context,
                        builder: (ctx) => AlertDialog(
                          title: const Text('Are you sure?'),
                          content: const Text(
                            'Do you want to remove this note?',
                          ),
                          actions: <Widget>[
                            FlatButton(
                              child: const Text('No'),
                              onPressed: () {
                                Navigator.of(ctx).pop(false);
                              },
                            ),
                            FlatButton(
                              child: const Text('Yes'),
                              onPressed: () {
                                Navigator.of(ctx).pop(true);
                              },
                            ),
                          ],
                        ),
                      ).then((value) {
                        if (value == true) {
                          setState(() {
                            database().delete(_note.ID);
                          });
                        }
                      });
                    },
                    title: Text(
                        _note.title.replaceAllMapped("\n", (match) => " ")),
                    leading: _note.isDone
                        ? const Icon(
                            Icons.done,
                            color: Colors.blueAccent,
                            size: 40,
                          )
                        : const Icon(
                            Icons.do_not_disturb_on,
                            color: Colors.red,
                            size: 40,
                          ),
                    subtitle:
                        Text(_note.note.replaceAllMapped("\n", (match) => " ")),
                    trailing: Text(
                      "${DateFormat("yyyy/MM/dd\nHH:mm").format(_note.dateTime)}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }

  Future<List<Notes>> get handleData {
    switch (widget._tybe) {
      case dataTybes.NotesNotDone:
        return database().unDoneNotes;
        break;
      case dataTybes.AllNotes:
        return database().AllNotes;
        break;
      case dataTybes.NotesDone:
        return database().doneNotes;
        break;
      case dataTybes.NotesBefore:
        return database().NotesBefore;
        break;
      case dataTybes.NotesAfter:
        return database().NotesAfter;
        break;
    }
  }
}
