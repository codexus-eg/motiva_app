import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/reviews/data/datasources/reviews_remote_data_source.dart';
import 'package:app/features/reviews/data/models/create_review_dto.dart';
import 'package:app/features/reviews/data/models/review_dto.dart';
import 'package:app/features/reviews/domain/entities/review.dart';
import 'package:app/features/reviews/domain/entities/reviews_response.dart';
import 'package:app/features/reviews/domain/failures/reviews_failure.dart';
import 'package:app/features/reviews/domain/repositories/reviews_repository.dart';

class ReviewsRepositoryImpl implements ReviewsRepository {
  final ReviewsRemoteDataSource _remoteDataSource;

  ReviewsRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> submitReview(CreateReviewDto dto) async {
    try {
      await _remoteDataSource.submitReview(dto);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('submitReview failed', error: e, stackTrace: stackTrace);
      throw _mapExceptionToFailure(e);
    }
  }

  @override
  Future<ReviewsResponse> getReviews({
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
      final dto = await _remoteDataSource.getReviews(
        vendorServiceId: vendorServiceId,
        productId: productId,
        vendorId: vendorId,
        rating: rating,
        sort: sort,
        page: page,
        limit: limit,
        cursor: cursor,
      );

      final reviews = dto.data.map(_mapReviewDtoToEntity).toList();

      return ReviewsResponse(
        data: reviews,
        total: dto.total,
        averageRating: dto.averageRating,
        page: dto.page,
        limit: dto.limit,
        totalPages: dto.totalPages,
        nextCursor: dto.nextCursor,
        hasMore: dto.hasMore,
      );
    } on Exception catch (e, stackTrace) {
      AppLogger.error('getReviews failed', error: e, stackTrace: stackTrace);
      throw _mapExceptionToFailure(e);
    }
  }

  Review _mapReviewDtoToEntity(ReviewDto dto) {
    return Review(
      id: dto.id,
      rating: dto.rating,
      body: dto.body,
      createdAt: DateTime.parse(dto.createdAt),
      verifiedPurchase: dto.verifiedPurchase,
      reviewerName: dto.reviewer.firstName,
      reviewerInitials: dto.reviewer.initials,
    );
  }

  ReviewsFailure _mapExceptionToFailure(Exception exception) {
    final message = exception.toString();

    if (message.contains('Network error') ||
        message.contains('Connection timeout')) {
      return ReviewsFailure.network(message);
    } else if (message.contains('Unauthorized')) {
      return ReviewsFailure.unauthorized(message);
    } else if (message.contains('Forbidden')) {
      return ReviewsFailure.forbidden(message);
    } else if (message.contains('Not found')) {
      return ReviewsFailure.notFound(message);
    } else if (message.contains('Already reviewed')) {
      return ReviewsFailure.alreadyReviewed(message);
    } else if (message.contains('Validation error') ||
        message.contains('Rating must be') ||
        message.contains('Review body must be')) {
      return ReviewsFailure.validation(message);
    } else {
      return ReviewsFailure.unknown(message);
    }
  }
}
