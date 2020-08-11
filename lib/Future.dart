import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Notes.dart';
import 'SingleNoteScreen.dart';
import 'database.dart';

enum dataTybes { NotesNotDone, AllNotes, NotesDone, NotesBefore, NotesAfter }

class Futuree extends StatefulWidget {
  Futuree(this.tybe);
  dataTybes tybe;

  @override
  _FutureeState createState() => _FutureeState();
}

class _FutureeState extends State<Futuree> {
  Future<List<Notes>> get handle {
    switch (widget.tybe) {
      case dataTybes.NotesNotDone:
        return database().NotesNotDone;
        break;
      case dataTybes.AllNotes:
        return database().AllNotes;
        break;
      case dataTybes.NotesDone:
        return database().NotesDone;
        break;
      case dataTybes.NotesBefore:
        return database().NotesBefore;
        break;
      case dataTybes.NotesAfter:
        return database().NotesAfter;
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: handle,
      builder: (BuildContext context, AsyncSnapshot<List<Notes>> snapshot) {
        if (!snapshot.hasData)
          return CircularProgressIndicator();
        else {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (ctx, index) {
              Notes _note = snapshot.data[index];
              return Dismissible(
                background: Container(
                  color: _note.isDone ? Colors.red : Colors.green,
                  child: Icon(
                    _note.isDone ? Icons.block : Icons.done,
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
                            database().deleteNoteByForce(_note);
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
                          )
                        : const Icon(
                            Icons.error,
                            color: Colors.red,
                          ),
                    subtitle:
                        Text(_note.note.replaceAllMapped("\n", (match) => " ")),
                    trailing: Text(
                      "${DateFormat("yyyy/MM/dd\nHH:mm").format(_note.dateTime)}\n",
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
}
