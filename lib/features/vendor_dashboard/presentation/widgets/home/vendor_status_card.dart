import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/vendor/domain/entities/vendor_profile.dart';
import 'package:app/features/vendor/domain/entities/vendor_status.dart';
import 'package:app/i18n/strings.g.dart' show Translations;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class VendorStatusCard extends StatelessWidget {
  final VendorProfile profile;
  final bool isUpdating;
  final Function(VendorStatus) onStatusChanged;

  const VendorStatusCard({
    super.key,
    required this.profile,
    required this.isUpdating,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).home.vendor.availability_capacity.status;
    final isOpen = profile.status == VendorStatus.open;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.title,
          style: GoogleFonts.poppins(
            color: theme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(AppSpacing.md),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: theme.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: isOpen
                      ? Colors.green.withValues(alpha: 0.2)
                      : Colors.orange.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isOpen ? Icons.storefront : Icons.work,
                  color: isOpen ? Colors.green : Colors.orange,
                  size: 20,
                ),
              ),
              const Gap(AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.title,
                      style: GoogleFonts.poppins(
                        color: theme.onSurface,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      isOpen ? t.open : t.busy,
                      style: GoogleFonts.poppins(
                        color: theme.onSurface.withValues(alpha: 0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              if (isUpdating)
                const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.primary,
                  ),
                )
              else
                Switch.adaptive(
                  value: isOpen,
                  onChanged: (value) => onStatusChanged(
                    value ? VendorStatus.open : VendorStatus.busy,
                  ),
                  activeColor: AppColors.green,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
