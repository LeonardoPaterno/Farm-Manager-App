import 'package:flutter/material.dart';
import 'package:myapp/src/features/animals/application/animal_service.dart';
import 'package:myapp/src/features/animals/domain/animal.dart';
import 'package:myapp/src/features/production/application/production_service.dart';
import 'package:myapp/src/features/production/domain/production.dart';
import 'package:myapp/src/features/production/presentation/add_production_screen.dart';

class AnimalDetailsScreen extends StatelessWidget {
  final Animal animal;
  final String farmId;

  const AnimalDetailsScreen(
      {super.key, required this.animal, required this.farmId});

  @override
  Widget build(BuildContext context) {
    final productionService = ProductionService();
    final animalService = AnimalService();

    return Scaffold(
      appBar: AppBar(title: Text(animal.name)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Identificação: ${animal.identification}'),
                Text('Data de Nascimento: ${animal.birthDate}'),
                Text('Sexo: ${animal.sex}'),
                Text('Nome da Mãe: ${animal.motherName}'),
                Text('Identificação da Mãe: ${animal.motherIdentification}'),
                Text('Nome do Pai: ${animal.fatherName}'),
                Text('Identificação do Pai: ${animal.fatherIdentification}'),
                Text(
                    'Data da Primeira Inseminação: ${animal.firstInseminationDate}'),
                Text('Data do Primeiro Cio: ${animal.firstHeatDate}'),
                Text('Data de Cadastro: ${animal.registrationDate}'),
              ],
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Produção',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Production>>(
              stream: productionService.productionStream(farmId, animal.id!),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Ocorreu um erro.'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final productions = snapshot.data ?? [];

                return ListView.builder(
                  itemCount: productions.length,
                  itemBuilder: (context, index) {
                    final production = productions[index];
                    return ListTile(
                      title: Text(
                          '${production.productionDate.day}/${production.productionDate.month}/${production.productionDate.year}'),
                      subtitle: Text('${production.quantity} litros'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final animals = await animalService.getAnimals(farmId);
          if (context.mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    AddProductionScreen(farmId: farmId, animals: animals),
              ),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
