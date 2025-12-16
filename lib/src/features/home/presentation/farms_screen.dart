import 'package:flutter/material.dart';

class Farm {
  const Farm({required this.name, required this.location});
  final String name;
  final String location;
}

final List<Farm> _farms = [
  const Farm(name: 'Fazenda Sol Nascente', location: 'Goiás'),
  const Farm(name: 'Fazenda Bela Vista', location: 'Minas Gerais'),
  const Farm(name: 'Fazenda Agro-Vida', location: 'Mato Grosso'),
  const Farm(name: 'Fazenda Santa Cruz', location: 'São Paulo'),
  const Farm(name: 'Fazenda Novo Horizonte', location: 'Bahia'),
];

class FarmsScreen extends StatelessWidget {
  const FarmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fazendas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Adicionar nova fazenda
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _farms.length,
        itemBuilder: (context, index) {
          final farm = _farms[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const Icon(Icons.agriculture, size: 40),
              title: Text(farm.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(farm.location),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                // Navegar para os detalhes da fazenda
              },
            ),
          );
        },
      ),
    );
  }
}
