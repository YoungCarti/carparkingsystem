import 'package:flutter/material.dart';
import '../models/parking_models.dart';
import 'search_screen.dart';

class DetailsScreen extends StatelessWidget {
  final ParkingLocation location;
  final ParkingSlot slot;

  const DetailsScreen({
    super.key,
    required this.location,
    required this.slot,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking Details'),
        automaticallyImplyLeading: false, // Hide back button to prevent going back to reservation
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 16),
            const Text(
              'Active Session',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const SizedBox(height: 32),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildDetailRow('Location', location.name),
                    const Divider(),
                    _buildDetailRow('Floor', 'Level 1'),
                    const Divider(),
                    _buildDetailRow('Slot Number', slot.label),
                    const Divider(),
                    _buildDetailRow('Status', 'Reserved'),
                    const Divider(),
                    _buildDetailRow('Duration', '00:15:30'), // Static timer
                  ],
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // End parking logic (visual only)
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                  (route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('End Parking', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 16)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }
}
