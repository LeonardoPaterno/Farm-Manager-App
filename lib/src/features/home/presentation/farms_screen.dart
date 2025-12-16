import 'package:flutter/material.dart';

class FarmsScreen extends StatelessWidget {
  const FarmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Farms')),
      body: const Center(child: Text('Farms List')),
      floatingActionButton: FloatingActionButton(
        onPressed: () { /* TODO: Add new farm logic */ },
        child: const Icon(Icons.add),
      ),
    );
  }
}
