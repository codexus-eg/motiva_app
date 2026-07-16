import 'dart:io';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/core/utils/error_display.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/upload/presentation/providers/upload_provider.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class ImagesDCTab extends ConsumerStatefulWidget {
  final VoidCallback onContinue;
  final void Function(List<String> imageUrls) onImagesUploaded;
  final void Function(List<String> damageImageUrls) onDamageImagesUploaded;

  const ImagesDCTab({
    super.key,
    required this.onContinue,
    required this.onImagesUploaded,
    required this.onDamageImagesUploaded,
  });

  @override
  ConsumerState<ImagesDCTab> createState() => _ImagesDCTabState();
}

class _ImagesDCTabState extends ConsumerState<ImagesDCTab> {
  final ImagePicker _picker = ImagePicker();
  final List<File> _selectedCarImages = [];
  final List<File> _selectedDamageImages = [];
  bool _isUploading = false;

  Future<void> _pickCarImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (images.isNotEmpty) {
        setState(() {
          _selectedCarImages.addAll(images.map((xFile) => File(xFile.path)));
        });
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        '_pickCarImages failed',
        error: e,
        stackTrace: stackTrace,
      );
      if (mounted) {
        ErrorDisplay.showSnackBar(context, e, stackTrace: stackTrace);
      }
    }
  }

  Future<void> _takeCarPhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (photo != null) {
        setState(() {
          _selectedCarImages.add(File(photo.path));
        });
      }
    } catch (e, stackTrace) {
      AppLogger.error('_takeCarPhoto failed', error: e, stackTrace: stackTrace);
      if (mounted) {
        ErrorDisplay.showSnackBar(context, e, stackTrace: stackTrace);
      }
    }
  }

  void _removeCarImage(int index) {
    setState(() {
      _selectedCarImages.removeAt(index);
    });
  }

  Future<void> _pickDamageImages() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage(
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (images.isNotEmpty) {
        setState(() {
          _selectedDamageImages.addAll(images.map((xFile) => File(xFile.path)));
        });
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        '_pickDamageImages failed',
        error: e,
        stackTrace: stackTrace,
      );
      if (mounted) {
        ErrorDisplay.showSnackBar(context, e, stackTrace: stackTrace);
      }
    }
  }

  Future<void> _takeDamagePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
        maxWidth: 1920,
        maxHeight: 1080,
      );

      if (photo != null) {
        setState(() {
          _selectedDamageImages.add(File(photo.path));
        });
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        '_takeDamagePhoto failed',
        error: e,
        stackTrace: stackTrace,
      );
      if (mounted) {
        ErrorDisplay.showSnackBar(context, e, stackTrace: stackTrace);
      }
    }
  }

  void _removeDamageImage(int index) {
    setState(() {
      _selectedDamageImages.removeAt(index);
    });
  }

  Future<void> _onContinue() async {
    if (_selectedCarImages.isEmpty && _selectedDamageImages.isEmpty) {
      widget.onImagesUploaded([]);
      widget.onDamageImagesUploaded([]);
      widget.onContinue();
      return;
    }

    setState(() {
      _isUploading = true;
    });

    try {
      final uploadNotifier = ref.read(uploadNotifierProvider.notifier);
      final List<String> uploadedCarUrls = [];
      final List<String> uploadedDamageUrls = [];

      for (final imageFile in _selectedCarImages) {
        final bytes = await imageFile.readAsBytes();
        final filename = 'car_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final url = await uploadNotifier.uploadImage(
          bytes,
          filename,
          'image/jpeg',
        );
        if (url != null) {
          uploadedCarUrls.add(url);
        }
      }

      for (final imageFile in _selectedDamageImages) {
        final bytes = await imageFile.readAsBytes();
        final filename = 'damage_${DateTime.now().millisecondsSinceEpoch}.jpg';
        final url = await uploadNotifier.uploadImage(
          bytes,
          filename,
          'image/jpeg',
        );
        if (url != null) {
          uploadedDamageUrls.add(url);
        }
      }

      widget.onImagesUploaded(uploadedCarUrls);
      widget.onDamageImagesUploaded(uploadedDamageUrls);
      widget.onContinue();
    } catch (e, stackTrace) {
      AppLogger.error(
        '_onContinue upload failed',
        error: e,
        stackTrace: stackTrace,
      );
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
          _buildCarImagesSection(),
          const Gap(AppSpacing.xl),
          _buildDamageImagesSection(),
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
              text: _selectedCarImages.isEmpty && _selectedDamageImages.isEmpty
                  ? Translations.of(context).sell_your_car.images_tab.skip
                  : Translations.of(context).sell_your_car.images_tab.kContinue,
              onTap: _onContinue,
            ),
          const Gap(AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildCarImagesSection() {
    final theme = Theme.of(context);
    return Column(
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
        const Gap(AppSpacing.md),
        _buildCarImageGrid(),
        const Gap(AppSpacing.md),
        _buildCarActionButtons(),
      ],
    );
  }

  Widget _buildCarImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: _selectedCarImages.length + 1,
      itemBuilder: (context, index) {
        if (index == _selectedCarImages.length) {
          return _buildAddImageButton(() => _showCarImageSourceDialog());
        }
        return _buildImageItem(
          index,
          _selectedCarImages,
          _removeCarImage,
          Translations.of(context).sell_your_car.images_tab.car_label,
        );
      },
    );
  }

  Widget _buildCarActionButtons() {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _takeCarPhoto,
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
            onPressed: _pickCarImages,
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

  Widget _buildDamageImagesSection() {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Translations.of(context).sell_your_car.images_tab.damage_images_title,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Gap(AppSpacing.sm),
        Text(
          Translations.of(context).sell_your_car.images_tab.damage_images_hint,
          style: TextStyle(color: Color(0xFF9C9C9C), fontSize: 14),
        ),
        const Gap(AppSpacing.md),
        _buildDamageImageGrid(),
        const Gap(AppSpacing.md),
        _buildDamageActionButtons(),
      ],
    );
  }

  Widget _buildDamageImageGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      ),
      itemCount: _selectedDamageImages.length + 1,
      itemBuilder: (context, index) {
        if (index == _selectedDamageImages.length) {
          return _buildAddImageButton(() => _showDamageImageSourceDialog());
        }
        return _buildImageItem(
          index,
          _selectedDamageImages,
          _removeDamageImage,
          Translations.of(context).sell_your_car.images_tab.damage_label,
        );
      },
    );
  }

  Widget _buildDamageActionButtons() {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _takeDamagePhoto,
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
            onPressed: _pickDamageImages,
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

  Widget _buildAddImageButton(VoidCallback onTap) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
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

  Widget _buildImageItem(
    int index,
    List<File> images,
    void Function(int) onRemove,
    String label,
  ) {
    final theme = Theme.of(context);
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: FileImage(images[index]),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => onRemove(index),
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
              '$label ${index + 1}',
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

  void _showCarImageSourceDialog() {
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
                  _takeCarPhoto();
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
                  _pickCarImages();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDamageImageSourceDialog() {
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
                  _takeDamagePhoto();
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
                  _pickDamageImages();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
