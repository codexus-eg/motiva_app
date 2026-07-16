import 'package:app/features/vendor/domain/entities/operator.dart';

class OperatorModel {
  final Operator operator;

  const OperatorModel({required this.operator});

  factory OperatorModel.fromJson(Map<String, dynamic> json) {
    final String id = json['id'] as String;
    return OperatorModel(
      operator: Operator(
        id: id,
        userId: id,
        vendorId: json['vendorId'] as String,
        name: json['fullName'] as String,
        phone: json['phone'] as String,
        email: json['email'] as String,
        avatarUrl: json['avatarUrl'] as String?,
        isActive: !(json['isArchived'] as bool? ?? false),
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': operator.id,
      'userId': operator.userId,
      'vendorId': operator.vendorId,
      'name': operator.name,
      'phone': operator.phone,
      'email': operator.email,
      'avatarUrl': operator.avatarUrl,
      'isActive': operator.isActive,
      'createdAt': operator.createdAt.toIso8601String(),
      'updatedAt': operator.updatedAt.toIso8601String(),
    };
  }
}
