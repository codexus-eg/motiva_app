import 'package:app/features/service-categories/data/datasources/service_category_remote_data_source.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:app/features/service-categories/domain/repositories/service_category_repository.dart';

class ServiceCategoryRepositoryImpl implements ServiceCategoryRepository {
  final ServiceCategoryRemoteDataSource _remoteDataSource;

  ServiceCategoryRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<ServiceCategory>> getCategories() async {
    return await _remoteDataSource.getCategories();
  }
}
