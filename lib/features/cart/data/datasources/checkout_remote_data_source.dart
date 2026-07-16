import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/cart/data/models/checkout_result_model.dart';
import 'package:app/features/cart/data/models/delivery_address_model.dart';
import 'package:app/features/cart/domain/failures/checkout_failure.dart';
import 'package:dio/dio.dart';

abstract class CheckoutRemoteDataSource {
  Future<CheckoutResultModel> checkout({DeliveryAddressModel? address});
}

class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSource {
  final DioClient _dioClient;

  CheckoutRemoteDataSourceImpl(this._dioClient);

  @override
  Future<CheckoutResultModel> checkout({DeliveryAddressModel? address}) async {
    try {
      final data = <String, dynamic>{};
      if (address != null) {
        data['deliveryAddress'] = {
          'street': address.street,
          'area': address.area,
          'block': address.block,
          if (address.building != null) 'building': address.building,
          if (address.floor != null) 'floor': address.floor,
          if (address.apartment != null) 'apartment': address.apartment,
          if (address.notes != null) 'notes': address.notes,
        };
      }

      final response = await _dioClient.dio.post(
        '/api/checkout',
        data: data.isNotEmpty ? data : null,
      );

      return CheckoutResultModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('checkout failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    }
  }

  CheckoutFailure _handleError(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = DioErrorHandler.handle(e).message;

    switch (statusCode) {
      case 401:
        return CheckoutFailure.unauthorized();
      case 403:
        return CheckoutFailure.forbidden();
      case 400:
        return CheckoutFailure.validation(message);
      case 500:
        return CheckoutFailure.serverError();
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          return CheckoutFailure.networkError();
        }
        return CheckoutFailure.unknown(message);
    }
  }
}
