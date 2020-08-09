import 'package:Sqlflite_test/AutoDirectionTextField.dart';
import 'package:Sqlflite_test/database.dart';
import 'package:flutter/material.dart';
Widget AddNote(BuildContext ctx){
  GlobalKey<FormState> _Globalkey = GlobalKey<FormState>();
  TextEditingController _title = TextEditingController();
  TextEditingController _note = TextEditingController();
  return Form(
    key: _Globalkey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("Add Note"),
        AutoDirectionTextField("Title", _title),
        AutoDirectionTextField("Note", _note),
        RaisedButton(child: Text("Add Note"),
          color: Colors.blueAccent,
          onPressed: () {
            if (_Globalkey.currentState.validate()) {
              database().addNote(DateTime.now(), _title.text, _note.text, false);
              Navigator.pop(ctx);
            }
          },
        ),SizedBox(height: 20,)
      ],
    ),
  );
}


