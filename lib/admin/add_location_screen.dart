import 'package:flutter/material.dart';
import '../models/parking_models.dart';

class AddLocationScreen extends StatefulWidget {
  final ParkingLocation? location;

  const AddLocationScreen({super.key, this.location});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _floorsController = TextEditingController();
  final _slotsController = TextEditingController();

  bool get isEdit => widget.location != null;

  @override
  void initState() {
    super.initState();
    _initializeFields();
  }

  void _initializeFields() {
    final location = widget.location;
    if (location == null) return;

    _nameController.text = location.name;
    _floorsController.text = location.floors.toString();
    _slotsController.text = location.slotsPerFloor.toString();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _floorsController.dispose();
    _slotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Parking Location' : 'Add Parking Location'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                controller: _nameController,
                label: 'Location Name',
                validator: (value) =>
                    value == null || value.isEmpty ? 'Name is required' : null,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _floorsController,
                label: 'Number of Floors',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: _slotsController,
                label: 'Slots per Floor',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _saveLocation,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(isEdit ? 'Update Location' : 'Save Location'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
    );
  }

  void _saveLocation() {
    if (!_formKey.currentState!.validate()) return;

    final floors = int.tryParse(_floorsController.text) ?? 1;
    final slots = int.tryParse(_slotsController.text) ?? 10;

    if (isEdit) {
      _updateLocation(floors, slots);
    } else {
      _addLocation(floors, slots);
    }

    Navigator.pop(context);
  }

  void _addLocation(int floors, int slots) {
    dummyLocations.add(
      ParkingLocation(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        status: 'Available',
        floors: floors,
        slotsPerFloor: slots,
      ),
    );
  }

  void _updateLocation(int floors, int slots) {
    final index =
        dummyLocations.indexWhere((l) => l.id == widget.location!.id);

    if (index == -1) return;

    dummyLocations[index] = ParkingLocation(
      id: widget.location!.id,
      name: _nameController.text,
      status: widget.location!.status,
      floors: floors,
      slotsPerFloor: slots,
    );
  }
}
