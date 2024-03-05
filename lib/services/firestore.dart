import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // We get the collection of new notes
  final CollectionReference notes =
      FirebaseFirestore.instance.collection('notes');
  // CREATE(Add a new note)
  Future<void> addNote(String note) {
    return notes.add({
      'note': note,
      'timestamp': Timestamp.now(),
    });
  }

  // READ(Get new notes from the database)
  Stream<QuerySnapshot> getNotesStream() {
    try {
      final notesStream =
          notes.orderBy('timestamp', descending: true).snapshots();
      return notesStream;
    } catch (e) {
      print("Error getting notes stream: $e");
      throw e;
    }
  }

  // UPDATE(Update notes)
  Future<void> updateNote(String docId, String newNote) {
    return notes.doc(docId).update({
      'note': newNote,
      'timeStamp': Timestamp.now(),
    });
  }

  // DELETE(Delete a note)
  Future<void> deleteNote(String Docid) {
    return notes.doc(Docid).delete();
  }
}
