import 'package:flutter/material.dart';
import 'user.dart'; // Asegúrate de importar tu archivo user.dart

class VehicleListScreen extends StatelessWidget {
  final List<Vehicle> vehicles;
  final Function(String, String) onAddVehicle; // Callback para agregar un vehículo
  final Function(String) onRemoveVehicle; // Callback para eliminar un vehículo

  const VehicleListScreen({
    super.key,
    required this.vehicles,
    required this.onAddVehicle, // Recibe el callback para agregar
    required this.onRemoveVehicle, // Recibe el callback para eliminar
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Vehículos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddVehicleDialog(context);
            },
          ),
        ],
      ),
      body: vehicles.isEmpty
          ? const Center(child: Text('No hay vehículos disponibles.'))
          : ListView.builder(
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                Vehicle vehicle = vehicles[index];
                return Dismissible(
                  key: Key(vehicle.licensePlate),
                  background: Container(
                    color: Colors.red,
                    child: const Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    // Llama al callback para eliminar el vehículo
                    onRemoveVehicle(vehicle.licensePlate);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${vehicle.licensePlate} eliminado')),
                    );
                  },
                  child: ListTile(
                    leading: const Icon(Icons.directions_car),
                    title: Text('Placa: ${vehicle.licensePlate}'),
                    subtitle: Text('Marca: ${vehicle.make}'),
                  ),
                );
              },
            ),
    );
  }

  void _showAddVehicleDialog(BuildContext context) {
    String? newLicensePlate;
    String? newMake;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Vehículo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Placa',
                ),
                onChanged: (value) {
                  newLicensePlate = value.isNotEmpty ? value : null;
                },
              ),
              const SizedBox(height: 16.0),
              TextField(
                decoration: const InputDecoration(
                  hintText: 'Marca',
                ),
                onChanged: (value) {
                  newMake = value.isNotEmpty ? value : null;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (newLicensePlate != null && newMake != null) {
                  onAddVehicle(newLicensePlate!, newMake!); // Usa el callback
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor, completa todos los campos.')),
                  );
                }
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}