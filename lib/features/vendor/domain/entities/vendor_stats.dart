class VendorStats {
  final int totalSales;
  final double totalEarnings;
  final String averageRating;
  final String cancellationRate;
  final int totalOrders;
  final int pendingOrders;
  final int incomingRequests;
  final int completedOrders;
  final int totalReviews;

  const VendorStats({
    required this.totalSales,
    required this.totalEarnings,
    required this.averageRating,
    required this.cancellationRate,
    required this.totalOrders,
    required this.pendingOrders,
    required this.incomingRequests,
    required this.completedOrders,
    required this.totalReviews,
  });

  factory VendorStats.fromJson(Map<String, dynamic> json) {
    return VendorStats(
      totalSales: json['totalSales'] as int? ?? 0,
      totalEarnings:
          double.tryParse(json['totalEarnings']?.toString() ?? '0') ?? 0,
      averageRating: json['averageRating'] as String? ?? '0.00',
      cancellationRate: json['cancellationRate'] as String? ?? '0.0',
      totalOrders: json['totalOrders'] as int? ?? 0,
      pendingOrders: json['pendingOrders'] as int? ?? 0,
      incomingRequests: json['incomingRequests'] as int? ?? 0,
      completedOrders: json['completedOrders'] as int? ?? 0,
      totalReviews: json['totalReviews'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalSales': totalSales,
      'totalEarnings': totalEarnings,
      'averageRating': averageRating,
      'cancellationRate': cancellationRate,
      'totalOrders': totalOrders,
      'pendingOrders': pendingOrders,
      'incomingRequests': incomingRequests,
      'completedOrders': completedOrders,
      'totalReviews': totalReviews,
    };
  }
}
