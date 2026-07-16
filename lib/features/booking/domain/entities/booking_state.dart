import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:flutter/material.dart';

class BookingState {
  final String vendorServiceId;
  final String vendorId;
  final String categoryId;
  final String serviceName;
  final String? serviceDescription;
  final String basePrice;
  final String vendorName;
  final String? vendorLogoUrl;

  final double? locationLat;
  final double? locationLng;
  final String? locationAddress;

  final double? pickupLat;
  final double? pickupLng;
  final String? pickupAddress;

  final double? dropOffLat;
  final double? dropOffLng;
  final String? dropOffAddress;

  final DateTime? scheduledAt;
  final DateTime? lastSelectedDate;
  final TimeOfDay? lastSelectedTime;

  final Map<String, dynamic> orderCustomerAttributes;
  final Map<String, dynamic> categoryServiceAttributes;
  final List<AttributeField> requiredCustomerFields;

  final bool requiresGps;
  final bool allowsScheduling;
  final bool requiresRoute;

  final bool isSubmitting;
  final String? errorMessage;

  const BookingState({
    required this.vendorServiceId,
    required this.vendorId,
    required this.categoryId,
    required this.serviceName,
    this.serviceDescription,
    required this.basePrice,
    required this.vendorName,
    this.vendorLogoUrl,
    this.locationLat,
    this.locationLng,
    this.locationAddress,
    this.pickupLat,
    this.pickupLng,
    this.pickupAddress,
    this.dropOffLat,
    this.dropOffLng,
    this.dropOffAddress,
    this.scheduledAt,
    this.lastSelectedDate,
    this.lastSelectedTime,
    this.orderCustomerAttributes = const {},
    this.categoryServiceAttributes = const {},
    this.requiredCustomerFields = const [],
    this.requiresGps = false,
    this.allowsScheduling = false,
    this.requiresRoute = false,
    this.isSubmitting = false,
    this.errorMessage,
  });

  bool get hasValidLocation {
    if (!requiresGps) return true;
    return locationLat != null && locationLng != null;
  }

  bool get hasValidRoute {
    if (!requiresRoute) return true;
    return pickupLat != null &&
        pickupLng != null &&
        dropOffLat != null &&
        dropOffLng != null;
  }

  bool get canSubmit {
    if (isSubmitting) return false;
    if (!hasValidLocation) return false;
    if (!hasValidRoute) return false;
    return true;
  }

  String? get validationError {
    if (requiresGps && (locationLat == null || locationLng == null)) {
      return 'Please select your location to continue';
    }
    if (requiresRoute) {
      if (pickupLat == null || pickupLng == null) {
        return 'Please select pickup location';
      }
      if (dropOffLat == null || dropOffLng == null) {
        return 'Please select drop off location';
      }
    }
    return null;
  }

  BookingState copyWith({
    String? vendorServiceId,
    String? vendorId,
    String? categoryId,
    String? serviceName,
    String? serviceDescription,
    String? basePrice,
    String? vendorName,
    String? vendorLogoUrl,
    double? locationLat,
    double? locationLng,
    String? locationAddress,
    double? pickupLat,
    double? pickupLng,
    String? pickupAddress,
    double? dropoffLat,
    double? dropoffLng,
    String? dropoffAddress,
    DateTime? scheduledAt,
    DateTime? lastSelectedDate,
    TimeOfDay? lastSelectedTime,
    Map<String, dynamic>? orderCustomerAttributes,
    Map<String, dynamic>? categoryServiceAttributes,
    List<AttributeField>? requiredCustomerFields,
    bool? requiresGps,
    bool? allowsScheduling,
    bool? requiresRoute,
    bool? isSubmitting,
    String? errorMessage,
    bool clearError = false,
    bool clearLocation = false,
    bool clearScheduledAt = false,
    bool clearRoute = false,
  }) {
    return BookingState(
      vendorServiceId: vendorServiceId ?? this.vendorServiceId,
      vendorId: vendorId ?? this.vendorId,
      categoryId: categoryId ?? this.categoryId,
      serviceName: serviceName ?? this.serviceName,
      serviceDescription: serviceDescription ?? this.serviceDescription,
      basePrice: basePrice ?? this.basePrice,
      vendorName: vendorName ?? this.vendorName,
      vendorLogoUrl: vendorLogoUrl ?? this.vendorLogoUrl,
      locationLat: clearLocation ? null : (locationLat ?? this.locationLat),
      locationLng: clearLocation ? null : (locationLng ?? this.locationLng),
      locationAddress: clearLocation
          ? null
          : (locationAddress ?? this.locationAddress),
      pickupLat: clearRoute ? null : (pickupLat ?? this.pickupLat),
      pickupLng: clearRoute ? null : (pickupLng ?? this.pickupLng),
      pickupAddress: clearRoute ? null : (pickupAddress ?? this.pickupAddress),
      dropOffLat: clearRoute ? null : (dropoffLat ?? dropOffLat),
      dropOffLng: clearRoute ? null : (dropoffLng ?? dropOffLng),
      dropOffAddress: clearRoute ? null : (dropoffAddress ?? dropOffAddress),
      scheduledAt: clearScheduledAt ? null : (scheduledAt ?? this.scheduledAt),
      lastSelectedDate: lastSelectedDate ?? this.lastSelectedDate,
      lastSelectedTime: lastSelectedTime ?? this.lastSelectedTime,
      orderCustomerAttributes:
          orderCustomerAttributes ?? this.orderCustomerAttributes,
      categoryServiceAttributes:
          categoryServiceAttributes ?? this.categoryServiceAttributes,
      requiredCustomerFields:
          requiredCustomerFields ?? this.requiredCustomerFields,
      requiresGps: requiresGps ?? this.requiresGps,
      allowsScheduling: allowsScheduling ?? this.allowsScheduling,
      requiresRoute: requiresRoute ?? this.requiresRoute,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
