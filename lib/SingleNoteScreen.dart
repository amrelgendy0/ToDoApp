import 'package:Sqlflite_test/Notes.dart';
import 'package:flutter/material.dart';

class SingleNoteScreen extends StatelessWidget {
  Notes _note;
  SingleNoteScreen(this._note);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () {},
          child: Icon(Icons.edit),
        ),
        appBar: AppBar(
          title: Text(_note.title),
        ),
        body: Column(
          children: [
            Center(
              child: Text(
                _note.note,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 23),
              ),
            )
          ],
        ));
  }
}
