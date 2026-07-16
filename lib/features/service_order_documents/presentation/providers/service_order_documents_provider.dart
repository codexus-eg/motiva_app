import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/service_order_document.dart';
import '../../data/datasources/service_order_documents_remote_data_source.dart';

final serviceOrderDocumentsProvider =
    FutureProvider.family<List<ServiceOrderDocument>, String>((ref, orderId) async {
  final dioClient = ref.watch(dioClientProvider);
  final dataSource = ServiceOrderDocumentsRemoteDataSource(dioClient);
  return dataSource.getDocuments(orderId);
});