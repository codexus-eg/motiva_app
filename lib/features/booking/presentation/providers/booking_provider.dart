import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../domain/entities/booking_state.dart';
import '../../data/models/create_order_request.dart';
import '../../../customer_orders/data/models/customer_order_model.dart';
import '../../../auth/presentation/providers/auth_providers.dart';
import '../../../service-categories/domain/entities/service_category.dart';
import '../../../../core/network/dio_error_handler.dart';
import '../../../../core/utils/app_logger.dart';

/// Result wrapper for booking submission with retry capability
class BookingResult {
  final bool success;
  final String? error;
  final bool canRetry;
  final CustomerOrderModel? order;

  const BookingResult({
    required this.success,
    this.error,
    this.canRetry = false,
    this.order,
  });
}

final bookingStateProvider =
    StateNotifierProvider<BookingNotifier, BookingState>((ref) {
      return BookingNotifier();
    });

class BookingNotifier extends StateNotifier<BookingState> {
  BookingNotifier()
    : super(
        const BookingState(
          vendorServiceId: '',
          vendorId: '',
          categoryId: '',
          serviceName: '',
          basePrice: '',
          vendorName: '',
        ),
      );

  void initialize({
    required String vendorServiceId,
    required String vendorId,
    required String categoryId,
    required String serviceName,
    String? serviceDescription,
    required String basePrice,
    required String vendorName,
    String? vendorLogoUrl,
    bool requiresGps = false,
    bool allowsScheduling = false,
    bool requiresRoute = false,
    Map<String, dynamic> categoryServiceAttributes = const {},
    List<AttributeField> requiredCustomerFields = const [],
  }) {
    state = BookingState(
      vendorServiceId: vendorServiceId,
      vendorId: vendorId,
      categoryId: categoryId,
      serviceName: serviceName,
      serviceDescription: serviceDescription,
      basePrice: basePrice,
      vendorName: vendorName,
      vendorLogoUrl: vendorLogoUrl,
      requiresGps: requiresGps,
      allowsScheduling: allowsScheduling,
      requiresRoute: requiresRoute,
      categoryServiceAttributes: categoryServiceAttributes,
      requiredCustomerFields: requiredCustomerFields,
    );
  }

  void setLocation(double lat, double lng, String? address) {
    state = state.copyWith(
      locationLat: lat,
      locationLng: lng,
      locationAddress: address,
    );
  }

  void clearLocation() {
    state = state.copyWith(clearLocation: true);
  }

  void setPickupLocation(double lat, double lng, String? address) {
    state = state.copyWith(
      pickupLat: lat,
      pickupLng: lng,
      pickupAddress: address,
    );
  }

  void setDropoffLocation(double lat, double lng, String? address) {
    state = state.copyWith(
      dropoffLat: lat,
      dropoffLng: lng,
      dropoffAddress: address,
    );
  }

  void clearRoute() {
    state = state.copyWith(clearRoute: true);
  }

  void setScheduledAt(DateTime dateTime) {
    state = state.copyWith(scheduledAt: dateTime);
  }

  void clearScheduledAt() {
    state = state.copyWith(clearScheduledAt: true);
  }

  void setLastSelectedDate(DateTime date) {
    state = state.copyWith(lastSelectedDate: date);
  }

  void setLastSelectedTime(TimeOfDay time) {
    state = state.copyWith(lastSelectedTime: time);
  }

  void setOrderCustomerAttributes(Map<String, dynamic> attributes) {
    state = state.copyWith(orderCustomerAttributes: attributes);
  }

  void clearError() {
    state = state.copyWith(clearError: true);
  }
}

final bookingSubmissionProvider =
    AsyncNotifierProvider<BookingSubmissionNotifier, CustomerOrderModel?>(() {
      return BookingSubmissionNotifier();
    });

class BookingSubmissionNotifier extends AsyncNotifier<CustomerOrderModel?> {
  @override
  CustomerOrderModel? build() {
    return null;
  }

  Future<BookingResult> submitOrderWithRetry(
    BookingState bookingState,
    Map<String, XFile> files, {
    int maxRetries = 3,
    Duration initialDelay = const Duration(seconds: 1),
  }) async {
    if (!bookingState.canSubmit) {
      return const BookingResult(
        success: false,
        error: 'Booking validation failed',
        canRetry: false,
      );
    }

    final validationError = bookingState.validationError;
    if (validationError != null) {
      state = AsyncValue.error(validationError, StackTrace.current);
      return BookingResult(
        success: false,
        error: validationError,
        canRetry: false,
      );
    }

    // Check connectivity first
    final connectivityResults = await Connectivity().checkConnectivity();
    final hasConnectivity = !connectivityResults.contains(ConnectivityResult.none);

    if (!hasConnectivity) {
      return const BookingResult(
        success: false,
        error: 'No internet connection. Please check your connection and try again.',
        canRetry: true,
      );
    }

    state = const AsyncValue.loading();

    int attemptCount = 0;
    Duration currentDelay = initialDelay;

    while (attemptCount < maxRetries) {
      try {
        final dioClient = ref.read(dioClientProvider);
        final request = CreateOrderRequest(
          vendorServiceId: bookingState.vendorServiceId,
          orderCustomerAttributes: bookingState.orderCustomerAttributes,
          locationLat: bookingState.locationLat,
          locationLng: bookingState.locationLng,
          locationAddress: bookingState.locationAddress,
          pickupLat: bookingState.pickupLat,
          pickupLng: bookingState.pickupLng,
          pickupAddress: bookingState.pickupAddress,
          dropoffLat: bookingState.dropOffLat,
          dropoffLng: bookingState.dropOffLng,
          dropoffAddress: bookingState.dropOffAddress,
          scheduledAt: bookingState.scheduledAt,
        );

        final response = files.isNotEmpty
            ? await dioClient.dio.post(
                '/api/service-orders',
                data: request.toFormData(files),
              )
            : await dioClient.dio.post(
                '/api/service-orders',
                data: request.toJson(),
              );

        final order = CustomerOrderModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        state = AsyncValue.data(order);
        return BookingResult(success: true, order: order);
      } on DioException catch (e, stackTrace) {
        attemptCount++;
        final errorInfo = DioErrorHandler.handle(e);
        AppLogger.error('Submit order attempt $attemptCount failed', error: e, stackTrace: stackTrace);

        // Check if we have connectivity before retry
        if (attemptCount < maxRetries) {
          final connectivity = await Connectivity().checkConnectivity();
          if (connectivity.contains(ConnectivityResult.none)) {
            // We're offline, queue for background sync
            return BookingResult(
              success: false,
              error: 'Connection lost. Your booking has been saved and will be submitted when you\'re back online.',
              canRetry: true,
            );
          }

          // Exponential backoff
          currentDelay = currentDelay * 2;
          await Future.delayed(currentDelay);
        } else {
          // All retries exhausted
          state = AsyncValue.error(Exception(errorInfo.message), stackTrace);
          return BookingResult(
            success: false,
            error: errorInfo.message,
            canRetry: false,
          );
        }
      } on Exception catch (e, stackTrace) {
        AppLogger.error('Submit order failed', error: e, stackTrace: stackTrace);
        state = AsyncValue.error(e, stackTrace);
        return BookingResult(
          success: false,
          error: e.toString(),
          canRetry: false,
        );
      }
    }

    return const BookingResult(
      success: false,
      error: 'Failed to submit booking after multiple attempts',
      canRetry: false,
    );
  }

  Future<CustomerOrderModel?> submitOrder(
    BookingState bookingState,
    Map<String, XFile> files,
  ) async {
    final result = await submitOrderWithRetry(bookingState, files, maxRetries: 3);
    return result.order;
  }

  void reset() {
    state = const AsyncValue.data(null);
  }
}
