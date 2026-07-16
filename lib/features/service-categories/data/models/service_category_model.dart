import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';

class ServiceCategoryModel {
  final ServiceCategory serviceCategory;
  final BehaviorConfig? behaviorConfig;
  final List<AttributeField>? attributeSchema;

  const ServiceCategoryModel({
    required this.serviceCategory,
    this.behaviorConfig,
    this.attributeSchema,
  });

  factory ServiceCategoryModel.fromJson(Map<String, dynamic> json) {
    try {
      return ServiceCategoryModel(
        serviceCategory: ServiceCategory.fromJson(json),
        behaviorConfig: json['behaviorConfig'] != null
            ? BehaviorConfig.fromJson(
                json['behaviorConfig'] as Map<String, dynamic>,
              )
            : null,
        attributeSchema: json['attributeSchema'] != null
            ? AttributeField.fromJsonList(
                json['attributeSchema'] as List<dynamic>,
              )
            : null,
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'ServiceCategoryModel.fromJson failed',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': serviceCategory.id,
      'name': serviceCategory.name,
      'slug': serviceCategory.slug,
      'description': serviceCategory.description,
      'iconUrl': serviceCategory.iconUrl,
      'isArchived': serviceCategory.isArchived,
      'sortOrder': serviceCategory.sortOrder,
      'behaviorConfig': behaviorConfig?.toJson(),
      'attributeSchema': attributeSchema?.map((e) => e.toJson()).toList(),
    };
  }

  static List<ServiceCategory> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map(
          (json) => ServiceCategoryModel.fromJson(
            json as Map<String, dynamic>,
          ).serviceCategory,
        )
        .toList();
  }
}
