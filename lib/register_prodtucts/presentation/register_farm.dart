import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FarmForm extends StatefulWidget {
  const FarmForm({Key? key}) : super(key: key);

  @override
  createState() => _FarmFormState();
}

class _FarmFormState extends State<FarmForm> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de texto
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _sizeController = TextEditingController();
  final _typeCropController = TextEditingController();
  final _descriptionController = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void dispose() {
    // Limpia los controladores cuando el Widget se deshaga
    _nameController.dispose();
    _locationController.dispose();
    _sizeController.dispose();
    _typeCropController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> addFarm({
    required String name,
    required String location,
    required String size,
    required String typeCrop,
    required String description,
  }) async {
    try {
      await db.collection("farms").add({
        'name': name,
        'location': location,
        'size': size,
        'typeCrop': typeCrop,
        'description': description,
      });
      print('Finca registrada con éxito en Firestore');
    } catch (e) {
      print('Error al registrar la finca: $e');
      // Aquí puedes manejar cualquier error que ocurra al enviar los datos a Firestore
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Finca'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Nombre de la Finca',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre de la finca';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(
                  labelText: 'Ubicación',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la ubicación';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _sizeController,
                decoration: InputDecoration(
                  labelText: 'Tamaño (hectáreas)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el tamaño de la finca';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _typeCropController,
                decoration: InputDecoration(
                  labelText: 'Tipo de Cultivo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el tipo de cultivo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa una descripción';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState?.validate() == true) {
                    // Captura los datos del formulario
                    String name = _nameController.text.trim();
                    String location = _locationController.text.trim();
                    String size = _sizeController.text.trim();
                    String typeCrop = _typeCropController.text.trim();
                    String description = _descriptionController.text.trim();

                    // Llama a la función para añadir la finca a Firestore
                    await addFarm(
                      name: name,
                      location: location,
                      size: size,
                      typeCrop: typeCrop,
                      description: description,
                    );

                    // Muestra un mensaje al usuario
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Finca registrada con éxito')),
                    );

                    // Limpia los campos del formulario después de registrar
                    _nameController.clear();
                    _locationController.clear();
                    _sizeController.clear();
                    _typeCropController.clear();
                    _descriptionController.clear();
                  }
                },
                child: const Text('Registrar Finca'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}