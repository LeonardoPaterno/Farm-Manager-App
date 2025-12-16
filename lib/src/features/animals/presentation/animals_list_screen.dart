import 'package:flutter/material.dart';
import 'package:myapp/src/features/animals/application/animal_service.dart';
import 'package:myapp/src/features/animals/domain/animal.dart';
import 'package:myapp/src/features/animals/presentation/add_animal_screen.dart';
import 'package:myapp/src/features/animals/presentation/animal_details_screen.dart';

class AnimalsListScreen extends StatelessWidget {
  final String? farmId;

  const AnimalsListScreen({super.key, this.farmId});

  @override
  Widget build(BuildContext context) {
    if (farmId == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Animais'),
        ),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Para ver os animais, por favor, primeiro selecione uma fazenda na aba "Farms".',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ),
      );
    }

    final animalService = AnimalService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Animais'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AddAnimalScreen(farmId: farmId!),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Animal>>(
        stream: animalService.animalsStream(farmId!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Ocorreu um erro.'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final animals = snapshot.data ?? [];

          if (animals.isEmpty) {
            return const Center(
              child: Text(
                'Nenhum animal cadastrado para esta fazenda.',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          return ListView.builder(
            itemCount: animals.length,
            itemBuilder: (context, index) {
              final animal = animals[index];
              return ListTile(
                title: Text(animal.name),
                subtitle: Text(animal.identification),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AnimalDetailsScreen(animal: animal, farmId: farmId!),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
