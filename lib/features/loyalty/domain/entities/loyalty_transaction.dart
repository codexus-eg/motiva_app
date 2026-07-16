import 'package:flutter/foundation.dart';

@immutable
class LoyaltyTransaction {
  final String id;
  final String type;
  final int points;
  final String? description;
  final String? referenceId;
  final DateTime createdAt;

  const LoyaltyTransaction({
    required this.id,
    required this.type,
    required this.points,
    this.description,
    this.referenceId,
    required this.createdAt,
  });

  LoyaltyTransaction copyWith({
    String? id,
    String? type,
    int? points,
    String? description,
    String? referenceId,
    DateTime? createdAt,
  }) {
    return LoyaltyTransaction(
      id: id ?? this.id,
      type: type ?? this.type,
      points: points ?? this.points,
      description: description ?? this.description,
      referenceId: referenceId ?? this.referenceId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoyaltyTransaction &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          points == other.points &&
          description == other.description &&
          referenceId == other.referenceId &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(
    id,
    type,
    points,
    description,
    referenceId,
    createdAt,
  );

  @override
  String toString() =>
      'LoyaltyTransaction(id: $id, type: $type, points: $points, description: $description, referenceId: $referenceId, createdAt: $createdAt)';
}
