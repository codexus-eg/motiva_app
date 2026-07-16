import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/vendor_dashboard/presentation/widgets/setting/document_screen/vendor_document_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class VendorDocumentsScreen extends StatelessWidget {
  const VendorDocumentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerSection(context),
              Gap(AppSpacing.xl),
              VendorDocumentSection(
                title: t.vendor_dashboard.documents.commercial_license,
                fileName: 'Commercial_License.jpg',
              ),
              Gap(AppSpacing.xl),
              VendorDocumentSection(
                title: t.vendor_dashboard.documents.civil_id,
                fileName: 'Civil_Id.jpg',
              ),
              Gap(AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.secondary,
            size: 20,
          ),
        ),
        const Gap(AppSpacing.md),
        Text(
          t.vendor_dashboard.documents.screen_title,
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: theme.onSurface,
          ),
        ),
      ],
    );
  }
}
