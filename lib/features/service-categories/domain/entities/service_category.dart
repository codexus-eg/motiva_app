import 'package:app/core/utils/app_logger.dart';

class ServiceCategory {
  final String id;
  final String name;
  final String slug;
  final String? description;
  final String? iconUrl;
  final String? imageUrl;
  final String? coverImageUrl;
  final bool isArchived;
  final int sortOrder;

  const ServiceCategory({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.iconUrl,
    this.imageUrl,
    this.coverImageUrl,
    this.isArchived = false,
    this.sortOrder = 0,
  });

  factory ServiceCategory.fromJson(Map<String, dynamic> json) {
    return ServiceCategory(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      iconUrl: json['iconUrl'] as String?,
      imageUrl: json['imageUrl'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      isArchived: json['isArchived'] as bool? ?? false,
      sortOrder: _parseSortOrder(json['sortOrder']),
    );
  }

  static int _parseSortOrder(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ServiceCategory &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}

class AttributeField {
  final String key;
  final String label;
  final String type;
  final bool required;
  final List<String>? options;
  final num? min;
  final num? max;

  const AttributeField({
    required this.key,
    required this.label,
    required this.type,
    this.required = false,
    this.options,
    this.min,
    this.max,
  });

  factory AttributeField.fromJson(Map<String, dynamic> json) {
    try {
      return AttributeField(
        key: json['key'] as String,
        label: json['label'] as String,
        type: json['type'] as String,
        required: json['required'] as bool? ?? false,
        options: (json['options'] as List<dynamic>?)
            ?.map((e) => e.toString())
            .toList(),
        min: json['min'] != null ? (json['min'] as num).toDouble() : null,
        max: json['max'] != null ? (json['max'] as num).toDouble() : null,
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'AttributeField.fromJson failed',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'label': label,
      'type': type,
      'required': required,
      'options': options,
      'min': min,
      'max': max,
    };
  }

  static List<AttributeField> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => AttributeField.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

class BehaviorConfig {
  @Deprecated('Use requiresVendorDocuments')
  final bool requiresDocuments;
  final bool requiresVendorDocuments;
  final bool requiresQuotation;
  final bool requiresGps;
  final bool allowsScheduling;
  final bool requiresRoute;

  const BehaviorConfig({
    this.requiresDocuments = false,
    this.requiresVendorDocuments = false,
    this.requiresQuotation = false,
    this.requiresGps = false,
    this.allowsScheduling = false,
    this.requiresRoute = false,
  });

  factory BehaviorConfig.fromJson(Map<String, dynamic>? json) {
    if (json == null) return const BehaviorConfig();
    try {
      return BehaviorConfig(
        requiresDocuments: json['requiresDocuments'] as bool? ?? false,
        requiresVendorDocuments:
            json['requiresVendorDocuments'] as bool? ?? false,
        requiresQuotation: json['requiresQuotation'] as bool? ?? false,
        requiresGps: json['requiresGps'] as bool? ?? false,
        allowsScheduling: json['allowsScheduling'] as bool? ?? false,
        requiresRoute: json['requiresRoute'] as bool? ?? false,
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'BehaviorConfig.fromJson failed',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'requiresDocuments': requiresDocuments,
      'requiresVendorDocuments': requiresVendorDocuments,
      'requiresQuotation': requiresQuotation,
      'requiresGps': requiresGps,
      'allowsScheduling': allowsScheduling,
      'requiresRoute': requiresRoute,
    };
  }
}

class ServiceCategoryWithSchema {
  final String id;
  final String name;
  final String slug;
  final String? description;
  final String? iconUrl;
  final String? imageUrl;
  final String? coverImageUrl;
  final BehaviorConfig behaviorConfig;
  final List<AttributeField> attributeSchema;
  final bool isArchived;
  final int sortOrder;

  const ServiceCategoryWithSchema({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.iconUrl,
    this.imageUrl,
    this.coverImageUrl,
    required this.behaviorConfig,
    required this.attributeSchema,
    this.isArchived = false,
    this.sortOrder = 0,
  });

  factory ServiceCategoryWithSchema.fromJson(Map<String, dynamic> json) {
    try {
      return ServiceCategoryWithSchema(
        id: json['id'] as String,
        name: json['name'] as String,
        slug: json['slug'] as String,
        description: json['description'] as String?,
        iconUrl: json['iconUrl'] as String?,
        imageUrl: json['imageUrl'] as String?,
        coverImageUrl: json['coverImageUrl'] as String?,
        behaviorConfig: BehaviorConfig.fromJson(
          json['behaviorConfig'] as Map<String, dynamic>? ?? {},
        ),
        attributeSchema: AttributeField.fromJsonList(
          json['attributeSchema'] as List<dynamic>? ?? [],
        ),
        isArchived: json['isArchived'] as bool? ?? false,
        sortOrder: _parseSortOrder(json['sortOrder']),
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'ServiceCategoryWithSchema.fromJson failed',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  static int _parseSortOrder(dynamic value) {
    if (value == null) return 0;
    if (value is int) return value;
    if (value is String) return int.tryParse(value) ?? 0;
    return 0;
  }
}
