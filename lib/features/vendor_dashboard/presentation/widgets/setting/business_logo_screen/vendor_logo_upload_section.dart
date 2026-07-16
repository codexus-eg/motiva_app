import 'dart:typed_data';

import 'package:app/core/providers/upload_provider.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/utils/fallback_images.dart';
import 'package:app/features/vendor/presentation/providers/vendor_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/core/theme/spacing.dart';

class VendorLogoAndUploadSection extends ConsumerStatefulWidget {
  const VendorLogoAndUploadSection({super.key});

  @override
  ConsumerState<VendorLogoAndUploadSection> createState() =>
      _VendorLogoAndUploadSectionState();
}

class _VendorLogoAndUploadSectionState
    extends ConsumerState<VendorLogoAndUploadSection> {
  bool _isUploading = false;
  String? _uploadedUrl;
  XFile? _selectedFile;

  Future<void> _pickAndUpload() async {
    final uploadService = ref.read(uploadServiceProvider);

    final file = await uploadService.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    setState(() {
      _isUploading = true;
      _selectedFile = file;
    });

    final result = await uploadService.uploadFile(file, folder: 'profiles');

    if (result != null) {
      final success = await ref
          .read(vendorProfileProvider.notifier)
          .updateLogo(result.url);
      if (success) {
        setState(() {
          _uploadedUrl = result.url;
        });
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(t.vendor_dashboard.business_logo.logo_updated),
              backgroundColor: Colors.green,
            ),
          );
        }
      }
    }

    setState(() {
      _isUploading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileState = ref.watch(vendorProfileProvider);
    final logoUrl = _uploadedUrl ?? profileState.valueOrNull?.logoUrl;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CurrentLogoCard(
          logoUrl: logoUrl,
          isUploading: _isUploading,
          selectedFile: _selectedFile,
        ),
        const Gap(AppSpacing.lg),
        Expanded(child: _UploadCard(onTap: _pickAndUpload)),
      ],
    );
  }
}

class _CurrentLogoCard extends StatelessWidget {
  final String? logoUrl;
  final bool isUploading;
  final XFile? selectedFile;

  const _CurrentLogoCard({
    required this.logoUrl,
    required this.isUploading,
    this.selectedFile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 137,
      height: 137,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.6),
      ),
      alignment: Alignment.center,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: _buildImage(),
          ),
          if (isUploading)
            Container(
              width: 108,
              height: 108,
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    if (selectedFile != null) {
      return FutureBuilder<Uint8List>(
        future: selectedFile!.readAsBytes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Image.memory(
              snapshot.data!,
              fit: BoxFit.cover,
              width: 108,
              height: 108,
            );
          }
          return Container(
            width: 108,
            height: 108,
            color: Colors.grey.shade200,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      );
    }
    if (logoUrl != null && logoUrl!.isNotEmpty) {
      return Image.network(
        logoUrl!,
        fit: BoxFit.cover,
        width: 108,
        height: 108,
        errorBuilder: (_, _, _) => Image.asset(
          FallbackImages.vendorLogo,
          fit: BoxFit.contain,
          width: 108,
          height: 108,
        ),
      );
    }
    return Image.asset(
      FallbackImages.vendorLogo,
      fit: BoxFit.contain,
      width: 108,
      height: 108,
    );
  }
}

class _UploadCard extends StatelessWidget {
  final VoidCallback onTap;

  const _UploadCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return _DashedBorder(
      color: const Color(0xFFDC8735),
      borderRadius: 12,
      dashLength: 10,
      gapLength: 6,
      strokeWidth: 1.4,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 137,
          decoration: BoxDecoration(
            color: theme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                color: theme.onSurface,
                size: 36,
              ),
              const Gap(AppSpacing.md),
              RichText(
                text: TextSpan(
                  text: t.vendor_dashboard.documents.browse,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFDC8735),
                  ),
                  children: [
                    TextSpan(
                      text: t.vendor_dashboard.documents.your_file,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: theme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(AppSpacing.sm),
              Text(
                t.vendor_dashboard.documents.max_size,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedBorder extends StatelessWidget {
  const _DashedBorder({
    required this.child,
    required this.color,
    required this.borderRadius,
    this.dashLength = 6,
    this.gapLength = 4,
    this.strokeWidth = 1,
  });

  final Widget child;
  final Color color;
  final double borderRadius;
  final double dashLength;
  final double gapLength;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: _DashedRectPainter(
        color: color,
        borderRadius: borderRadius,
        dashLength: dashLength,
        gapLength: gapLength,
        strokeWidth: strokeWidth,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: child,
      ),
    );
  }
}

class _DashedRectPainter extends CustomPainter {
  _DashedRectPainter({
    required this.color,
    required this.borderRadius,
    required this.dashLength,
    required this.gapLength,
    required this.strokeWidth,
  });

  final Color color;
  final double borderRadius;
  final double dashLength;
  final double gapLength;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final rRect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(borderRadius),
    );

    final path = Path()..addRRect(rRect);
    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next = distance + dashLength;
        canvas.drawPath(
          metric.extractPath(distance, next.clamp(0, metric.length)),
          paint,
        );
        distance = next + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
