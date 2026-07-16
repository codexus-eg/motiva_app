import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/service-categories/data/models/service_category_model.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';

abstract class ServiceCategoryRemoteDataSource {
  Future<List<ServiceCategory>> getCategories();
}

class ServiceCategoryRemoteDataSourceImpl
    implements ServiceCategoryRemoteDataSource {
  final DioClient _dioClient;

  ServiceCategoryRemoteDataSourceImpl(this._dioClient);

  @override
  Future<List<ServiceCategory>> getCategories() async {
    try {
      final response = await _dioClient.dio.get('/api/service-categories');
      AppLogger.debug('Categories API Response: ${response.data}');
      return ServiceCategoryModel.fromJsonList(response.data as List<dynamic>);
    } catch (e, stackTrace) {
      AppLogger.error('getCategories failed', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}
