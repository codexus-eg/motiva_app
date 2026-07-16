import 'package:app/features/upload/domain/entities/entities.dart';

class PresignedUrlModel extends PresignedUpload {
  const PresignedUrlModel({
    required super.uploadUrl,
    required super.fileKey,
    required super.publicUrl,
    required super.expiresIn,
  });

  factory PresignedUrlModel.fromJson(Map<String, dynamic> json) {
    return PresignedUrlModel(
      uploadUrl: json['uploadUrl'] as String,
      fileKey: json['fileKey'] as String,
      publicUrl: json['publicUrl'] as String,
      expiresIn: json['expiresIn'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uploadUrl': uploadUrl,
      'fileKey': fileKey,
      'publicUrl': publicUrl,
      'expiresIn': expiresIn,
    };
  }
}
