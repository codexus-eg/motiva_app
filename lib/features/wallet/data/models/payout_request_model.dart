import '../../domain/entities/payout_request.dart';

class PayoutRequestModel {
  final PayoutRequest request;

  const PayoutRequestModel(this.request);

  factory PayoutRequestModel.fromJson(Map<String, dynamic> json) {
    return PayoutRequestModel(
      PayoutRequest(
        id: json['id'] as String,
        userId: json['userId'] as String,
        amount: json['amount'] as String,
        status: json['status'] as String,
        bankName: json['bankName'] as String?,
        accountNumber: json['accountNumber'] as String?,
        accountHolderName: json['accountHolderName'] as String?,
        kuwaitCode: json['kuwaitCode'] as String?,
        adminNotes: json['adminNotes'] as String?,
        reviewedBy: json['reviewedBy'] as String?,
        reviewedAt: json['reviewedAt'] != null
            ? DateTime.parse(json['reviewedAt'] as String)
            : null,
        processedAt: json['processedAt'] != null
            ? DateTime.parse(json['processedAt'] as String)
            : null,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': request.id,
    'userId': request.userId,
    'amount': request.amount,
    'status': request.status,
    'bankName': request.bankName,
    'accountNumber': request.accountNumber,
    'accountHolderName': request.accountHolderName,
    'kuwaitCode': request.kuwaitCode,
    'adminNotes': request.adminNotes,
    'reviewedBy': request.reviewedBy,
    'reviewedAt': request.reviewedAt?.toIso8601String(),
    'processedAt': request.processedAt?.toIso8601String(),
    'createdAt': request.createdAt.toIso8601String(),
    'updatedAt': request.updatedAt.toIso8601String(),
  };
}
