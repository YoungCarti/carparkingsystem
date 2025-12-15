import 'package:flutter/material.dart';
import '../models/parking_models.dart';
import 'add_location_screen.dart';

class ManageParkingScreen extends StatefulWidget {
  const ManageParkingScreen({super.key});

  @override
  State<ManageParkingScreen> createState() => _ManageParkingScreenState();
}

class _ManageParkingScreenState extends State<ManageParkingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Parking Locations'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: dummyLocations.length,
        itemBuilder: (context, index) {
          final location = dummyLocations[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: const Icon(Icons.business, color: Colors.blue),
              title: Text(location.name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('${location.floors} Floors • ${location.slotsPerFloor} Slots/Floor'),
              trailing: const Icon(Icons.edit),
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddLocationScreen(location: location),
                  ),
                );
                setState(() {}); // Refresh list after editing
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddLocationScreen()),
          );
          setState(() {}); // Refresh list after adding
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
