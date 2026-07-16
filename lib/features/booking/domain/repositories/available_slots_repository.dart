import '../entities/available_slots_entity.dart';

abstract class AvailableSlotsRepository {
  Future<AvailableSlotsEntity> getAvailableSlots({
    required String vendorServiceId,
    required DateTime date,
  });
}
