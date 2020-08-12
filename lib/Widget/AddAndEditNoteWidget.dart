import '../Model/Notes.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import './AutoDirectionTextField.dart';
import '../Helper/database.dart';

Widget AddNote(BuildContext ctx, {Notes notes}) {
  TextEditingController _title = TextEditingController();
  TextEditingController _note = TextEditingController();
  DateTime _date;
  if (notes != null) {
    _title.text = notes.title;
    _note.text = notes.note;
    _date = notes.dateTime;
  }
  GlobalKey<FormState> _Globalkey = GlobalKey<FormState>();
  return Form(
    key: _Globalkey,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        notes != null ? const Text("Edit Note") : const Text("Add Note"),
        AutoDirectionTextField("Title", _title),
        AutoDirectionTextField("Note", _note),
        DateTimePicker(
          type: DateTimePickerType.dateTime,
          initialValue: notes != null ? "${notes.dateTime}" : "",
          firstDate: DateTime(2000),
          icon: Icon(Icons.date_range),
          lastDate: DateTime(2100),
          dateLabelText: 'Select Date',
          onChanged: (val) {
            _date = DateTime.parse(val);
          },
          validator: (val) {
            if (val.trim() == '') {
              return 'You must Select a Date';
            }
          },
        ),
        RaisedButton(
          child: (notes != null)
              ? const Text("Edit Note")
              : const Text("Add Note"),
          color: Colors.blueAccent,
          onPressed: () {
            if (_Globalkey.currentState.validate()) {
              if (notes != null) {
                database().Edit(notes,
                    newNote: _note.text,
                    newTitle: _title.text,
                    newDatetime: _date);
              } else {
                database().addNote(_date, _title.text, _note.text, false);
              }
              Navigator.pop(ctx);
            }
          },
        ),
        const SizedBox(
          height: 20,
        )
      ],
    ),
  );
}
//            DateTime selected;
//            await showDatePicker(
//                    context: ctx,
//                    initialDate: DateTime.now(),
//                    firstDate: DateTime.now().subtract(Duration(days: 7)),
//                    lastDate: DateTime.now().add(Duration(days: 365)))
//                .then((Datetime) async {
//              await showTimePicker(context: ctx, initialTime: TimeOfDay.now())
//                  .then((timeofDay) {
//                selected = DateTime(Datetime.year, Datetime.month, Datetime.day,
//                    timeofDay.hour, timeofDay.minute);
//              });
//            });
