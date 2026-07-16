import 'review_dto.dart';

class ReviewResponseDto {
  final List<ReviewDto> data;
  final int total;
  final double averageRating;
  final int page;
  final int limit;
  final int totalPages;
  final String? nextCursor;
  final bool hasMore;

  ReviewResponseDto({
    required this.data,
    required this.total,
    required this.averageRating,
    required this.page,
    required this.limit,
    required this.totalPages,
    this.nextCursor,
    required this.hasMore,
  });

  factory ReviewResponseDto.fromJson(Map<String, dynamic> json) {
    return ReviewResponseDto(
      data: (json['data'] as List)
          .map((item) => ReviewDto.fromJson(item as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      averageRating: json['averageRating'] is String
          ? double.parse(json['averageRating'] as String)
          : (json['averageRating'] as num).toDouble(),
      page: json['page'] as int,
      limit: json['limit'] as int,
      totalPages: json['totalPages'] as int,
      nextCursor: json['nextCursor'] as String?,
      hasMore: json['hasMore'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
      'total': total,
      'averageRating': averageRating,
      'page': page,
      'limit': limit,
      'totalPages': totalPages,
      'nextCursor': nextCursor,
      'hasMore': hasMore,
    };
  }
}
