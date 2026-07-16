import 'package:flutter/foundation.dart';

@immutable
class VendorDashboardStats {
  final String totalSales;
  final String totalEarnings;
  final int completedJobsCount;
  final double averageRating;
  final double cancellationRate;

  const VendorDashboardStats({
    required this.totalSales,
    required this.totalEarnings,
    required this.completedJobsCount,
    required this.averageRating,
    required this.cancellationRate,
  });

  VendorDashboardStats copyWith({
    String? totalSales,
    String? totalEarnings,
    int? completedJobsCount,
    double? averageRating,
    double? cancellationRate,
  }) {
    return VendorDashboardStats(
      totalSales: totalSales ?? this.totalSales,
      totalEarnings: totalEarnings ?? this.totalEarnings,
      completedJobsCount: completedJobsCount ?? this.completedJobsCount,
      averageRating: averageRating ?? this.averageRating,
      cancellationRate: cancellationRate ?? this.cancellationRate,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VendorDashboardStats &&
          runtimeType == other.runtimeType &&
          totalSales == other.totalSales &&
          totalEarnings == other.totalEarnings &&
          completedJobsCount == other.completedJobsCount &&
          averageRating == other.averageRating &&
          cancellationRate == other.cancellationRate;

  @override
  int get hashCode => Object.hash(
    totalSales,
    totalEarnings,
    completedJobsCount,
    averageRating,
    cancellationRate,
  );

  @override
  String toString() =>
      'VendorDashboardStats(totalSales: $totalSales, totalEarnings: $totalEarnings, completedJobsCount: $completedJobsCount, averageRating: $averageRating, cancellationRate: $cancellationRate)';
}
