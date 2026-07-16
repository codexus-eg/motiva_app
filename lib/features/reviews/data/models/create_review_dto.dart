class CreateReviewDto {
  final String? serviceOrderId;
  final String? productOrderId;
  final String vendorId;
  final int rating;
  final String body;

  CreateReviewDto({
    this.serviceOrderId,
    this.productOrderId,
    required this.vendorId,
    required this.rating,
    required this.body,
  });

  Map<String, dynamic> toJson() {
    return {
      if (serviceOrderId != null) 'serviceOrderId': serviceOrderId,
      if (productOrderId != null) 'productOrderId': productOrderId,
      'vendorId': vendorId,
      'rating': rating,
      'body': body,
    };
  }

  void validate() {
    if (rating < 1 || rating > 5) {
      throw ArgumentError('Rating must be between 1 and 5');
    }
    if (body.length > 5000) {
      throw ArgumentError('Review body must be at most 5000 characters');
    }
    if (serviceOrderId == null && productOrderId == null) {
      throw ArgumentError('Either serviceOrderId or productOrderId must be provided');
    }
  }
}
