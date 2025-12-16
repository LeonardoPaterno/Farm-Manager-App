import 'package:flutter/material.dart';

class FarmsScreen extends StatelessWidget {
  const FarmsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Farms')),
      body: const Center(child: Text('Farms Content')),
    );
  }
}
