import 'dart:io';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/upload/presentation/providers/upload_provider.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gap/gap.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/core/utils/error_display.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class ImagesGCTab extends ConsumerStatefulWidget {
  final VoidCallback onContinue;
  final void Function(List<String> imageUrls) onImagesUploaded;

  const ImagesGCTab({
    super.key,
    required this.onContinue,
    required this.onImagesUploaded,
  });

  @override
  ConsumerState<ImagesGCTab> createState() => _ImagesGCTabState();
}

class _ImagesGCTabState extends ConsumerState<ImagesGCTab> {
  final ImagePicker _picker = ImagePicker();
  final List<File> _selectedImages = [];
  bool _isUploading = false;

  Future<void> _pickImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (images.isNotEmpty) {
        setState(() {
          _selectedImages.addAll(images.map((xFile) => File(xFile.path)));
        });
      }
    } catch (e, stackTrace) {
      AppLogger.error('_pickImages failed', error: e, stackTrace: stackTrace);
      if (mounted) {
        ErrorDisplay.showSnackBar(context, e, stackTrace: stackTrace);
      }
    }
  }

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (photo != null) {
        setState(() {
          _selectedImages.add(File(photo.path));
        });
      }
    } catch (e, stackTrace) {
      AppLogger.error('_takePhoto failed', error: e, stackTrace: stackTrace);
      if (mounted) {
        ErrorDisplay.showSnackBar(context, e, stackTrace: stackTrace);
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  Future<void> _onContinue() async {
    AppLogger.debug('=== ImagesGCTab _onContinue called ===');
    AppLogger.debug('Selected images count: ${_selectedImages.length}');

    if (_selectedImages.isEmpty) {
      AppLogger.debug(
        'No images selected, calling onImagesUploaded with empty list',
      );
      widget.onImagesUploaded([]);
      widget.onContinue();
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final uploadNotifier = ref.read(uploadNotifierProvider.notifier);
      final uploadedUrls = <String>[];

      for (final imageFile in _selectedImages) {
        final bytes = await imageFile.readAsBytes();
        final filename = 'car_${DateTime.now().millisecondsSinceEpoch}.jpg';
        AppLogger.debug('Uploading image: $filename (${bytes.length} bytes)');
        final url = await uploadNotifier.uploadImage(
          bytes,
          filename,
          'image/jpeg',
        );
        if (url != null) {
          AppLogger.debug('Uploaded successfully: $url');
          uploadedUrls.add(url);
        } else {
          AppLogger.debug('Upload returned null for $filename');
        }
      }

      AppLogger.debug('Total uploaded URLs: ${uploadedUrls.length}');
      AppLogger.debug('Calling onImagesUploaded with: $uploadedUrls');
      widget.onImagesUploaded(uploadedUrls);
      widget.onContinue();
    } catch (e, stackTrace) {
      AppLogger.error('_onContinue failed', error: e, stackTrace: stackTrace);
      if (mounted) {
        ErrorDisplay.showSnackBar(context, e, stackTrace: stackTrace);
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final uploadState = ref.watch(uploadNotifierProvider);
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translations.of(context).sell_your_car.images_tab.car_images_title,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            Translations.of(context).sell_your_car.images_tab.car_images_hint,
            style: TextStyle(color: Color(0xFF9C9C9C), fontSize: 14),
          ),
          const Gap(AppSpacing.lg),
          _buildImageGrid(),
          const Gap(AppSpacing.lg),
          _buildActionButtons(),
          const Gap(AppSpacing.xl),
          if (_isUploading || uploadState.isLoading)
            Center(
              child: Column(
                children: [
                  ShimmerSkeletons.cardSkeleton(),
                  Gap(AppSpacing.md),
                  Text(
                    Translations.of(context).sell_your_car.images_tab.uploading,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            )
          else
            GradientButton(
              text: _selectedImages.isEmpty
                  ? Translations.of(context).sell_your_car.images_tab.skip
                  : Translations.of(context).sell_your_car.images_tab.kContinue,
              onTap: _onContinue,
            ),
          const Gap(AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: _selectedImages.length + 1,
      itemBuilder: (context, index) {
        if (index == _selectedImages.length) {
          return _buildAddImageButton();
        }
        return _buildImageItem(index);
      },
    );
  }

  Widget _buildAddImageButton() {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => _showImageSourceDialog(),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color(0xFFDC8735).withValues(alpha: 0.5),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add_photo_alternate_outlined,
              color: Color(0xFFDC8735),
              size: 32,
            ),
            Gap(AppSpacing.sm),
            Text(
              Translations.of(context).sell_your_car.images_tab.add_photo,
              style: TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageItem(int index) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: FileImage(_selectedImages[index]),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => _removeImage(index),
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.close,
                color: theme.colorScheme.onSurface,
                size: 16,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
            ),
            child: Text(
              Translations.of(context).sell_your_car.images_tab.image_label
                  .replaceAll('{number}', '${index + 1}'),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 10,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _takePhoto,
            icon: const Icon(Icons.camera_alt, color: Color(0xFFDC8735)),
            label: Text(
              Translations.of(context).sell_your_car.images_tab.camera,
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFDC8735)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const Gap(AppSpacing.md),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _pickImages,
            icon: const Icon(Icons.photo_library, color: Color(0xFFDC8735)),
            label: Text(
              Translations.of(context).sell_your_car.images_tab.gallery,
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Color(0xFFDC8735)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void _showImageSourceDialog() {
    final theme = Theme.of(context);
    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.primaryContainer,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                Translations.of(context).sell_your_car.images_tab.select_source,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(AppSpacing.lg),
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Color(0xFFDC8735)),
                title: Text(
                  Translations.of(context).sell_your_car.images_tab.camera,
                  style: TextStyle(color: theme.colorScheme.onSurface),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _takePhoto();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.photo_library,
                  color: Color(0xFFDC8735),
                ),
                title: Text(
                  Translations.of(context).sell_your_car.images_tab.gallery,
                  style: TextStyle(color: theme.colorScheme.onSurface),
                ),
                onTap: () {
                  Navigator.pop(context);
                  _pickImages();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
