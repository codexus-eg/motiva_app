import 'package:app/features/public_services/domain/entities/entities.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';

abstract class PublicServicesRepository {
  Future<List<ServiceCategory>> getServiceCategories();
  Future<ServiceCategoryWithSchema> getCategoryDetails(String categoryId);
  Future<List<PublicVendor>> getVendorsByCategory(String categoryId);
  Future<PublicVendor> getVendorProfile(String vendorId);
  Future<List<PublicVendorService>> getVendorServices({
    String? categoryId,
    String? vendorId,
  });
  Future<PublicVendorService> getServiceDetails(String serviceId);
}
