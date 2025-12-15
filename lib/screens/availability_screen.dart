import 'package:flutter/material.dart';
import '../models/parking_models.dart';
import 'reservation_screen.dart';

class AvailabilityScreen extends StatefulWidget {
  final ParkingLocation location;

  const AvailabilityScreen({super.key, required this.location});

  @override
  State<AvailabilityScreen> createState() => _AvailabilityScreenState();
}

class _AvailabilityScreenState extends State<AvailabilityScreen> {
  String _selectedZone = 'Zone A';
  ParkingSlot? _selectedSlot;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.location.name,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const Text(
              'Courtyard Marina View Tower', // Dummy subtitle
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildZoneSelector(),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(24),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 40,
                mainAxisSpacing: 24,
                childAspectRatio: 2.5, // Wider slots
              ),
              itemCount: dummySlots.length,
              itemBuilder: (context, index) {
                final slot = dummySlots[index];
                return _buildSlotItem(slot);
              },
            ),
          ),
          _buildBottomBar(),
        ],
      ),
    );
  }

  Widget _buildZoneSelector() {
    final zones = ['Zone A'];
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: zones.map((zone) {
          final isSelected = zone == _selectedZone;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _selectedZone = zone;
                });
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? Colors.black87 : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  zone,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSlotItem(ParkingSlot slot) {
    if (slot.status == SlotStatus.occupied) {
      return Container(
        decoration: BoxDecoration(
           // No border for cars
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
             // Car Body
             Container(
               height: 50,
               width: 120,
               decoration: BoxDecoration(
                 color: Colors.red, // Red Car
                 borderRadius: BorderRadius.circular(12),
                 boxShadow: [
                   BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, offset: const Offset(0, 2)),
                 ],
               ),
             ),
             // Windows (Simple representation)
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Container(width: 20, height: 40, color: Colors.black87),
                 const SizedBox(width: 10),
                 Container(width: 30, height: 40, color: Colors.black87),
               ],
             ),
          ],
        ),
      );
    }

    final isSelected = _selectedSlot == slot;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedSlot = slot;
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFF0F4C3) : Colors.white, // Light yellow selection
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? const Color(0xFFB2FF59) : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              slot.label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Available',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: _selectedSlot != null
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReservationScreen(
                      location: widget.location,
                      slot: _selectedSlot!,
                    ),
                  ),
                );
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF212121), // Dark button
          foregroundColor: const Color(0xFFB2FF59), // Green text/icon
          padding: const EdgeInsets.symmetric(vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          disabledBackgroundColor: Colors.grey.shade300,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Continue',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 12),
            Icon(Icons.arrow_forward),
          ],
        ),
      ),
    );
  }
}
