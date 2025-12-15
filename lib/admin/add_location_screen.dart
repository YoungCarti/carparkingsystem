import 'package:flutter/material.dart';
import '../models/parking_models.dart';

class AddLocationScreen extends StatefulWidget {
  final ParkingLocation? location;

  const AddLocationScreen({super.key, this.location});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final _nameController = TextEditingController();
  final _floorsController = TextEditingController();
  final _slotsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.location != null) {
      _nameController.text = widget.location!.name;
      _floorsController.text = widget.location!.floors.toString();
      _slotsController.text = widget.location!.slotsPerFloor.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.location == null ? 'Add Parking Location' : 'Edit Parking Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Location Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _floorsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Number of Floors',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _slotsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Slots per Floor',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveLocation,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(widget.location == null ? 'Save Location' : 'Update Location'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _saveLocation() {
    final name = _nameController.text;
    final floors = int.tryParse(_floorsController.text) ?? 1;
    final slots = int.tryParse(_slotsController.text) ?? 10;

    if (name.isNotEmpty) {
      if (widget.location == null) {
        // Add new
        final newLocation = ParkingLocation(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          name: name,
          status: 'Available',
          floors: floors,
          slotsPerFloor: slots,
        );
        dummyLocations.add(newLocation);
      } else {
        // Edit existing
        final index = dummyLocations.indexWhere((l) => l.id == widget.location!.id);
        if (index != -1) {
          dummyLocations[index] = ParkingLocation(
            id: widget.location!.id,
            name: name,
            status: widget.location!.status, // Keep existing status
            floors: floors,
            slotsPerFloor: slots,
          );
        }
      }
      Navigator.pop(context);
    }
  }
}
