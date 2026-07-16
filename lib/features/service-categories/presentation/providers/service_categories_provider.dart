import 'package:flutter/foundation.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/service-categories/data/datasources/service_category_remote_data_source.dart';
import 'package:app/features/service-categories/data/repositories/service_category_repository_impl.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:app/features/service-categories/domain/repositories/service_category_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final serviceCategoryRemoteDataSourceProvider =
    Provider<ServiceCategoryRemoteDataSource>((ref) {
      return ServiceCategoryRemoteDataSourceImpl(ref.watch(dioClientProvider));
    });

final serviceCategoryRepositoryProvider = Provider<ServiceCategoryRepository>((
  ref,
) {
  return ServiceCategoryRepositoryImpl(
    ref.watch(serviceCategoryRemoteDataSourceProvider),
  );
});

final serviceCategoriesProvider = FutureProvider<List<ServiceCategory>>((
  ref,
) async {
  try {
    final repository = ref.watch(serviceCategoryRepositoryProvider);
    final categories = await repository.getCategories();
    return categories;
  } catch (e, stackTrace) {
    debugPrint('═══════════════════════════════════════');
    debugPrint('serviceCategoriesProvider ERROR: $e');
    debugPrint('Type: ${e.runtimeType}');
    debugPrint('StackTrace: $stackTrace');
    debugPrint('═══════════════════════════════════════');
    rethrow;
  }
});
