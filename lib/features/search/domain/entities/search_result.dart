import 'package:app/features/public_services/domain/entities/entities.dart';
import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';
import 'package:app/features/sell_your_car/domain/entities/entities.dart';

sealed class SearchResult {
  const SearchResult();
}

class VendorSearchResult extends SearchResult {
  final PublicVendor vendor;
  const VendorSearchResult(this.vendor);
}

class ServiceSearchResult extends SearchResult {
  final PublicVendorService service;
  const ServiceSearchResult(this.service);
}

class ProductSearchResult extends SearchResult {
  final VendorProduct product;
  const ProductSearchResult(this.product);
}

class CarListingSearchResult extends SearchResult {
  final CarListing listing;
  const CarListingSearchResult(this.listing);
}
