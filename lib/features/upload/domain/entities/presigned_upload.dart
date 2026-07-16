class PresignedUpload {
  final String uploadUrl;
  final String fileKey;
  final String publicUrl;
  final int expiresIn;

  const PresignedUpload({
    required this.uploadUrl,
    required this.fileKey,
    required this.publicUrl,
    required this.expiresIn,
  });
}
