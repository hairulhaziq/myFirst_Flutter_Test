import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final User? currentUser = FirebaseAuth.instance.currentUser;
  bool _showContent = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('notes')
          .where('email', isEqualTo: currentUser?.email)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return const Scaffold(body: Center(child: Text("Error")));
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        final docs = snapshot.data!.docs;
        final int noteCount = docs.length;

        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "My Notes",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            backgroundColor: Colors.blue,
            actions: [
              // Display the count in a circle or just text
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Text("$noteCount"),
                ),
              )
            ],
          ),
          body: ListView.builder(
            itemCount: noteCount,
            itemBuilder: (context, index) {
              // 3. DATA MAPPING: Convert Firestore data to your Note object
              // Note: Adjust 'Note.fromMap' if your model uses a different factory name
              final data = docs[index].data() as Map<String, dynamic>;
              // We manually map here to be safe, or use your model class:
              final String title = data['title'] ?? 'No Title';
              final String content = data['content'] ?? 'No Content';

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(content),
                    ],
                  ),
                ),
              );
            },
          ),
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.blue, foregroundColor: Colors.white,
                heroTag: "btn1", // Unique tag for multiple FABs
                onPressed: () {},
                child:
                    Icon(_showContent ? Icons.unfold_less : Icons.unfold_more),
              ),
              const SizedBox(width: 10),
              FloatingActionButton(
                backgroundColor: Colors.blue, foregroundColor: Colors.white,
                heroTag: "btn2",
                onPressed: () {},
                child: const Icon(Icons.add), // [cite: 116]
              ),
            ],
          ),
        );
      },
    );
  }
}
