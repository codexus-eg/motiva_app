import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';

class VendorProductModel {
  final VendorProduct vendorProduct;

  const VendorProductModel({required this.vendorProduct});

  factory VendorProductModel.fromJson(Map<String, dynamic> json) {
    final partNumber = json['partNumber'] as String?;
    final brand = json['brand'] as String?;
    final warrantyMonths = (json['warrantyMonths'] as num?)?.toInt();
    final compatibilityJson = json['compatibility'] as List?;
    final compatibility = compatibilityJson
        ?.whereType<Map<String, dynamic>>()
        .map(CompatibilityEntry.fromJson)
        .toList();

    return VendorProductModel(
      vendorProduct: VendorProduct(
        id: json['id'] as String,
        vendorId: json['vendorId'] as String,
        name: json['name'] as String,
        description: json['description'] as String?,
        categoryId: json['categoryId'] as String?,
        price: json['price'] as String,
        currency: json['currency'] as String? ?? 'KWD',
        stockQuantity: (json['stockQuantity'] as num?)?.toInt() ?? 0,
        productType: json['productType'] as String? ?? 'accessory',
        partNumber: partNumber,
        brand: brand,
        warrantyMonths: warrantyMonths,
        compatibility: compatibility,
        images: _parseImages(json['images']),
        isActive: json['isActive'] as bool? ?? true,
        createdAt: DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] != null
            ? DateTime.parse(json['updatedAt'] as String)
            : DateTime.parse(json['createdAt'] as String),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': vendorProduct.id,
      'vendorId': vendorProduct.vendorId,
      'name': vendorProduct.name,
      'description': vendorProduct.description,
      'categoryId': vendorProduct.categoryId,
      'price': vendorProduct.price,
      'currency': vendorProduct.currency,
      'stockQuantity': vendorProduct.stockQuantity,
      'productType': vendorProduct.productType,
      'images': vendorProduct.images,
      'isActive': vendorProduct.isActive,
      'createdAt': vendorProduct.createdAt.toIso8601String(),
      'updatedAt': vendorProduct.updatedAt.toIso8601String(),
    };
  }

  static List<VendorProduct> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map(
          (json) => VendorProductModel.fromJson(
            json as Map<String, dynamic>,
          ).vendorProduct,
        )
        .toList();
  }

  static List<String> _parseImages(dynamic imagesValue) {
    AppLogger.debug(
      'Parsing product images: $imagesValue (type: ${imagesValue?.runtimeType})',
    );

    if (imagesValue == null) {
      AppLogger.debug('imagesValue is null, returning []');
      return [];
    }

    if (imagesValue is List) {
      final list = imagesValue
          .whereType<String>()
          .where((s) => s.trim().isNotEmpty)
          .toList();
      AppLogger.debug('Parsed image list: $list');
      return list;
    }

    if (imagesValue is String && imagesValue.trim().isNotEmpty) {
      AppLogger.debug(
        'imagesValue is a single String, wrapping in list: $imagesValue',
      );
      return [imagesValue.trim()];
    }

    AppLogger.debug('Unhandled imagesValue type, returning []');
    return [];
  }
}
