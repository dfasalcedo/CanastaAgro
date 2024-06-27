import 'package:flutter/material.dart';

class ProducersScreen extends StatelessWidget {
  const ProducersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Producers')),
      body: const Center(child: Text('Producers Screen')),
    );
  }
}