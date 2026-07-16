
import 'package:app/core/network/dio_client.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class UploadResult {
  final String url;
  final String fileKey;

  const UploadResult({required this.url, required this.fileKey});
}

class UploadService {
  final DioClient _dioClient;
  final ImagePicker _picker = ImagePicker();

  UploadService(this._dioClient);

  Future<XFile?> pickImage({ImageSource source = ImageSource.gallery}) async {
    final XFile? xFile = await _picker.pickImage(
      source: source,
      maxWidth: 1200,
      maxHeight: 1200,
      imageQuality: 85,
    );
    return xFile;
  }

  Future<UploadResult?> uploadFile(
    XFile xFile, {
    String folder = 'profiles',
    String? customFilename,
  }) async {
    try {
      final filename = customFilename ?? _generateFilename(xFile);
      final mimeType =
          xFile.mimeType ?? lookupMimeType(xFile.name) ?? 'image/jpeg';
      final bytes = await xFile.readAsBytes();
      final fileSize = bytes.length;

      AppLogger.debug('Getting presigned URL for $filename...');

      final presignResponse = await _dioClient.dio.post(
        '/api/upload/presign',
        data: {
          'filename': filename,
          'mimeType': mimeType,
          'folder': folder,
          'fileSize': fileSize,
        },
      );

      final presignData = presignResponse.data;
      final uploadUrl = presignData['uploadUrl'] as String;
      final fileKey = presignData['fileKey'] as String;

      AppLogger.debug('Uploading file to: $uploadUrl');
      AppLogger.debug('MIME type: $mimeType, size: $fileSize bytes');

      final uploadDio = Dio();
      final uploadResponse = await uploadDio.put(
        uploadUrl,
        data: bytes,
        options: Options(
          headers: {'Content-Type': mimeType},
          validateStatus: (_) => true,
        ),
      );

      AppLogger.debug('Upload response status: ${uploadResponse.statusCode}');
      if (uploadResponse.statusCode != null &&
          (uploadResponse.statusCode! < 200 ||
              uploadResponse.statusCode! >= 300)) {
        AppLogger.error(
          'Upload returned non-2xx status: ${uploadResponse.statusCode}, body: ${uploadResponse.data}',
        );
        return null;
      }

      AppLogger.debug('Confirming upload...');

      final confirmResponse = await _dioClient.dio.post(
        '/api/upload/confirm',
        data: {'fileKey': fileKey},
      );

      final publicUrl = confirmResponse.data['publicUrl'] as String;

      AppLogger.info('File uploaded successfully: $publicUrl');

      return UploadResult(url: publicUrl, fileKey: fileKey);
    } on DioException catch (e, stackTrace) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.cancel) {
        AppLogger.error(
          'Upload connection error. This is likely a CORS issue when running on web. '
          'The R2/S3 bucket must allow PUT requests from this origin. '
          'URL: ${e.requestOptions.uri}',
          error: e,
          stackTrace: stackTrace,
        );
      } else {
        AppLogger.error(
          'Upload failed - status: ${e.response?.statusCode}, body: ${e.response?.data}',
          error: e,
          stackTrace: stackTrace,
        );
      }
      return null;
    } catch (e, stackTrace) {
      AppLogger.error('Upload failed', error: e, stackTrace: stackTrace);
      return null;
    }
  }

  String _generateFilename(XFile xFile) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = xFile.name.contains('.')
        ? xFile.name.split('.').last
        : 'jpg';
    return 'image_$timestamp.$extension';
  }

  Future<void> deleteFile(String fileKey) async {
    try {
      await _dioClient.dio.delete('/api/upload/$fileKey');
      AppLogger.info('File deleted: $fileKey');
    } catch (e, stackTrace) {
      AppLogger.error('Delete failed', error: e, stackTrace: stackTrace);
    }
  }
}

final uploadServiceProvider = Provider<UploadService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return UploadService(dioClient);
});
