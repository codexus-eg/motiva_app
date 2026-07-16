import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/upload/data/data.dart';
import 'package:app/features/upload/domain/domain.dart';

class UploadState {
  final bool isLoading;
  final String? error;
  final List<String> uploadedUrls;
  final double uploadProgress;

  const UploadState({
    this.isLoading = false,
    this.error,
    this.uploadedUrls = const [],
    this.uploadProgress = 0.0,
  });

  UploadState copyWith({
    bool? isLoading,
    String? error,
    List<String>? uploadedUrls,
    double? uploadProgress,
  }) {
    return UploadState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      uploadedUrls: uploadedUrls ?? this.uploadedUrls,
      uploadProgress: uploadProgress ?? this.uploadProgress,
    );
  }
}

class UploadNotifier extends StateNotifier<UploadState> {
  final UploadRepository _repository;

  UploadNotifier(this._repository) : super(const UploadState());

  Future<String?> uploadImage(
    Uint8List bytes,
    String filename,
    String mimeType, {
    String folder = 'listings',
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final publicUrl = await _repository.uploadImageWithPresignedUrl(
        filename: filename,
        mimeType: mimeType,
        folder: folder,
        fileSize: bytes.length,
        bytes: bytes,
      );

      state = state.copyWith(
        isLoading: false,
        uploadedUrls: [...state.uploadedUrls, publicUrl],
      );

      return publicUrl;
    } catch (e, stackTrace) {
      AppLogger.error('uploadImage failed', error: e, stackTrace: stackTrace);
      state = state.copyWith(isLoading: false, error: e.toString());
      return null;
    }
  }

  Future<List<String>> uploadImages(
    List<({Uint8List bytes, String filename, String mimeType})> images,
  ) async {
    final urls = <String>[];
    state = state.copyWith(isLoading: true, error: null);

    for (var i = 0; i < images.length; i++) {
      final image = images[i];
      final url = await uploadImage(
        image.bytes,
        image.filename,
        image.mimeType,
      );
      if (url != null) {
        urls.add(url);
      }
      state = state.copyWith(uploadProgress: (i + 1) / images.length);
    }

    state = state.copyWith(isLoading: false);
    return urls;
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void reset() {
    state = const UploadState();
  }
}

final uploadRepositoryProvider = Provider<UploadRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  final remoteDataSource = UploadRemoteDataSourceImpl(dioClient);
  return UploadRepositoryImpl(remoteDataSource);
});

final uploadNotifierProvider =
    StateNotifierProvider<UploadNotifier, UploadState>((ref) {
      final repository = ref.watch(uploadRepositoryProvider);
      return UploadNotifier(repository);
    });
