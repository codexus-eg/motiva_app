/// A visibility tier that a seller can pick for a regular (non-Fast-Track) car listing.
/// Plans are configured by the admin in the dashboard and fetched from
/// `GET /api/car-marketplace/listing-plans`.
class ListingPlan {
  final String id;
  final String conditionStatus;
  final String durationLabel;
  final String durationUnit; // 'DAYS' | 'WEEKS' | 'MONTHS'
  final int durationCount;
  final double price;
  final int sortOrder;
  final bool isActive;

  const ListingPlan({
    required this.id,
    required this.conditionStatus,
    required this.durationLabel,
    required this.durationUnit,
    required this.durationCount,
    required this.price,
    required this.sortOrder,
    required this.isActive,
  });

  /// Builds a [ListingPlan] from a JSON map returned by the backend.
  /// The backend's `ListingPlanItemDto` has these fields:
  /// { id, conditionStatus, durationLabel, durationUnit, durationCount, price, sortOrder, isActive }
  factory ListingPlan.fromJson(Map<String, dynamic> json) {
    return ListingPlan(
      id: json['id'] as String,
      conditionStatus: json['conditionStatus'] as String,
      durationLabel: json['durationLabel'] as String,
      durationUnit: json['durationUnit'] as String,
      durationCount: _parseInt(json['durationCount']),
      price: _parseDouble(json['price']),
      sortOrder: _parseInt(json['sortOrder'] ?? 0),
      isActive: json['isActive'] as bool? ?? true,
    );
  }

  /// Convenience: format the duration for display, e.g.
  /// `1 week`, `2 weeks`, `1 month`, `3 days`.
  String get displayDuration {
    if (durationCount == 1) {
      switch (durationUnit) {
        case 'DAYS':
          return '1 day';
        case 'WEEKS':
          return '1 week';
        case 'MONTHS':
          return '1 month';
      }
    }
    switch (durationUnit) {
      case 'DAYS':
        return '$durationCount days';
      case 'WEEKS':
        return '$durationCount weeks';
      case 'MONTHS':
        return '$durationCount months';
    }
    return '$durationCount $durationUnit';
  }
}

/// Wrapper for the API response. The backend returns:
/// `{ plans: { GOOD: Plan[], DAMAGED: [], ... } }`
/// We model this as a typed map: condition status → list of plans.
class ListingPlansResponse {
  final Map<String, List<ListingPlan>> plans;

  const ListingPlansResponse({required this.plans});

  factory ListingPlansResponse.fromJson(Map<String, dynamic> json) {
    final raw = (json['plans'] as Map<String, dynamic>?) ?? {};
    final result = <String, List<ListingPlan>>{};
    raw.forEach((key, value) {
      final list = (value as List<dynamic>)
          .map((e) => ListingPlan.fromJson(e as Map<String, dynamic>))
          .toList();
      result[key] = list;
    });
    return ListingPlansResponse(plans: result);
  }

  /// Convenience: get plans for a specific condition, e.g. `getForCondition('GOOD')`.
  List<ListingPlan> getForCondition(String conditionStatus) {
    return plans[conditionStatus] ?? const [];
  }

  /// Convenience: all plans as a flat list, sorted by sortOrder.
  List<ListingPlan> get all {
    final flat = <ListingPlan>[];
    plans.forEach((_, list) => flat.addAll(list));
    flat.sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    return flat;
  }
}

/// Parse a value that might come back as a numeric string (e.g. "50.00")
/// or as a JS number. The backend stores price as `numeric` and Drizzle
/// serializes numeric columns as strings, so we must handle both shapes.
double _parseDouble(dynamic value) {
  if (value == null) return 0.0;
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value) ?? 0.0;
  return 0.0;
}

/// Parse a value that might come back as an integer string (e.g. "1") or
/// as a JS number. Backend integer columns serialized through Drizzle
/// may appear as either type, so we handle both.
int _parseInt(dynamic value) {
  if (value == null) return 0;
  if (value is int) return value;
  if (value is num) return value.toInt();
  if (value is String) return int.tryParse(value) ?? 0;
  return 0;
}