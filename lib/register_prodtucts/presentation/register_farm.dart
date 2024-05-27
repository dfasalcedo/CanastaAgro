import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FarmForm extends StatefulWidget {
  @override
  _FarmFormState createState() => _FarmFormState();
}

class _FarmFormState extends State<FarmForm> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos de texto
  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _sizeController = TextEditingController();
  final _typeCultivoController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    // Limpia los controladores cuando el Widget se deshaga
    _nameController.dispose();
    _locationController.dispose();
    _sizeController.dispose();
    _typeCultivoController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro de Finca'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Nombre de la Finca'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el nombre de la finca';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _locationController,
                decoration: InputDecoration(labelText: 'Ubicación'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa la ubicación';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _sizeController,
                decoration: InputDecoration(labelText: 'Tamaño (hectáreas)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el tamaño de la finca';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _typeCultivoController,
                decoration: InputDecoration(labelText: 'Tipo de Cultivo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa el tipo de cultivo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Descripción'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa una descripción';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() == true) {
                    // Aquí puedes manejar el envío de los datos
                    // por ejemplo, enviar los datos a un servidor o guardarlos localmente
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Finca registrada con éxito')),
                    );
                  }
                },
                child: Text('Registrar Finca'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}