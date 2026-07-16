import 'package:app/features/upload/data/datasources/datasources.dart';
import 'package:app/features/upload/domain/entities/entities.dart';
import 'package:app/features/upload/domain/repositories/repositories.dart';

class UploadRepositoryImpl implements UploadRepository {
  final UploadRemoteDataSource _remoteDataSource;

  UploadRepositoryImpl(this._remoteDataSource);

  @override
  Future<PresignedUpload> getPresignedUrl({
    required String filename,
    required String mimeType,
    required String folder,
    required int fileSize,
  }) async {
    return await _remoteDataSource.getPresignedUrl(
      filename: filename,
      mimeType: mimeType,
      folder: folder,
      fileSize: fileSize,
    );
  }

  @override
  Future<String> uploadFile(
    String uploadUrl,
    List<int> bytes,
    String mimeType,
  ) async {
    await _remoteDataSource.uploadFileToUrl(uploadUrl, bytes, mimeType);
    return uploadUrl;
  }

  @override
  Future<String> uploadImageWithPresignedUrl({
    required String filename,
    required String mimeType,
    required String folder,
    required int fileSize,
    required List<int> bytes,
  }) async {
    final presigned = await _remoteDataSource.getPresignedUrl(
      filename: filename,
      mimeType: mimeType,
      folder: folder,
      fileSize: fileSize,
    );

    await _remoteDataSource.uploadFileToUrl(
      presigned.uploadUrl,
      bytes,
      mimeType,
    );

    return presigned.publicUrl;
  }
}
