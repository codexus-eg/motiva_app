class UploadException implements Exception {
  final String message;
  UploadException(this.message);

  @override
  String toString() => 'UploadException: $message';
}

class PresignedUrlException extends UploadException {
  PresignedUrlException(super.message);
}

class FileUploadException extends UploadException {
  FileUploadException(super.message);
}
