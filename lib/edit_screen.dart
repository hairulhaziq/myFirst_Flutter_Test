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
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _contentController.text = widget.note!.content;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  String get _appBarTitle {
    switch (widget.mode) {
      case NoteMode.view: return "View Note";
      case NoteMode.edit: return "Edit Note";
      case NoteMode.add: return "Add new Note";
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isReadOnly = widget.mode == NoteMode.view;

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
              icon: const Icon(Icons.check_circle, size: 30, color: Colors.white,),
              onPressed: () {},
            ),
          IconButton(
            icon: const Icon(Icons.cancel, size: 30, color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TITLE FIELD
            TextField(
              controller: _titleController,
              readOnly: isReadOnly,
              decoration: const InputDecoration(
                labelText: "Title",
                border: InputBorder.none,
              ),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const Divider(),

            // CONTENT FIELD
            Expanded(
              child: TextField(
                controller: _contentController,
                readOnly: isReadOnly,
                maxLines: null,
                expands: true,
                decoration: const InputDecoration(
                  labelText: "Content",
                  border: InputBorder.none,
                ),
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
