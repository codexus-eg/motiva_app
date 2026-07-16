import 'dart:typed_data';

import 'package:app/core/providers/upload_provider.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/core/theme/spacing.dart';

class ImageUploadCard extends ConsumerStatefulWidget {
  final String? currentImageUrl;
  final String fallbackAsset;
  final String folder;
  final String title;
  final double width;
  final double height;
  final Function(String)? onUploadComplete;
  final bool isNetworkImage;

  const ImageUploadCard({
    super.key,
    this.currentImageUrl,
    required this.fallbackAsset,
    required this.folder,
    this.title = 'Upload Image',
    this.width = 137,
    this.height = 137,
    this.onUploadComplete,
    this.isNetworkImage = false,
  });

  @override
  ConsumerState<ImageUploadCard> createState() => _ImageUploadCardState();
}

class _ImageUploadCardState extends ConsumerState<ImageUploadCard> {
  bool _isUploading = false;
  String? _uploadedUrl;
  Uint8List? _selectedBytes;

  Future<void> _pickAndUpload() async {
    final uploadService = ref.read(uploadServiceProvider);

    final xFile = await uploadService.pickImage(source: ImageSource.gallery);
    if (xFile == null) return;

    final bytes = await xFile.readAsBytes();

    setState(() {
      _isUploading = true;
      _selectedBytes = bytes;
    });

    final result = await uploadService.uploadFile(xFile, folder: widget.folder);

    if (result != null) {
      setState(() {
        _uploadedUrl = result.url;
      });
      widget.onUploadComplete?.call(result.url);
    }

    setState(() {
      _isUploading = false;
    });
  }

  ImageProvider _getImageProvider() {
    if (_uploadedUrl != null) {
      return NetworkImage(_uploadedUrl!);
    }
    if (_selectedBytes != null) {
      return MemoryImage(_selectedBytes!);
    }
    if (widget.isNetworkImage &&
        widget.currentImageUrl != null &&
        widget.currentImageUrl!.isNotEmpty) {
      return NetworkImage(widget.currentImageUrl!);
    }
    return AssetImage(widget.fallbackAsset);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.6),
          ),
          alignment: Alignment.center,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image(
                  image: _getImageProvider(),
                  fit: BoxFit.cover,
                  width: widget.width - 8,
                  height: widget.height - 8,
                  errorBuilder: (_, _, _) => Image.asset(
                    widget.fallbackAsset,
                    fit: BoxFit.cover,
                    width: widget.width - 8,
                    height: widget.height - 8,
                  ),
                ),
              ),
              if (_isUploading)
                Container(
                  width: widget.width - 8,
                  height: widget.height - 8,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                ),
            ],
          ),
        ),
        const Gap(AppSpacing.md),
        ElevatedButton.icon(
          onPressed: _isUploading ? null : _pickAndUpload,
          icon: const Icon(Icons.upload, size: 16),
          label: Text(
            _isUploading ? 'Uploading...' : 'Change',
            style: GoogleFonts.poppins(fontSize: 12),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
