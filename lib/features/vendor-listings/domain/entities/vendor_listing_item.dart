import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';
import 'package:app/features/vendor-services/domain/entities/vendor_service.dart';
import 'package:app/features/vendor-cars/domain/entities/vendor_car.dart';

enum ListingType { product, service, car }

class VendorListingItem {
  final String id;
  final String name;
  final String? description;
  final String? price;
  final String? imageUrl;
  final bool isActive;
  final bool isArchived;
  final DateTime createdAt;
  final ListingType type;

  final VendorProduct? product;
  final VendorService? service;
  final VendorCar? car;

  String? get categoryId => type == ListingType.product
      ? product?.categoryId
      : type == ListingType.service
      ? service?.categoryId
      : null;

  const VendorListingItem({
    required this.id,
    required this.name,
    this.description,
    this.price,
    this.imageUrl,
    required this.isActive,
    required this.isArchived,
    required this.createdAt,
    required this.type,
    this.product,
    this.service,
    this.car,
  });

  factory VendorListingItem.fromProduct(VendorProduct product) {
    return VendorListingItem(
      id: product.id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.images.isNotEmpty ? product.images.first : null,
      isActive: product.isActive,
      isArchived: !product.isActive,
      createdAt: product.createdAt,
      type: ListingType.product,
      product: product,
    );
  }

  factory VendorListingItem.fromService(VendorService service) {
    return VendorListingItem(
      id: service.id,
      name: service.name,
      description: service.description,
      price: service.basePrice,
      imageUrl: service.imageUrl,
      isActive: !service.isArchived,
      isArchived: service.isArchived,
      createdAt: service.createdAt,
      type: ListingType.service,
      service: service,
    );
  }

  factory VendorListingItem.fromCar(VendorCar car) {
    return VendorListingItem(
      id: car.id,
      name: '${car.make} ${car.model} ${car.year}',
      description: car.conditionStatus,
      price: car.askingPrice?.toString(),
      imageUrl: car.images.isNotEmpty ? car.images.first : null,
      isActive: car.isActive,
      isArchived: !car.isActive,
      createdAt: car.createdAt,
      type: ListingType.car,
      car: car,
    );
  }
}
