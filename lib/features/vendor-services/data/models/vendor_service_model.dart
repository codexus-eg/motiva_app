import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:app/features/vendor-services/domain/entities/vendor_service.dart';

class VendorServiceModel {
  final VendorService vendorService;

  const VendorServiceModel({required this.vendorService});

  factory VendorServiceModel.fromJson(Map<String, dynamic> json) {
    return VendorServiceModel(
      vendorService: VendorService(
        id: json['id'] as String,
        vendorId: json['vendorId'] as String,
        categoryId: json['categoryId'] as String,
        name: json['name'] as String,
        description: json['description'] as String?,
        basePrice: json['basePrice'] as String?,
        imageUrl: json['imageUrl'] as String?,
        categoryServiceAttributes:
            json['categoryServiceAttributes'] as Map<String, dynamic>? ?? {},
        requiredCustomerFields: json['requiredCustomerFields'] != null
            ? AttributeField.fromJsonList(
                json['requiredCustomerFields'] as List<dynamic>,
              )
            : const [],
        availabilityRadiusKm: (json['availabilityRadiusKm'] as num?)
            ?.toDouble(),
        isArchived: json['isArchived'] as bool? ?? false,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: DateTime.parse(json['updatedAt'] as String),
      ),
    );
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
      'requiredCustomerFields':
          vendorService.requiredCustomerFields.map((e) => e.toJson()).toList(),
      'availabilityRadiusKm': vendorService.availabilityRadiusKm,
      'isArchived': vendorService.isArchived,
      'createdAt': vendorService.createdAt.toIso8601String(),
      'updatedAt': vendorService.updatedAt.toIso8601String(),
    };
  }

  static List<VendorService> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map(
          (json) => VendorServiceModel.fromJson(
            json as Map<String, dynamic>,
          ).vendorService,
        )
        .toList();
  }
}
