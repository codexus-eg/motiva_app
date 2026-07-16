import 'package:flutter/foundation.dart';

import 'payout_request.dart';

@immutable
class PayoutRequestsPaginated {
  final List<PayoutRequest> data;
  final int total;
  final int page;
  final int limit;
  final int totalPages;

  const PayoutRequestsPaginated({
    required this.data,
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  PayoutRequestsPaginated copyWith({
    List<PayoutRequest>? data,
    int? total,
    int? page,
    int? limit,
    int? totalPages,
  }) {
    return PayoutRequestsPaginated(
      data: data ?? this.data,
      total: total ?? this.total,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PayoutRequestsPaginated &&
          runtimeType == other.runtimeType &&
          total == other.total &&
          page == other.page &&
          limit == other.limit &&
          totalPages == other.totalPages &&
          listEquals(data, other.data);

  @override
  int get hashCode => Object.hash(
    Object.hashAll(data),
    total,
    page,
    limit,
    totalPages,
  );

  @override
  String toString() =>
      'PayoutRequestsPaginated(data: $data, total: $total, page: $page, limit: $limit, totalPages: $totalPages)';
}
