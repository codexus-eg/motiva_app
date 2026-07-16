class TimeSlotEntity {
  final String time;
  final bool isAvailable;

  const TimeSlotEntity({required this.time, required this.isAvailable});
}

class AvailableSlotsEntity {
  final String vendorServiceId;
  final DateTime date;
  final List<TimeSlotEntity> slots;

  const AvailableSlotsEntity({
    required this.vendorServiceId,
    required this.date,
    required this.slots,
  });

  /// Get only available time slots as formatted time strings
  List<String> get availableTimes {
    return slots
        .where((slot) => slot.isAvailable)
        .map((slot) => slot.time)
        .toList();
  }
}
