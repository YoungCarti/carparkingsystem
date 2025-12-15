import 'package:flutter/material.dart';
import '../models/parking_models.dart';
import 'availability_screen.dart';
import '../admin/admin_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<ParkingLocation> _filteredLocations = dummyLocations;

  void _filterLocations(String query) {
    setState(() {
      _filteredLocations = dummyLocations
          .where((location) =>
              location.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Parking'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                labelText: 'Search Location',
                hintText: 'Enter mall, building, etc.',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: _filterLocations,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _filteredLocations.length,
                itemBuilder: (context, index) {
                  final location = _filteredLocations[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: const Icon(Icons.local_parking, size: 40, color: Colors.blue),
                      title: Text(location.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text(location.status),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AvailabilityScreen(location: location),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AdminScreen()),
                );
              },
              child: const Text('Admin Access'),
            ),
          ],
        ),
      ),
    );
  }
}
