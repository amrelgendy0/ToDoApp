import 'package:Sqlflite_test/Future.dart';
import 'package:Sqlflite_test/Notes.dart';
import 'package:Sqlflite_test/database.dart';
import 'package:flutter/material.dart';
import 'AddNoteWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await database().initDatabase();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      home: ToDoApp(),
    );
  }
}

class ToDoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              Tab(
                text: 'UnDone Notes',
                icon: Icon(Icons.do_not_disturb_on),
              ),
              Tab(text: 'All Notes', icon: Icon(Icons.speaker_notes)),
              Tab(
                text: 'Done Notes',
                icon: Icon(Icons.done),
              ),
            ],
          ),
          title: Text("ToDo App"),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () async {
                showDialog(
                    context: context,
                    child: SimpleDialog(
                      title: AddNote(context),
                    )).then((_) {
                      //ToDO
                });
              },
            )
          ],
        ),
        body: TabBarView(
          children: [
            Futuree(dataTybes.NotesNotDone),
            Futuree(dataTybes.dataReversed),
            Futuree(dataTybes.NotesDone),
          ],
        ),
      ),
    );
  }
}
