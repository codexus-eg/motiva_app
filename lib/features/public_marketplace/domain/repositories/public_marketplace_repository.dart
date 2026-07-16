import 'package:app/features/public_services/domain/entities/entities.dart';
import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class PublicMarketplaceRepository {
  Future<VendorProduct> getProduct(String id);
  Future<List<PublicVendor>> getVendorsByProductType(String? productType);
  Future<List<VendorProduct>> getVendorProducts(
    String vendorId, {
    PublicProductFilter? filter,
  });
}

class PublicProductFilter {
  final String? make;
  final String? model;
  final int? yearFrom;
  final int? yearTo;
  final String? brand;
  final String? partNumber;
  final double? minPrice;
  final double? maxPrice;

  const PublicProductFilter({
    this.make,
    this.model,
    this.yearFrom,
    this.yearTo,
    this.brand,
    this.partNumber,
    this.minPrice,
    this.maxPrice,
  });

  bool get isEmpty =>
      make == null &&
      model == null &&
      yearFrom == null &&
      yearTo == null &&
      brand == null &&
      partNumber == null &&
      minPrice == null &&
      maxPrice == null;

  PublicProductFilter copyWith({
    String? make,
    String? model,
    int? yearFrom,
    int? yearTo,
    String? brand,
    String? partNumber,
    double? minPrice,
    double? maxPrice,
  }) {
    return PublicProductFilter(
      make: make ?? this.make,
      model: model ?? this.model,
      yearFrom: yearFrom ?? this.yearFrom,
      yearTo: yearTo ?? this.yearTo,
      brand: brand ?? this.brand,
      partNumber: partNumber ?? this.partNumber,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  PublicProductFilter clear() => const PublicProductFilter();

  Map<String, dynamic> toQueryParams() {
    final params = <String, dynamic>{};
    if (make != null && make!.isNotEmpty) params['make'] = make;
    if (model != null && model!.isNotEmpty) params['model'] = model;
    if (yearFrom != null) params['yearFrom'] = yearFrom;
    if (yearTo != null) params['yearTo'] = yearTo;
    if (brand != null && brand!.isNotEmpty) params['brand'] = brand;
    if (partNumber != null && partNumber!.isNotEmpty) {
      params['partNumber'] = partNumber;
    }
    if (minPrice != null) params['minPrice'] = minPrice;
    if (maxPrice != null) params['maxPrice'] = maxPrice;
    return params;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PublicProductFilter &&
        other.make == make &&
        other.model == model &&
        other.yearFrom == yearFrom &&
        other.yearTo == yearTo &&
        other.brand == brand &&
        other.partNumber == partNumber &&
        other.minPrice == minPrice &&
        other.maxPrice == maxPrice;
  }

  @override
  int get hashCode => Object.hash(
        make,
        model,
        yearFrom,
        yearTo,
        brand,
        partNumber,
        minPrice,
        maxPrice,
      );

  @override
  String toString() =>
      'PublicProductFilter(make: $make, model: $model, yearFrom: $yearFrom, yearTo: $yearTo, brand: $brand, partNumber: $partNumber, minPrice: $minPrice, maxPrice: $maxPrice)';
}

class PublicProductFilterNotifier extends StateNotifier<PublicProductFilter> {
  PublicProductFilterNotifier() : super(const PublicProductFilter());

  void set(PublicProductFilter filter) => state = filter;
  void clear() => state = const PublicProductFilter();
}

final publicProductFilterProvider =
    StateNotifierProvider<PublicProductFilterNotifier, PublicProductFilter>(
      (ref) => PublicProductFilterNotifier(),
    );
