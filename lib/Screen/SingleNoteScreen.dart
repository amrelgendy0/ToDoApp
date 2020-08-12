import './HomeScreen.dart';
import '../Widget/AddAndEditNoteWidget.dart';
import 'package:flutter/material.dart';
import '../Model/Notes.dart';

class SingleNoteScreen extends StatelessWidget {
  Notes _note;
  SingleNoteScreen(this._note);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.purple,
          onPressed: () {
            showDialog(
                context: context,
                child: SimpleDialog(
                  title: AddNote(context, notes: _note),
                )).then((_) {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return HomeScreen();
              }), (route) => false);
            });
          },
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
