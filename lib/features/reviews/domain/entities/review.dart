class Review {
  final String id;
  final int rating;
  final String body;
  final DateTime createdAt;
  final bool verifiedPurchase;
  final String reviewerName;
  final String reviewerInitials;

  Review({
    required this.id,
    required this.rating,
    required this.body,
    required this.createdAt,
    required this.verifiedPurchase,
    required this.reviewerName,
    required this.reviewerInitials,
  });
}
