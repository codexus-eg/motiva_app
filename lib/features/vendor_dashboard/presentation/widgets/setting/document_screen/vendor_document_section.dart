import 'dart:math' as math;

import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class VendorDocumentSection extends StatelessWidget {
  final String title;
  final String fileName;

  const VendorDocumentSection({
    super.key,
    required this.title,
    required this.fileName,
  });

  static const _noteColor = Color(0xFF9C9C9C);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_dashboard.documents;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: theme.onSurface,
          ),
        ),
        const Gap(AppSpacing.md),
        _DocumentFileInfoTile(
          fileName: fileName,
          backgroundColor: theme.primaryContainer,
        ),
        const Gap(AppSpacing.md),
        const _UploadPlaceholderCard(),
        const Gap(AppSpacing.md),
        Text(
          t.re_upload_note,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontStyle: FontStyle.italic,
            color: _noteColor,
          ),
        ),
      ],
    );
  }
}

class _DocumentFileInfoTile extends StatelessWidget {
  final String fileName;
  final Color backgroundColor;

  const _DocumentFileInfoTile({
    required this.fileName,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_dashboard.documents;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/icons/vendor_document.png',
            width: 36,
            height: 36,
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  fileName,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: theme.onSurface,
                  ),
                ),
                const Gap(AppSpacing.xs),
                Text(
                  t.upload_success,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.green,
                  ),
                ),
              ],
            ),
          ),
          const Gap(AppSpacing.md),
          const _FileActionButtons(),
        ],
      ),
    );
  }
}

class _FileActionButtons extends StatelessWidget {
  const _FileActionButtons();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.delete_outline, size: 24, color: theme.onSurface),
        Gap(AppSpacing.sm),
        SvgPicture.asset(
          'assets/icons/vendor_repeat.svg',
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(theme.onSurface, BlendMode.srcIn),
        ),
      ],
    );
  }
}

class _UploadPlaceholderCard extends StatelessWidget {
  const _UploadPlaceholderCard();

  static const _accentColor = Color(0xFFDC8735);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    final browseStyle = GoogleFonts.poppins(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: _accentColor,
    );

    final bodyStyle = GoogleFonts.poppins(fontSize: 14, color: theme.onSurface);

    final captionStyle = GoogleFonts.poppins(
      fontSize: 12,
      color: AppColors.textSecondary,
    );

    final t = Translations.of(context).vendor_dashboard.documents;
    return CustomPaint(
      foregroundPainter: _DashedBorderPainter(
        color: _accentColor,
        radius: 14,
        dashLength: 7,
        gapLength: 6,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.cloud_upload_outlined, color: theme.onSurface, size: 28),
            const Gap(AppSpacing.md),
            RichText(
              text: TextSpan(
                style: bodyStyle,
                children: [
                  TextSpan(text: t.browse, style: browseStyle),
                  const TextSpan(text: ' '),
                  TextSpan(
                    text: t.your_file,
                    style: TextStyle(color: theme.onSurface),
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.sm),
            Text(t.max_size, style: captionStyle),
          ],
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  _DashedBorderPainter({
    required this.color,
    required this.radius,
    this.dashLength = 6,
    this.gapLength = 4,
  });

  final Color color;
  final double radius;
  final double dashLength;
  final double gapLength;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final rect = RRect.fromRectAndRadius(
      Offset.zero & size,
      Radius.circular(radius),
    );

    final path = Path()..addRRect(rect);
    final dashedPath = _createDashedPath(path);

    canvas.drawPath(dashedPath, paint);
  }

  Path _createDashedPath(Path source) {
    final Path dest = Path();
    for (final metric in source.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final double nextDistance = math.min(
          dashLength,
          metric.length - distance,
        );
        dest.addPath(
          metric.extractPath(distance, distance + nextDistance),
          Offset.zero,
        );
        distance += dashLength + gapLength;
      }
    }
    return dest;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
