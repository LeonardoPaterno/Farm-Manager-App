import 'package:flutter/material.dart';
import 'package:myapp/src/features/home/application/firestore_service.dart';
import 'package:myapp/src/features/home/presentation/add_farm_screen.dart';
import 'package:myapp/src/features/home/presentation/farm_details_screen.dart';

class FarmsScreen extends StatelessWidget {
  const FarmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Fazendas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AddFarmScreen()),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: firestoreService.farmsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Ocorreu um erro.'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final farms = snapshot.data ?? [];

          return ListView.builder(
            itemCount: farms.length,
            itemBuilder: (context, index) {
              final farm = farms[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  leading: const Icon(Icons.agriculture, size: 40),
                  title: Text(farm['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(farm['location']),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FarmDetailsScreen(farm: farm),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
