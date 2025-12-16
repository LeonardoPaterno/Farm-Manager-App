import 'package:flutter/material.dart';
import 'package:myapp/src/features/home/application/firestore_service.dart';

class FarmDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> farm;

  const FarmDetailsScreen({super.key, required this.farm});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return Scaffold(
      appBar: AppBar(title: Text(farm['name'])),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Talhões',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: firestoreService.fieldsStream(farm['id']),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(child: Text('Ocorreu um erro.'));
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                final fields = snapshot.data ?? [];

                return ListView.builder(
                  itemCount: fields.length,
                  itemBuilder: (context, index) {
                    final field = fields[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(field['name']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
