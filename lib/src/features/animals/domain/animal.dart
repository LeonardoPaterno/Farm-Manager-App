import 'package:cloud_firestore/cloud_firestore.dart';

class Animal {
  final String? id;
  final String name;
  final String identification;
  final DateTime birthDate;
  final String sex;
  final String motherName;
  final String motherIdentification;
  final String fatherName;
  final String fatherIdentification;
  final DateTime? firstInseminationDate;
  final DateTime? firstHeatDate;
  final DateTime registrationDate;

  Animal({
    this.id,
    required this.name,
    required this.identification,
    required this.birthDate,
    required this.sex,
    required this.motherName,
    required this.motherIdentification,
    required this.fatherName,
    required this.fatherIdentification,
    this.firstInseminationDate,
    this.firstHeatDate,
    required this.registrationDate,
  });

  factory Animal.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Animal(
      id: doc.id,
      name: data['name'],
      identification: data['identification'],
      birthDate: (data['birthDate'] as Timestamp).toDate(),
      sex: data['sex'],
      motherName: data['motherName'],
      motherIdentification: data['motherIdentification'],
      fatherName: data['fatherName'],
      fatherIdentification: data['fatherIdentification'],
      firstInseminationDate: data['firstInseminationDate'] != null
          ? (data['firstInseminationDate'] as Timestamp).toDate()
          : null,
      firstHeatDate: data['firstHeatDate'] != null
          ? (data['firstHeatDate'] as Timestamp).toDate()
          : null,
      registrationDate: (data['registrationDate'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'identification': identification,
      'birthDate': Timestamp.fromDate(birthDate),
      'sex': sex,
      'motherName': motherName,
      'motherIdentification': motherIdentification,
      'fatherName': fatherName,
      'fatherIdentification': fatherIdentification,
      'firstInseminationDate': firstInseminationDate != null
          ? Timestamp.fromDate(firstInseminationDate!)
          : null,
      'firstHeatDate':
          firstHeatDate != null ? Timestamp.fromDate(firstHeatDate!) : null,
      'registrationDate': Timestamp.fromDate(registrationDate),
    };
  }
}
