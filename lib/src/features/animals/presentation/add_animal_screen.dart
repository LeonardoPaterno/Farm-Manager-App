import 'package:flutter/material.dart';
import 'package:myapp/src/features/animals/application/animal_service.dart';
import 'package:myapp/src/features/animals/domain/animal.dart';

class AddAnimalScreen extends StatefulWidget {
  final String farmId;

  const AddAnimalScreen({super.key, required this.farmId});

  @override
  State<AddAnimalScreen> createState() => _AddAnimalScreenState();
}

class _AddAnimalScreenState extends State<AddAnimalScreen> {
  final _formKey = GlobalKey<FormState>();
  final _animalService = AnimalService();

  final _nameController = TextEditingController();
  final _identificationController = TextEditingController();
  final _birthDateController = TextEditingController();
  final _sexController = TextEditingController();
  final _motherNameController = TextEditingController();
  final _motherIdentificationController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _fatherIdentificationController = TextEditingController();
  final _firstInseminationDateController = TextEditingController();
  final _firstHeatDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Animal')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _identificationController,
                decoration: const InputDecoration(labelText: 'Identificação'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _birthDateController,
                decoration: const InputDecoration(labelText: 'Data de Nascimento (dd/mm/aaaa)'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _sexController,
                decoration: const InputDecoration(labelText: 'Sexo'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _motherNameController,
                decoration: const InputDecoration(labelText: 'Nome da Mãe'),
              ),
              TextFormField(
                controller: _motherIdentificationController,
                decoration: const InputDecoration(labelText: 'Identificação da Mãe'),
              ),
              TextFormField(
                controller: _fatherNameController,
                decoration: const InputDecoration(labelText: 'Nome do Pai'),
              ),
              TextFormField(
                controller: _fatherIdentificationController,
                decoration: const InputDecoration(labelText: 'Identificação do Pai'),
              ),
              TextFormField(
                controller: _firstInseminationDateController,
                decoration: const InputDecoration(labelText: 'Data da Primeira Inseminação (dd/mm/aaaa)'),
              ),
              TextFormField(
                controller: _firstHeatDateController,
                decoration: const InputDecoration(labelText: 'Data do Primeiro Cio (dd/mm/aaaa)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final buildContext = context;
                  if (_formKey.currentState!.validate()) {
                    final newAnimal = Animal(
                      name: _nameController.text,
                      identification: _identificationController.text,
                      birthDate: _parseDate(_birthDateController.text),
                      sex: _sexController.text,
                      motherName: _motherNameController.text,
                      motherIdentification: _motherIdentificationController.text,
                      fatherName: _fatherNameController.text,
                      fatherIdentification: _fatherIdentificationController.text,
                      firstInseminationDate: _parseDate(_firstInseminationDateController.text),
                      firstHeatDate: _parseDate(_firstHeatDateController.text),
                      registrationDate: DateTime.now(),
                    );
                    await _animalService.addAnimal(widget.farmId, newAnimal);
                    if (buildContext.mounted) {
                      Navigator.of(buildContext).pop();
                    }
                  }
                },
                child: const Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  DateTime _parseDate(String date) {
    if (date.isEmpty) return DateTime.now();
    final parts = date.split('/');
    return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
  }
}
