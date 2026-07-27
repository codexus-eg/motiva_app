import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:app/features/vendor-services/domain/entities/vendor_service.dart';

class VendorServiceModel {
  final VendorService vendorService;

  const VendorServiceModel({required this.vendorService});

  factory VendorServiceModel.fromJson(Map<String, dynamic> json) {
    try {
      AppLogger.info('Parsing vendor service: $json');
      return VendorServiceModel(
        vendorService: VendorService(
          id: json['id']?.toString() ?? '',
          vendorId: json['vendorId']?.toString() ?? '',
          categoryId: json['categoryId']?.toString() ?? '',
          name: json['name']?.toString() ?? '',
          description: json['description']?.toString(),
          basePrice: json['basePrice']?.toString(),
          imageUrl: json['imageUrl']?.toString(),
          categoryServiceAttributes:
              json['categoryServiceAttributes'] as Map<String, dynamic>? ?? {},
          requiredCustomerFields: json['requiredCustomerFields'] != null
              ? AttributeField.fromJsonList(
                  json['requiredCustomerFields'] as List<dynamic>? ?? [],
                )
              : const [],
          availabilityRadiusKm: json['availabilityRadiusKm'] != null
              ? (json['availabilityRadiusKm'] is num
                    ? (json['availabilityRadiusKm'] as num).toDouble()
                    : double.tryParse(json['availabilityRadiusKm'].toString()))
              : null,
          isArchived: json['isArchived'] as bool? ?? false,
          createdAt: json['createdAt'] != null
              ? DateTime.parse(json['createdAt'].toString())
              : DateTime.now(),
          updatedAt: json['updatedAt'] != null
              ? DateTime.parse(json['updatedAt'].toString())
              : DateTime.now(),
        ),
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'Failed to parse vendor service',
        error: e,
        stackTrace: stackTrace,
      );
      rethrow;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': vendorService.id,
      'vendorId': vendorService.vendorId,
      'categoryId': vendorService.categoryId,
      'name': vendorService.name,
      'description': vendorService.description,
      'basePrice': vendorService.basePrice,
      'imageUrl': vendorService.imageUrl,
      'categoryServiceAttributes': vendorService.categoryServiceAttributes,
      'requiredCustomerFields': vendorService.requiredCustomerFields
          .map((e) => e.toJson())
          .toList(),
      'availabilityRadiusKm': vendorService.availabilityRadiusKm,
      'isArchived': vendorService.isArchived,
      'createdAt': vendorService.createdAt.toIso8601String(),
      'updatedAt': vendorService.updatedAt.toIso8601String(),
    };
  }

  static List<VendorService> fromJsonList(List<dynamic> jsonList) {
    try {
      AppLogger.info('Parsing ${jsonList.length} vendor services from list');
      final services = jsonList
          .map(
            (json) => VendorServiceModel.fromJson(
              json as Map<String, dynamic>,
            ).vendorService,
          )
          .toList();
      AppLogger.info('Successfully parsed ${services.length} vendor services');
      return services;
    } catch (e, stackTrace) {
      AppLogger.error('fromJsonList failed', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
