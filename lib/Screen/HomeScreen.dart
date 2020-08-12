import './NotesScreen.dart';
import '../Widget/AddAndEditNoteWidget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            tabs: [
              const Tab(
                text: 'UnDone Notes',
                icon: const Icon(Icons.do_not_disturb_on),
              ),
              const Tab(
                  text: 'All Notes', icon: const Icon(Icons.speaker_notes)),
              const Tab(
                text: 'Done Notes',
                icon: const Icon(Icons.done),
              ),
            ],
          ),
          title: const Text("ToDo App"),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () async {
                showDialog(
                    context: context,
                    child: SimpleDialog(
                      title: AddNote(context),
                    )).then((_) {
                  setState(() {});
                });
              },
            )
          ],
        ),
        body: TabBarView(
          children: [
            NotesScreen(dataTybes.NotesNotDone),
            NotesScreen(dataTybes.AllNotes),
            NotesScreen(dataTybes.NotesDone),
          ],
        ),
      ),
    );
  }
}
