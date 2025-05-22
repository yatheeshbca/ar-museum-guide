import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference _exhibits =
      FirebaseFirestore.instance.collection('exhibits');

  Future<List<Map<String, dynamic>>> getExhibits() async {
    final snapshot = await _exhibits.get();
    return snapshot.docs
        .map((doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id})
        .toList();
  }

  Future<void> addExhibit(Map<String, dynamic> exhibit) async {
    await _exhibits.add(exhibit);
  }

  Future<void> deleteExhibit(String id) async {
    await _exhibits.doc(id).delete();
  }
}