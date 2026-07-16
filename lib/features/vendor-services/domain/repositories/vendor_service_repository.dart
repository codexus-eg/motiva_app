import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:app/features/vendor-services/domain/entities/vendor_service.dart';

abstract class VendorServiceRepository {
  Future<List<VendorService>> getServices();
  Future<VendorService> getService(String id);
  Future<VendorService> createService(CreateServiceParams params);
  Future<VendorService> updateService(String id, UpdateServiceParams params);
  Future<VendorService> archiveService(String id);
  Future<VendorService> restoreService(String id);
}

class CreateServiceParams {
  final String categoryId;
  final String name;
  final String? description;
  final double? basePrice;
  final String? imageUrl;
  final Map<String, dynamic> categoryServiceAttributes;
  final List<AttributeField> requiredCustomerFields;
  final double? availabilityRadiusKm;

  const CreateServiceParams({
    required this.categoryId,
    required this.name,
    this.description,
    this.basePrice,
    this.imageUrl,
    required this.categoryServiceAttributes,
    this.requiredCustomerFields = const [],
    this.availabilityRadiusKm,
  });

  Map<String, dynamic> toJson() {
    return {
      'categoryId': categoryId,
      'name': name,
      if (description != null) 'description': description,
      if (basePrice != null) 'basePrice': basePrice,
      if (imageUrl != null) 'imageUrl': imageUrl,
      'categoryServiceAttributes': categoryServiceAttributes,
      'requiredCustomerFields':
          requiredCustomerFields.map((e) => e.toJson()).toList(),
      if (availabilityRadiusKm != null)
        'availabilityRadiusKm': availabilityRadiusKm,
    };
  }
}

class UpdateServiceParams {
  final String? categoryId;
  final String? name;
  final String? description;
  final double? basePrice;
  final String? imageUrl;
  final Map<String, dynamic>? categoryServiceAttributes;
  final List<AttributeField>? requiredCustomerFields;
  final double? availabilityRadiusKm;

  const UpdateServiceParams({
    this.categoryId,
    this.name,
    this.description,
    this.basePrice,
    this.imageUrl,
    this.categoryServiceAttributes,
    this.requiredCustomerFields,
    this.availabilityRadiusKm,
  });

  Map<String, dynamic> toJson() {
    return {
      if (categoryId != null) 'categoryId': categoryId,
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (basePrice != null) 'basePrice': basePrice,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (categoryServiceAttributes != null)
        'categoryServiceAttributes': categoryServiceAttributes,
      if (requiredCustomerFields != null)
        'requiredCustomerFields':
            requiredCustomerFields!.map((e) => e.toJson()).toList(),
      if (availabilityRadiusKm != null)
        'availabilityRadiusKm': availabilityRadiusKm,
    };
  }
}
