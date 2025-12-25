import 'package:flutter/material.dart';
import 'note.dart';

enum NoteMode { view, edit, add }

class EditScreen extends StatefulWidget {
  final NoteMode mode;
  final Note? note;

  const EditScreen({super.key, required this.mode, this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  String get _appBarTitle {
    switch (widget.mode) {
      case NoteMode.view:
        return "View Note";
      case NoteMode.edit:
        return "Edit Note";
      case NoteMode.add:
        return "Add new Note";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appBarTitle,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        automaticallyImplyLeading: false,
        actions: [
          if (widget.mode == NoteMode.edit || widget.mode == NoteMode.add)
            IconButton(
              icon: const Icon(
                Icons.check_circle,
                size: 30,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          IconButton(
            icon: const Icon(
              Icons.cancel,
              size: 30,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(""),
          ],
        ),
      ),
    );
  }
}
