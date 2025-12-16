import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Map<String, dynamic>>> farmsStream() {
    return _db.collection('farms').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final farm = doc.data();
        farm['id'] = doc.id;
        return farm;
      }).toList();
    });
  }

  Future<void> addFarm(String name, String location) {
    return _db.collection('farms').add({
      'name': name,
      'location': location,
    });
  }

  Stream<List<Map<String, dynamic>>> fieldsStream(String farmId) {
    return _db.collection('farms').doc(farmId).collection('fields').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<void> addField(String farmId, String name) {
    return _db.collection('farms').doc(farmId).collection('fields').add({
      'name': name,
    });
  }
}
