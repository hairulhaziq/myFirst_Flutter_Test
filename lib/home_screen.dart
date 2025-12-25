import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_screen.dart';
import 'note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  bool _showContent = true;
  String? _selectedNoteId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "My Notes",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('notes')
                .where('email', isEqualTo: currentUser?.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return const SizedBox();
              return Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text("${snapshot.data!.docs.length}"),
                ),
              );
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('notes')
            .where('email', isEqualTo: currentUser?.email)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Center(child: Text("Error"));
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final String noteId = docs[index].id;
              Note noteObj = Note.fromMap(data, noteId);

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditScreen(
                                      mode: NoteMode.view,
                                      note: noteObj,
                                    ),
                                  ),
                                );
                              },
                              onLongPress: () {
                                setState(() {
                                  if (_selectedNoteId == noteId) {
                                    _selectedNoteId = null;
                                  } else {
                                    _selectedNoteId = noteId;
                                  }
                                });
                              },
                              child: Text(
                                noteObj.title,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          if (_selectedNoteId == noteId) ...[
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => EditScreen(
                                      mode: NoteMode.edit,
                                      note: noteObj,
                                    ),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.blue),
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('notes')
                                    .doc(noteId)
                                    .delete();
                              },
                            ),
                          ]
                        ],
                      ),
                      if (_showContent) ...[
                        const SizedBox(height: 8),
                        Text(noteObj.content),
                      ]
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.blue, foregroundColor: Colors.white,
            heroTag: "btn1",
            onPressed: () {
              setState(() {
                _showContent = !_showContent;
              });
            },
            child: Icon(_showContent ? Icons.unfold_less : Icons.unfold_more),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            backgroundColor: Colors.blue, foregroundColor: Colors.white,
            heroTag: "btn2",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const EditScreen(mode: NoteMode.add),
                ),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}