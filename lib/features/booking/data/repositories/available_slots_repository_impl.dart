import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/booking/data/datasources/available_slots_remote_data_source.dart';
import 'package:app/features/booking/domain/entities/available_slots_entity.dart';
import 'package:app/features/booking/domain/failures/available_slots_failure.dart';
import 'package:app/features/booking/domain/repositories/available_slots_repository.dart';
import 'package:dio/dio.dart';

class AvailableSlotsRepositoryImpl implements AvailableSlotsRepository {
  final AvailableSlotsRemoteDataSource _remoteDataSource;

  AvailableSlotsRepositoryImpl(this._remoteDataSource);

  @override
  Future<AvailableSlotsEntity> getAvailableSlots({
    required String vendorServiceId,
    required DateTime date,
  }) async {
    try {
      final response = await _remoteDataSource.getAvailableSlots(
        vendorServiceId: vendorServiceId,
        date: date,
      );

      // Convert data layer model to domain entity
      final slots = response.slots
          .map((slot) => TimeSlotEntity(
                time: slot.time,
                isAvailable: slot.isAvailable,
              ))
          .toList();

      return AvailableSlotsEntity(
        vendorServiceId: response.vendorServiceId,
        date: response.date,
        slots: slots,
      );
    } on AvailableSlotsFailure {
      rethrow;
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getAvailableSlots failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleDioError(e);
    } catch (e, stackTrace) {
      AppLogger.error(
        'getAvailableSlots unexpected error',
        error: e,
        stackTrace: stackTrace,
      );
      throw AvailableSlotsFailure.unknown(e.toString());
    }
  }

  AvailableSlotsFailure _handleDioError(DioException e) {
    final errorInfo = DioErrorHandler.handle(e);
    final message = errorInfo.message;

    switch (errorInfo.statusCode) {
      case 401:
        return AvailableSlotsFailure.unauthorized();
      case 404:
        return AvailableSlotsFailure.notFound();
      case 500:
        return AvailableSlotsFailure.serverError();
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout ||
            e.type == DioExceptionType.receiveTimeout) {
          return AvailableSlotsFailure.networkError();
        }
        return AvailableSlotsFailure.unknown(message);
    }
  }
}
