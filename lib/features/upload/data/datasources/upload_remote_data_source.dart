import 'package:dio/dio.dart';
import 'package:app/core/network/dio_client.dart';
import 'package:app/features/upload/data/models/models.dart';
import 'package:app/features/upload/data/exceptions/exceptions.dart';
import 'package:app/core/utils/app_logger.dart';

abstract class UploadRemoteDataSource {
  Future<PresignedUrlModel> getPresignedUrl({
    required String filename,
    required String mimeType,
    required String folder,
    required int fileSize,
  });

  Future<void> uploadFileToUrl(
    String uploadUrl,
    List<int> bytes,
    String mimeType,
  );
}

class UploadRemoteDataSourceImpl implements UploadRemoteDataSource {
  final DioClient _dioClient;
  final Dio _rawDio;

  UploadRemoteDataSourceImpl(this._dioClient) : _rawDio = Dio();

  @override
  Future<PresignedUrlModel> getPresignedUrl({
    required String filename,
    required String mimeType,
    required String folder,
    required int fileSize,
  }) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/upload/presign',
        data: {
          'filename': filename,
          'mimeType': mimeType,
          'folder': folder,
          'fileSize': fileSize,
        },
      );
      AppLogger.debug('Presign API response: ${response.data}');
      final model = PresignedUrlModel.fromJson(response.data);
      AppLogger.debug('Parsed - uploadUrl: ${model.uploadUrl}');
      AppLogger.debug('Parsed - publicUrl: ${model.publicUrl}');
      AppLogger.debug('Parsed - fileKey: ${model.fileKey}');
      return model;
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getPresignedUrl failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw PresignedUrlException(
        e.response?.data?['message'] ?? 'Failed to get presigned URL',
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'getPresignedUrl failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw PresignedUrlException(e.toString());
    }
  }

  @override
  Future<void> uploadFileToUrl(
    String uploadUrl,
    List<int> bytes,
    String mimeType,
  ) async {
    try {
      await _rawDio.put(
        uploadUrl,
        data: Stream.fromIterable(bytes.map((b) => [b])),
        options: Options(
          headers: {'Content-Type': mimeType, 'Content-Length': bytes.length},
        ),
      );
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'uploadFileToUrl failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw FileUploadException(
        e.response?.data?['message'] ?? 'Failed to upload file',
      );
    } catch (e, stackTrace) {
      AppLogger.error(
        'uploadFileToUrl failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw FileUploadException(e.toString());
    }
  }
}
