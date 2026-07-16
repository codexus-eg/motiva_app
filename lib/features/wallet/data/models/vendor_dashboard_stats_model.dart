import '../../domain/entities/vendor_dashboard_stats.dart';

class VendorDashboardStatsModel {
  final VendorDashboardStats stats;

  const VendorDashboardStatsModel(this.stats);

  factory VendorDashboardStatsModel.fromJson(Map<String, dynamic> json) {
    return VendorDashboardStatsModel(
      VendorDashboardStats(
        totalSales: json['totalSales'] as String,
        totalEarnings: json['totalEarnings'] as String,
        completedJobsCount: (json['completedJobsCount'] as num).toInt(),
        averageRating: (json['averageRating'] as num).toDouble(),
        cancellationRate: (json['cancellationRate'] as num).toDouble(),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'totalSales': stats.totalSales,
    'totalEarnings': stats.totalEarnings,
    'completedJobsCount': stats.completedJobsCount,
    'averageRating': stats.averageRating,
    'cancellationRate': stats.cancellationRate,
  };
}
