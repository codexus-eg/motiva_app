import 'package:app/core/network/dio_client.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/service_order_document.dart';

class ServiceOrderDocumentsRemoteDataSource {
  final DioClient _dioClient;

  ServiceOrderDocumentsRemoteDataSource(this._dioClient);

  Future<ServiceOrderDocument> uploadDocument({
    required String serviceOrderId,
    required String serviceCategoryId,
    required XFile file,
    String documentType = 'completion',
  }) async {
    final formData = FormData();
    formData.fields.addAll([
      MapEntry('serviceOrderId', serviceOrderId),
      MapEntry('serviceCategoryId', serviceCategoryId),
      MapEntry('documentType', documentType),
      if (file.name.isNotEmpty) MapEntry('originalFilename', file.name),
    ]);
    formData.files.add(
      MapEntry(
        'file',
        MultipartFile.fromFileSync(file.path, filename: file.name),
      ),
    );

    final response = await _dioClient.dio.post(
      '/api/upload/service-order-documents',
      data: formData,
    );
    return ServiceOrderDocument.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  Future<List<ServiceOrderDocument>> getDocuments(String orderId) async {
    final response = await _dioClient.dio.get(
      '/api/service-orders/$orderId/documents',
    );
    return ServiceOrderDocument.fromJsonList(response.data as List<dynamic>);
  }

  Future<void> deleteDocument(String documentId) async {
    await _dioClient.dio.delete('/api/service-order-documents/$documentId');
  }
}