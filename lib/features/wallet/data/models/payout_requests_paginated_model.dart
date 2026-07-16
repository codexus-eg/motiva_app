import '../../domain/entities/payout_requests_paginated.dart';
import 'payout_request_model.dart';

class PayoutRequestsPaginatedModel {
  final PayoutRequestsPaginated paginated;

  const PayoutRequestsPaginatedModel(this.paginated);

  factory PayoutRequestsPaginatedModel.fromJson(Map<String, dynamic> json) {
    final dataList = (json['data'] as List<dynamic>)
        .map((item) => PayoutRequestModel.fromJson(item as Map<String, dynamic>))
        .toList();

    return PayoutRequestsPaginatedModel(
      PayoutRequestsPaginated(
        data: dataList.map((m) => m.request).toList(),
        total: (json['total'] as num).toInt(),
        page: (json['page'] as num).toInt(),
        limit: (json['limit'] as num).toInt(),
        totalPages: (json['totalPages'] as num).toInt(),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': paginated.data
        .map((r) => PayoutRequestModel(r).toJson())
        .toList(),
    'total': paginated.total,
    'page': paginated.page,
    'limit': paginated.limit,
    'totalPages': paginated.totalPages,
  };
}
