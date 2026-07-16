import 'package:app/core/network/dio_client.dart';
import 'package:app/features/vendor_orders/domain/entities/vendor_order.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';

class CalendarDayData {
  final DateTime date;
  final int totalOrders;
  final int pendingOrders;
  final int acceptedOrders;

  CalendarDayData({
    required this.date,
    required this.totalOrders,
    required this.pendingOrders,
    required this.acceptedOrders,
  });

  factory CalendarDayData.fromJson(String dateKey, Map<String, dynamic> json) {
    return CalendarDayData(
      date: DateTime.parse(dateKey),
      totalOrders: json['total'] as int? ?? 0,
      pendingOrders: json['pending'] as int? ?? 0,
      acceptedOrders: json['accepted'] as int? ?? 0,
    );
  }
}

class CalendarData {
  final int year;
  final int month;
  final Map<String, CalendarDayData> days;

  CalendarData({required this.year, required this.month, required this.days});

  factory CalendarData.fromJson(Map<String, dynamic> json) {
    final daysData = json['days'] as Map<String, dynamic>? ?? {};
    final days = <String, CalendarDayData>{};

    daysData.forEach((key, value) {
      days[key] = CalendarDayData.fromJson(key, value as Map<String, dynamic>);
    });

    return CalendarData(
      year: json['year'] as int,
      month: json['month'] as int,
      days: days,
    );
  }
}

class VendorScheduleRemoteDataSource {
  final DioClient _dioClient;

  VendorScheduleRemoteDataSource(this._dioClient);

  Future<CalendarData> getCalendarData(int year, int month) async {
    final response = await _dioClient.dio.get(
      '/api/service-orders/vendor/calendar',
      queryParameters: {'year': year, 'month': month},
    );
    return CalendarData.fromJson(response.data);
  }

  Future<List<VendorOrder>> getScheduledOrders({
    DateTime? startDate,
    DateTime? endDate,
    String? status,
    int page = 1,
    int limit = 20,
  }) async {
    final queryParams = <String, dynamic>{'page': page, 'limit': limit};

    if (startDate != null) {
      queryParams['startDate'] = startDate.toIso8601String();
    }
    if (endDate != null) {
      queryParams['endDate'] = endDate.toIso8601String();
    }
    if (status != null) {
      queryParams['status'] = status;
    }

    final response = await _dioClient.dio.get(
      '/api/service-orders/vendor/scheduled',
      queryParameters: queryParams,
    );

    final orders = response.data['orders'] as List? ?? [];
    return orders
        .map((json) => VendorOrder.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

final vendorScheduleRemoteDataSourceProvider =
    Provider<VendorScheduleRemoteDataSource>((ref) {
      final dioClient = ref.watch(dioClientProvider);
      return VendorScheduleRemoteDataSource(dioClient);
    });
