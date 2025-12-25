import 'package:flutter/material.dart';
import 'note.dart'; // Ensure this matches your file name

// Define the modes as requested
enum NoteMode { view, edit, add }

class EditScreen extends StatefulWidget {
  final NoteMode mode;
  final Note? note; // Nullable because "Add" mode has no note yet

  const EditScreen({super.key, required this.mode, this.note});

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  // We will fully implement the UI logic in Task B7/B8
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Just for verification of B6
        title: Text("Mode: ${widget.mode.toString().split('.').last}"),
      ),
      body: Center(
        child: Text(
          widget.note != null
              ? "Note Title: ${widget.note!.title}"
              : "New Note",
        ),
      ),
    );
  }
}