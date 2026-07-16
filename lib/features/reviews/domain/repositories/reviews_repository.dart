import 'package:app/features/reviews/data/models/create_review_dto.dart';
import 'package:app/features/reviews/domain/entities/reviews_response.dart';

abstract class ReviewsRepository {
  Future<void> submitReview(CreateReviewDto dto);
  Future<ReviewsResponse> getReviews({
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
