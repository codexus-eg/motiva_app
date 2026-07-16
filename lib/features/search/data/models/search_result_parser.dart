import 'package:app/features/public_services/data/models/models.dart';
import 'package:app/features/search/domain/entities/search_result.dart';
import 'package:app/features/sell_your_car/data/models/car_listing_response.dart';
import 'package:app/features/vendor-products/data/models/vendor_product_model.dart';

/// Parses flat API results into typed [SearchResult] list.
class SearchResultParser {
  static List<SearchResult> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) {
      final item = json as Map<String, dynamic>;
      final type = (item['type'] as String).toLowerCase();
      final payload = item['item'] as Map<String, dynamic>;

      switch (type) {
        case 'vendor':
          return VendorSearchResult(PublicVendorModel.fromJson(payload));
        case 'service':
          return ServiceSearchResult(PublicVendorServiceModel.fromJson(payload));
        case 'product':
          return ProductSearchResult(VendorProductModel.fromJson(payload).vendorProduct);
        case 'car_listing':
          return CarListingSearchResult(CarListingResponseModel.fromJson(payload));
        default:
          return VendorSearchResult(PublicVendorModel.fromJson(payload));
      }
    }).toList();
  }
}
