import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:dio/dio.dart';

class TimeSlot {
  final String time;
  final bool isAvailable;

  const TimeSlot({required this.time, required this.isAvailable});

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      time: json['time'] as String,
      isAvailable: json['isAvailable'] as bool? ?? true,
    );
  }
}

class AvailableSlotsResponse {
  final String vendorServiceId;
  final DateTime date;
  final List<TimeSlot> slots;

  const AvailableSlotsResponse({
    required this.vendorServiceId,
    required this.date,
    required this.slots,
  });

  factory AvailableSlotsResponse.fromJson(Map<String, dynamic> json) {
    final slotsList = json['slots'] as List<dynamic>? ?? [];
    return AvailableSlotsResponse(
      vendorServiceId: json['vendorServiceId'] as String,
      date: DateTime.parse(json['date'] as String),
      slots: slotsList
          .map((e) => TimeSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

class AvailableSlotsRemoteDataSource {
  final DioClient _dioClient;

  AvailableSlotsRemoteDataSource(this._dioClient);

  Future<AvailableSlotsResponse> getAvailableSlots({
    required String vendorServiceId,
    required DateTime date,
  }) async {
    try {
      final formattedDate = '${date.year.toString().padLeft(4, '0')}-'
          '${date.month.toString().padLeft(2, '0')}-'
          '${date.day.toString().padLeft(2, '0')}';

      AppLogger.debug(
        'Fetching available slots for service: $vendorServiceId on date: $formattedDate',
      );

      final response = await _dioClient.dio.get(
        '/api/vendor-services/$vendorServiceId/available-slots',
        queryParameters: {'date': formattedDate},
      );

      AppLogger.debug('AvailableSlotsResponse: ${response.data}');

      // Handle the response format from the API - it's a direct array of time strings
      final slotsData = response.data as List<dynamic>;
      final slots = slotsData
          .map((time) => TimeSlot(time: time as String, isAvailable: true))
          .toList();

      return AvailableSlotsResponse(
        vendorServiceId: vendorServiceId,
        date: date,
        slots: slots,
      );
    } on DioException {
      // Let the repository handle Dio-specific errors
      rethrow;
    } catch (e) {
      AppLogger.error('Error fetching available slots', error: e);
      // Re-throw so the repository can convert to proper failure
      throw Exception('Failed to fetch available slots: $e');
    }
  }
}
