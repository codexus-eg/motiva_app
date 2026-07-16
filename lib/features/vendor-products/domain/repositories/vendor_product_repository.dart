import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';

abstract class VendorProductRepository {
  Future<List<VendorProduct>> getProducts(String vendorId);
  Future<VendorProduct> getProduct(String id);
  Future<VendorProduct> createProduct(CreateProductParams params);
  Future<VendorProduct> updateProduct(String id, UpdateProductParams params);
  Future<VendorProduct> deleteProduct(String id);
  Future<VendorProduct> toggleProductActive(String id);
}

class CreateProductParams {
  final String name;
  final String? description;
  final String? categoryId;
  final double price;
  final String currency;
  final double stockQuantity;
  final String productType;
  final String? partNumber;
  final String? brand;
  final int? warrantyMonths;
  final List<CompatibilityEntry>? compatibility;
  final List<String> images;

  const CreateProductParams({
    required this.name,
    this.description,
    this.categoryId,
    required this.price,
    this.currency = 'KWD',
    required this.stockQuantity,
    required this.productType,
    this.partNumber,
    this.brand,
    this.warrantyMonths,
    this.compatibility,
    required this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      if (description != null) 'description': description,
      if (categoryId != null) 'categoryId': categoryId,
      'price': price,
      'currency': currency,
      'stockQuantity': stockQuantity,
      'productType': productType,
      if (partNumber != null) 'partNumber': partNumber,
      if (brand != null) 'brand': brand,
      if (warrantyMonths != null) 'warrantyMonths': warrantyMonths,
      if (compatibility != null && compatibility!.isNotEmpty)
        'compatibility': compatibility!.map((e) => e.toJson()).toList(),
      'images': images,
    };
  }
}

class UpdateProductParams {
  final String? name;
  final String? description;
  final String? categoryId;
  final double? price;
  final String? currency;
  final double? stockQuantity;
  final String? productType;
  final String? partNumber;
  final String? brand;
  final int? warrantyMonths;
  final List<CompatibilityEntry>? compatibility;
  final List<String>? images;

  const UpdateProductParams({
    this.name,
    this.description,
    this.categoryId,
    this.price,
    this.currency,
    this.stockQuantity,
    this.productType,
    this.partNumber,
    this.brand,
    this.warrantyMonths,
    this.compatibility,
    this.images,
  });

  Map<String, dynamic> toJson() {
    return {
      if (name != null) 'name': name,
      if (description != null) 'description': description,
      if (categoryId != null) 'categoryId': categoryId,
      if (price != null) 'price': price,
      if (currency != null) 'currency': currency,
      if (stockQuantity != null) 'stockQuantity': stockQuantity,
      if (productType != null) 'productType': productType,
      if (partNumber != null) 'partNumber': partNumber,
      if (brand != null) 'brand': brand,
      if (warrantyMonths != null) 'warrantyMonths': warrantyMonths,
      if (compatibility != null)
        'compatibility': compatibility!.map((e) => e.toJson()).toList(),
      if (images != null) 'images': images,
    };
  }
}
