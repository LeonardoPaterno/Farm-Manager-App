import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> farmsStream() {
    return _db.collection('farms').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> addFarm(String name, String location) {
    return _db.collection('farms').add({
      'name': name,
      'location': location,
    });
  }
}
