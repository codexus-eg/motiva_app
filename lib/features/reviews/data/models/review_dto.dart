class ReviewDto {
  final String id;
  final int rating;
  final String body;
  final String createdAt;
  final bool verifiedPurchase;
  final ReviewerDto reviewer;

  ReviewDto({
    required this.id,
    required this.rating,
    required this.body,
    required this.createdAt,
    required this.verifiedPurchase,
    required this.reviewer,
  });

  factory ReviewDto.fromJson(Map<String, dynamic> json) {
    return ReviewDto(
      id: json['id'] as String,
      rating: json['rating'] as int,
      body: json['body'] as String,
      createdAt: json['createdAt'] as String,
      verifiedPurchase: json['verifiedPurchase'] as bool? ?? false,
      reviewer: ReviewerDto.fromJson(json['reviewer'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rating': rating,
      'body': body,
      'createdAt': createdAt,
      'verifiedPurchase': verifiedPurchase,
      'reviewer': reviewer.toJson(),
    };
  }
}

class ReviewerDto {
  final String firstName;
  final String initials;

  ReviewerDto({
    required this.firstName,
    required this.initials,
  });

  factory ReviewerDto.fromJson(Map<String, dynamic> json) {
    return ReviewerDto(
      firstName: json['firstName'] as String,
      initials: json['initials'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'initials': initials,
    };
  }
}
