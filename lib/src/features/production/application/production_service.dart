import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/src/features/production/domain/production.dart';

class ProductionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Production>> productionStream(String farmId, String animalId) {
    return _db
        .collection('farms')
        .doc(farmId)
        .collection('animals')
        .doc(animalId)
        .collection('productions')
        .orderBy('productionDate', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Production.fromFirestore(doc)).toList();
    });
  }

  Future<void> addProduction(String farmId, String animalId, Production production) {
    return _db
        .collection('farms')
        .doc(farmId)
        .collection('animals')
        .doc(animalId)
        .collection('productions')
        .add(production.toFirestore());
  }
}
