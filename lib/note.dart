class Note {
  String id;
  String title;
  String content;
  String email;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.email,
  });

  // Factory method to create a Note from a Map (Firestore Data)
  factory Note.fromMap(Map<String, dynamic> data, String documentId) {
    return Note(
      id: documentId, // We inject the Firestore Document ID here
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      email: data['email'] ?? '',
    );
  }

  // Method to convert a Note back to a Map (Useful for saving later)
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'email': email,
    };
  }
}