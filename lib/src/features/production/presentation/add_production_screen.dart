import 'package:flutter/material.dart';
import 'package:myapp/src/features/animals/domain/animal.dart';
import 'package:myapp/src/features/production/application/production_service.dart';
import 'package:myapp/src/features/production/domain/production.dart';

class AddProductionScreen extends StatefulWidget {
  final String farmId;
  final List<Animal> animals;

  const AddProductionScreen({super.key, required this.farmId, required this.animals});

  @override
  State<AddProductionScreen> createState() => _AddProductionScreenState();
}

class _AddProductionScreenState extends State<AddProductionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _productionService = ProductionService();

  final _productionDateController = TextEditingController();
  final _quantityController = TextEditingController();
  final _observationController = TextEditingController();
  String? _selectedAnimalId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Produção')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _productionDateController,
                decoration: const InputDecoration(labelText: 'Data da Produção (dd/mm/aaaa)'),
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              DropdownButtonFormField<String>(
                hint: const Text('Selecione um animal'),
                items: widget.animals.map((animal) {
                  return DropdownMenuItem(value: animal.id, child: Text(animal.name));
                }).toList(),
                onChanged: (value) => setState(() => _selectedAnimalId = value),
                validator: (value) => value == null ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _quantityController,
                decoration: const InputDecoration(labelText: 'Quantidade (litros)'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
              ),
              TextFormField(
                controller: _observationController,
                decoration: const InputDecoration(labelText: 'Observação'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final buildContext = context;
                  if (_formKey.currentState!.validate()) {
                    final newProduction = Production(
                      productionDate: _parseDate(_productionDateController.text),
                      animalId: _selectedAnimalId!,
                      quantity: double.parse(_quantityController.text),
                      observation: _observationController.text,
                    );
                    await _productionService.addProduction(
                      widget.farmId,
                      _selectedAnimalId!,
                      newProduction,
                    );
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
    final parts = date.split('/');
    return DateTime(int.parse(parts[2]), int.parse(parts[1]), int.parse(parts[0]));
  }
}
