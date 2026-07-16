import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/reviews/data/models/create_review_dto.dart';
import 'package:app/features/reviews/data/models/review_response_dto.dart';
import 'package:dio/dio.dart';

abstract class ReviewsRemoteDataSource {
  Future<void> submitReview(CreateReviewDto dto);
  Future<ReviewResponseDto> getReviews({
    String? vendorServiceId,
    String? productId,
    String? vendorId,
    int? rating,
    String? sort,
    int? page,
    int? limit,
    String? cursor,
  });
}

class ReviewsRemoteDataSourceImpl implements ReviewsRemoteDataSource {
  final DioClient _dioClient;

  ReviewsRemoteDataSourceImpl(this._dioClient);

  @override
  Future<void> submitReview(CreateReviewDto dto) async {
    try {
      dto.validate();
      await _dioClient.dio.post('/api/reviews', data: dto.toJson());
    } on DioException catch (e, stackTrace) {
      AppLogger.error('submitReview failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on ArgumentError catch (e, stackTrace) {
      AppLogger.error(
        'submitReview validation failed',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    } on Exception catch (e, stackTrace) {
      AppLogger.error('submitReview failed', error: e, stackTrace: stackTrace);
      throw Exception('Failed to submit review: ${e.toString()}');
    }
  }

  @override
  Future<ReviewResponseDto> getReviews({
    String? vendorServiceId,
    String? productId,
    String? vendorId,
    int? rating,
    String? sort,
    int? page,
    int? limit,
    String? cursor,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (vendorServiceId != null) {
        queryParams['vendorServiceId'] = vendorServiceId;
      }
      if (productId != null) queryParams['productId'] = productId;
      if (vendorId != null) queryParams['vendorId'] = vendorId;
      if (rating != null) queryParams['rating'] = rating;
      if (sort != null) queryParams['sort'] = sort;
      if (page != null) queryParams['page'] = page;
      if (limit != null) queryParams['limit'] = limit;
      if (cursor != null) queryParams['cursor'] = cursor;

      final response = await _dioClient.dio.get(
        '/api/reviews',
        queryParameters: queryParams,
      );

      return ReviewResponseDto.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('getReviews failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('getReviews failed', error: e, stackTrace: stackTrace);
      throw Exception('Failed to fetch reviews: ${e.toString()}');
    }
  }

  Exception _handleDioError(DioException e) {
    final errorInfo = DioErrorHandler.handle(e);
    final message = errorInfo.message;

    // Network errors
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      return Exception('Network error: Connection timeout');
    }

    switch (errorInfo.statusCode) {
      case 400:
        return Exception('Validation error: $message');
      case 401:
        return Exception('Unauthorized: $message');
      case 403:
        return Exception('Forbidden: $message');
      case 404:
        return Exception('Not found: $message');
      case 409:
        return Exception('Already reviewed: $message');
      default:
        return Exception('Failed to submit review: $message');
    }
  }
}
