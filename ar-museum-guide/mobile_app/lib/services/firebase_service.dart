import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/exhibit.dart';

class FirebaseService {
  final CollectionReference _exhibits =
      FirebaseFirestore.instance.collection('exhibits');

  Future<List<Map<String, dynamic>>> getExhibits() async {
    final snapshot = await _exhibits.get();
    return snapshot.docs
        .map((doc) => {...doc.data() as Map<String, dynamic>, 'id': doc.id})
        .toList();
  }

  Future<Map<String, dynamic>> getExhibitDetails(String exhibitId) async {
    final doc = await _exhibits.doc(exhibitId).get();
    return {...doc.data() as Map<String, dynamic>, 'id': doc.id};
  }

  Future<void> cacheExhibits() async {
    await FirebaseFirestore.instance.enablePersistence();
  }
}