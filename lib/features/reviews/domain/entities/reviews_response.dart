import 'review.dart';

class ReviewsResponse {
  final List<Review> data;
  final int total;
  final double averageRating;
  final int page;
  final int limit;
  final int totalPages;
  final String? nextCursor;
  final bool hasMore;

  ReviewsResponse({
    required this.data,
    required this.total,
    required this.averageRating,
    required this.page,
    required this.limit,
    required this.totalPages,
    this.nextCursor,
    required this.hasMore,
  });
}
