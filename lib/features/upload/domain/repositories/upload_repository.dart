import 'package:app/features/upload/domain/entities/entities.dart';

abstract class UploadRepository {
  Future<PresignedUpload> getPresignedUrl({
    required String filename,
    required String mimeType,
    required String folder,
    required int fileSize,
  });

  Future<String> uploadFile(String uploadUrl, List<int> bytes, String mimeType);

  Future<String> uploadImageWithPresignedUrl({
    required String filename,
    required String mimeType,
    required String folder,
    required int fileSize,
    required List<int> bytes,
  });
}
