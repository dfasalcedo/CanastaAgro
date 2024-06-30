import 'package:canasta_agro/register_prodtucts/presentation/register_farm.dart';
import 'package:flutter/material.dart';

import 'list_farms_screen.dart';

class FarmOptionsScreen extends StatelessWidget {
  const FarmOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Opciones de Fincas')),
      body: ListView(
        children: [
          ListTile(
            leading: Image.asset("assets/register_farm.jpeg", width: 25,height: 25,),
            title: Text('Registrar nueva finca'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FarmForm()),
              );
            },
          ),
          ListTile(
            leading: Image.asset("assets/list_farms.jpeg", width: 25, height: 25),
            title: const Text('Mostrar fincas registradas'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FarmsListScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
