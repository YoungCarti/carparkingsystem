import 'package:flutter/material.dart';

class ParkingLocation {
  final String id;
  final String name;
  // Distance removed as per requirement
  final String status; // "Available", "Limited", "Full"

  ParkingLocation({
    required this.id,
    required this.name,
    required this.status,
  });
}

class ParkingSlot {
  final String id;
  final String label; // e.g., "A1"
  final SlotStatus status;

  ParkingSlot({
    required this.id,
    required this.label,
    required this.status,
  });
}

enum SlotStatus {
  available,
  occupied,
  reserved,
}

// Dummy Data
final List<ParkingLocation> dummyLocations = [
  ParkingLocation(id: '1', name: 'Menara BAC', status: 'Available'),
];

final List<ParkingSlot> dummySlots = [
  ParkingSlot(id: '1', label: '123', status: SlotStatus.available),
  ParkingSlot(id: '2', label: '124', status: SlotStatus.available),
  ParkingSlot(id: '3', label: '125', status: SlotStatus.available),
  ParkingSlot(id: '4', label: '126', status: SlotStatus.available),
];
