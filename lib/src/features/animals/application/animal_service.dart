import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:myapp/src/features/animals/domain/animal.dart';

class AnimalService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Animal>> animalsStream(String farmId) {
    return _db
        .collection('farms')
        .doc(farmId)
        .collection('animals')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Animal.fromFirestore(doc)).toList();
    });
  }

  Future<List<Animal>> getAnimals(String farmId) async {
    final snapshot = await _db
        .collection('farms')
        .doc(farmId)
        .collection('animals')
        .get();
    return snapshot.docs.map((doc) => Animal.fromFirestore(doc)).toList();
  }

  Future<void> addAnimal(String farmId, Animal animal) {
    return _db
        .collection('farms')
        .doc(farmId)
        .collection('animals')
        .add(animal.toFirestore());
  }

  Future<void> updateAnimal(String farmId, Animal animal) {
    return _db
        .collection('farms')
        .doc(farmId)
        .collection('animals')
        .doc(animal.id)
        .update(animal.toFirestore());
  }

  Future<void> deleteAnimal(String farmId, String animalId) {
    return _db
        .collection('farms')
        .doc(farmId)
        .collection('animals')
        .doc(animalId)
        .delete();
  }
}
