import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class CreateOrderRequest {
  final String vendorServiceId;
  final Map<String, dynamic> orderCustomerAttributes;
  final String? locationAddress;
  final double? locationLat;
  final double? locationLng;
  final String? pickupAddress;
  final double? pickupLat;
  final double? pickupLng;
  final String? dropoffAddress;
  final double? dropoffLat;
  final double? dropoffLng;
  final DateTime? scheduledAt;

  const CreateOrderRequest({
    required this.vendorServiceId,
    required this.orderCustomerAttributes,
    this.locationAddress,
    this.locationLat,
    this.locationLng,
    this.pickupAddress,
    this.pickupLat,
    this.pickupLng,
    this.dropoffAddress,
    this.dropoffLat,
    this.dropoffLng,
    this.scheduledAt,
  });

  static const Set<String> _metadataFields = {
    'duration_minutes',
    'duration',
    'estimated_time',
    'created_at',
    'updated_at',
    'id',
    'service_id',
    'vendor_id',
  };

  /// Formats a UTC DateTime into 'YYYY-MM-DDTHH:mm:ssZ' (ISO 8601 UTC).
  /// scheduledAt is already in UTC (constructed via DateTime.utc).
  static String _formatUtcDateTime(DateTime dt) {
    final y = dt.year.toString().padLeft(4, '0');
    final m = dt.month.toString().padLeft(2, '0');
    final d = dt.day.toString().padLeft(2, '0');
    final h = dt.hour.toString().padLeft(2, '0');
    final min = dt.minute.toString().padLeft(2, '0');
    final s = dt.second.toString().padLeft(2, '0');
    return '$y-$m-${d}T$h:$min:${s}Z';
  }

  Map<String, dynamic> toJson() {
    final filteredAttributes = <String, dynamic>{};
    for (final entry in orderCustomerAttributes.entries) {
      if (!_metadataFields.contains(entry.key.toLowerCase())) {
        filteredAttributes[entry.key] = entry.value;
      }
    }

    final json = <String, dynamic>{
      'vendorServiceId': vendorServiceId,
      'orderCustomerAttributes': filteredAttributes,
    };

    if (locationAddress != null && locationAddress!.isNotEmpty) {
      json['locationAddress'] = locationAddress;
    }
    if (locationLat != null) {
      json['locationLat'] = locationLat;
    }
    if (locationLng != null) {
      json['locationLng'] = locationLng;
    }
    if (pickupAddress != null && pickupAddress!.isNotEmpty) {
      json['pickupAddress'] = pickupAddress;
    }
    if (pickupLat != null) {
      json['pickupLat'] = pickupLat;
    }
    if (pickupLng != null) {
      json['pickupLng'] = pickupLng;
    }
    if (dropoffAddress != null && dropoffAddress!.isNotEmpty) {
      json['dropoffAddress'] = dropoffAddress;
    }
    if (dropoffLat != null) {
      json['dropoffLat'] = dropoffLat;
    }
    if (dropoffLng != null) {
      json['dropoffLng'] = dropoffLng;
    }
    if (scheduledAt != null) {
      json['scheduledAt'] = _formatUtcDateTime(scheduledAt!);
    }

    return json;
  }

  FormData toFormData(Map<String, XFile> files) {
    final formData = FormData();

    formData.fields.add(MapEntry('vendorServiceId', vendorServiceId));

    final textAttributes = <String, dynamic>{};
    for (final entry in orderCustomerAttributes.entries) {
      if (!_metadataFields.contains(entry.key.toLowerCase())) {
        if (!files.containsKey(entry.key)) {
          textAttributes[entry.key] = entry.value;
        }
      }
    }
    if (textAttributes.isNotEmpty) {
      formData.fields.add(
        MapEntry('orderCustomerAttributes', jsonEncode(textAttributes)),
      );
    } else {
      formData.fields.add(MapEntry('orderCustomerAttributes', '{}'));
    }

    if (locationAddress != null && locationAddress!.isNotEmpty) {
      formData.fields.add(MapEntry('locationAddress', locationAddress!));
    }
    if (locationLat != null) {
      formData.fields.add(MapEntry('locationLat', locationLat.toString()));
    }
    if (locationLng != null) {
      formData.fields.add(MapEntry('locationLng', locationLng.toString()));
    }
    if (pickupAddress != null && pickupAddress!.isNotEmpty) {
      formData.fields.add(MapEntry('pickupAddress', pickupAddress!));
    }
    if (pickupLat != null) {
      formData.fields.add(MapEntry('pickupLat', pickupLat.toString()));
    }
    if (pickupLng != null) {
      formData.fields.add(MapEntry('pickupLng', pickupLng.toString()));
    }
    if (dropoffAddress != null && dropoffAddress!.isNotEmpty) {
      formData.fields.add(MapEntry('dropoffAddress', dropoffAddress!));
    }
    if (dropoffLat != null) {
      formData.fields.add(MapEntry('dropoffLat', dropoffLat.toString()));
    }
    if (dropoffLng != null) {
      formData.fields.add(MapEntry('dropoffLng', dropoffLng.toString()));
    }
    if (scheduledAt != null) {
      formData.fields.add(
        MapEntry('scheduledAt', _formatUtcDateTime(scheduledAt!)),
      );
    }

    for (final entry in files.entries) {
      formData.files.add(
        MapEntry(
          'customer_file_${entry.key}',
          MultipartFile.fromFileSync(
            entry.value.path,
            filename: entry.value.name,
          ),
        ),
      );
    }

    return formData;
  }
}