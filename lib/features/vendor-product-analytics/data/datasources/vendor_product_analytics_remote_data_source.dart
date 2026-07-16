import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:dio/dio.dart';

import '../../domain/failures/vendor_product_analytics_failure.dart';
import '../models/vendor_product_analytics_model.dart';

abstract class VendorProductAnalyticsRemoteDataSource {
  Future<VendorProductAnalyticsModel> getAnalytics({
    String? productId,
    String? fromDate,
    String? toDate,
  });
}

class VendorProductAnalyticsRemoteDataSourceImpl
    implements VendorProductAnalyticsRemoteDataSource {
  final DioClient _dioClient;

  VendorProductAnalyticsRemoteDataSourceImpl(this._dioClient);

  @override
  Future<VendorProductAnalyticsModel> getAnalytics({
    String? productId,
    String? fromDate,
    String? toDate,
  }) async {
    try {
      final queryParameters = <String, dynamic>{};
      if (productId != null && productId.isNotEmpty) {
        queryParameters['productId'] = productId;
      }
      if (fromDate != null && fromDate.isNotEmpty) {
        queryParameters['fromDate'] = fromDate;
      }
      if (toDate != null && toDate.isNotEmpty) {
        queryParameters['toDate'] = toDate;
      }

      final response = await _dioClient.dio.get(
        '/api/products/analytics',
        queryParameters: queryParameters,
      );

      final data = response.data;
      Map<String, dynamic> analyticsJson;
      if (data is Map<String, dynamic> && data.containsKey('data')) {
        analyticsJson = data['data'] as Map<String, dynamic>;
      } else if (data is Map<String, dynamic>) {
        analyticsJson = data;
      } else {
        analyticsJson = {};
      }

      return VendorProductAnalyticsModel.fromJson(analyticsJson);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getAnalytics failed', error: e, stackTrace: stackTrace);
      throw _handleError(e);
    } catch (e, stackTrace) {
      AppLogger.error(
        'getAnalytics unexpected error',
        error: e,
        stackTrace: stackTrace,
      );
      throw VendorProductAnalyticsFailure.unknown(e.toString());
    }
  }

  VendorProductAnalyticsFailure _handleError(DioException e) {
    final statusCode = e.response?.statusCode;
    final message = DioErrorHandler.handle(e).message;

    switch (statusCode) {
      case 401:
        return VendorProductAnalyticsFailure.unauthorized();
      case 404:
        return VendorProductAnalyticsFailure.notFound();
      case 400:
        return VendorProductAnalyticsFailure.validation(message);
      case 500:
        return VendorProductAnalyticsFailure.serverError();
      default:
        if (e.type == DioExceptionType.connectionError ||
            e.type == DioExceptionType.connectionTimeout) {
          return VendorProductAnalyticsFailure.networkError();
        }
        return VendorProductAnalyticsFailure.unknown(message);
    }
  }
}
