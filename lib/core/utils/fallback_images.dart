import 'constants.dart';

class FallbackImages {
  FallbackImages._();

  // Service categories - icons
  static const String categoryIconRoadAssistance =
      'assets/icons/home/road_assistance.png';
  static const String categoryIconCarCrane = 'assets/icons/home/car_crane.png';
  static const String categoryIconCarWash = 'assets/icons/home/car_wash.png';
  static const String categoryIconDefault = 'assets/icons/home/wheel.png';

  // Service categories - cover/banner images
  static const String categoryCoverRoadAssistance =
      'assets/images/services_road_assistance.png';
  static const String categoryCoverCarCrane =
      'assets/images/services_car_crane.png';
  static const String categoryCoverDefault =
      'assets/images/services_fix_car.png';

  // Vendor services
  static const String serviceDefault = 'assets/images/services_fix_car.png';
  static const String serviceRoadAssistance =
      'assets/images/services_road_assistance.png';
  static const String serviceCarCrane = 'assets/images/services_car_crane.png';
  static const String serviceFuel = 'assets/images/services_fuel.png';
  static const String serviceAccessories = 'assets/images/services_accessories.png';

  // Vendor
  static const String vendorLogo = 'assets/icons/prime_car_logo.png';
  static const String vendorCoverDefault =
      'assets/images/services_road_assistance.png';

  // Listing thumbs
  static const String listingThumb1 = 'assets/images/listing_thumb_1.png';
  static const String listingThumb2 = 'assets/images/listing_thumb_2.png';

  static String categoryIcon(String? slug) {
    switch (slug) {
      case 'car-road-assistance':
        return categoryIconRoadAssistance;
      case 'car-crane':
        return categoryIconCarCrane;
      case 'car-wash':
        return categoryIconCarWash;
      default:
        return categoryIconDefault;
    }
  }

  static String categoryCover(String? slug) {
    switch (slug) {
      case 'car-road-assistance':
        return categoryCoverRoadAssistance;
      case 'car-crane':
        return categoryCoverCarCrane;
      default:
        return categoryCoverDefault;
    }
  }

  static String serviceImage(String? imageUrl) {
    if (imageUrl != null && imageUrl.isNotEmpty) {
      return imageUrl;
    }
    return serviceDefault;
  }

  static String vendorImage(String? logoUrl) {
    if (logoUrl != null && logoUrl.isNotEmpty) {
      return logoUrl;
    }
    return vendorLogo;
  }

  static String resolveUrl(String? url) {
    if (url == null || url.isEmpty) {
      return '';
    }
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    final baseUrl = ApiConstants.baseUrl;
    final normalizedPath = url.startsWith('/') ? url : '/$url';
    return '$baseUrl$normalizedPath';
  }

  static bool isValidUrl(String? url) {
    if (url == null || url.isEmpty) {
      return false;
    }
    return url.startsWith('http://') ||
        url.startsWith('https://') ||
        url.startsWith('/');
  }
}
