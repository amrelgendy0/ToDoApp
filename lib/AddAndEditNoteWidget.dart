import 'package:Sqlflite_test/Notes.dart';
import 'package:flutter/material.dart';
import 'AutoDirectionTextField.dart';
import 'database.dart';
Widget AddNote(BuildContext ctx, {Notes notes}){
  TextEditingController _title = TextEditingController();
  TextEditingController _note = TextEditingController();
  if(notes!=null){
    _title.text=notes.title;
    _note.text=notes.note;
  }

  GlobalKey<FormState> _Globalkey = GlobalKey<FormState>();

  return Form(
    key: _Globalkey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        notes!=null? Text("Edit Note"):   Text("Add Note"),
        AutoDirectionTextField("Title", _title),
        AutoDirectionTextField("Note", _note),
        RaisedButton(child: Text("Add Note"),
          color: Colors.blueAccent,
          onPressed: () {
            if (_Globalkey.currentState.validate()) {
              if(notes!=null){
              database().Edit(notes,newNote: _note.text,newTitle: _title.text);
              }else{
                database().addNote(DateTime.now(), _title.text, _note.text, false);
              }
              Navigator.pop(ctx);
            }
          },
        ),SizedBox(height: 20,)
      ],
    ),
  );
}


