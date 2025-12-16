import 'package:cloud_firestore/cloud_firestore.dart';

class Production {
  final String? id;
  final DateTime productionDate;
  final String animalId;
  final double quantity;
  final String? observation;

  Production({
    this.id,
    required this.productionDate,
    required this.animalId,
    required this.quantity,
    this.observation,
  });

  factory Production.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Production(
      id: doc.id,
      productionDate: (data['productionDate'] as Timestamp).toDate(),
      animalId: data['animalId'],
      quantity: data['quantity'].toDouble(),
      observation: data['observation'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'productionDate': Timestamp.fromDate(productionDate),
      'animalId': animalId,
      'quantity': quantity,
      'observation': observation,
    };
  }
}
