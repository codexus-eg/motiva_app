import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryWithSchemaProvider =
    FutureProvider.family<ServiceCategoryWithSchema?, String>((
  ref,
  categoryId,
) async {
  if (categoryId.isEmpty) return null;
  try {
    final dioClient = ref.watch(dioClientProvider);
    final response = await dioClient.dio.get(
      '/api/service-categories/$categoryId',
    );
    return ServiceCategoryWithSchema.fromJson(response.data);
  } catch (e, stackTrace) {
    AppLogger.error(
      'categoryWithSchemaProvider failed',
      error: e,
      stackTrace: stackTrace,
    );
    rethrow;
  }
});