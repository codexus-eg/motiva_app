import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/vendor-services/domain/entities/vendor_service.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class ServiceCard extends StatelessWidget {
  final VendorService service;
  final String? categoryName;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onArchive;
  final VoidCallback? onRestore;
  final bool isArchiveLoading;
  final bool isRestoreLoading;

  const ServiceCard({
    super.key,
    required this.service,
    this.categoryName,
    this.onTap,
    this.onEdit,
    this.onArchive,
    this.onRestore,
    this.isArchiveLoading = false,
    this.isRestoreLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isArchived = service.isArchived;
    final theme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          border: isArchived
              ? Border.all(
                  color: AppColors.textSecondary.withValues(alpha: 0.3),
                )
              : null,
        ),
        child: Opacity(
          opacity: isArchived ? 0.7 : 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                service.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: theme.onSurface,
                                ),
                              ),
                            ),
                            if (isArchived)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.textSecondary.withValues(
                                    alpha: 0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  t.vendor_services.service_card.archived_badge,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (service.description != null &&
                            service.description!.isNotEmpty) ...[
                          const Gap(AppSpacing.xs),
                          Text(
                            service.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                        if (categoryName != null) ...[
                          const Gap(AppSpacing.sm),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              categoryName!,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(AppSpacing.md),
              Row(
                children: [
                  if (service.basePrice != null &&
                      service.basePrice!.isNotEmpty) ...[
                    Icon(
                      Icons.attach_money,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    Flexible(
                      child: Text(
                        t.vendor_services.service_card.price_format.replaceAll(
                          '{price}', service.basePrice!,
                        ),
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Gap(AppSpacing.sm),
                  ],
                  if (service.availabilityRadiusKm != null) ...[
                    Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    Text(
                      t.vendor_services.service_card.radius_format.replaceAll(
                        '{radius}', service.availabilityRadiusKm!.toString(),
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                  const Spacer(),
                  _buildActionButtons(context),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    if (service.isArchived) {
      return GestureDetector(
        onTap: isRestoreLoading ? null : onRestore,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.green.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(8),
          ),
          child: isRestoreLoading
              ? ShimmerSkeletons.cardSkeleton()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.restore, size: 14, color: AppColors.green),
                    const Gap(AppSpacing.xs),
                    Text(
                      t.vendor_services.service_card.action.restore,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.green,
                      ),
                    ),
                  ],
                ),
        ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onEdit != null)
          Tooltip(
            message: t.vendor_services.service_card.tooltip.edit,
            child: GestureDetector(
              onTap: onEdit,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.edit_outlined,
                  size: 18,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        if (onArchive != null) ...[
          const Gap(AppSpacing.sm),
          Tooltip(
            message: t.vendor_services.service_card.tooltip.archive,
            child: GestureDetector(
              onTap: isArchiveLoading ? null : onArchive,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.textSecondary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isArchiveLoading
                    ? ShimmerSkeletons.cardSkeleton()
                    : const Icon(
                        Icons.archive_outlined,
                        size: 18,
                        color: AppColors.textSecondary,
                      ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
