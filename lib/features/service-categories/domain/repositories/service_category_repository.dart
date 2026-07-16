import 'package:app/features/service-categories/domain/entities/service_category.dart';

abstract class ServiceCategoryRepository {
  Future<List<ServiceCategory>> getCategories();
}
