import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

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
