import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'farm_detail_screen.dart'; // Crear esta pantalla

class FarmsListScreen extends StatelessWidget {
  const FarmsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Fincas'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('farms').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Ocurrió un error al cargar las fincas.'));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No hay fincas disponibles.'));
          }

          var farms = snapshot.data!.docs;

          return ListView.builder(
            itemCount: farms.length,
            itemBuilder: (context, index) {
              var farm = farms[index];
              return ListTile(
                title: Text(farm['name']),
                subtitle: Text('Ubicación: ${farm['location']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FarmDetailScreen(
                        description: farm['description'],
                      ),
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
