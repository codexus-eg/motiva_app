import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/utils/fallback_images.dart';
import 'package:app/features/vendor-listings/domain/entities/vendor_listing_item.dart';
import 'package:app/shared/ui/images/platform_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class ListingCard extends StatelessWidget {
  final VendorListingItem item;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onToggleActive;
  final VoidCallback? onArchive;
  final VoidCallback? onRestore;
  final bool isToggleLoading;
  final bool isDeleteLoading;

  const ListingCard({
    super.key,
    required this.item,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onToggleActive,
    this.onArchive,
    this.onRestore,
    this.isToggleLoading = false,
    this.isDeleteLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          border: item.isArchived || !item.isActive
              ? Border.all(
                  color: AppColors.textSecondary.withValues(alpha: 0.3),
                )
              : null,
        ),
        child: Opacity(
          opacity: item.isArchived || !item.isActive ? 0.7 : 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImage(),
                  const Gap(AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                item.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: theme.onSurface,
                                ),
                              ),
                            ),
                            _buildStatusBadge(context),
                          ],
                        ),
                        if (item.description != null &&
                            item.description!.isNotEmpty) ...[
                          const Gap(AppSpacing.xs),
                          Text(
                            item.description!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                        const Gap(AppSpacing.sm),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: item.type == ListingType.product
                                    ? AppColors.primary.withValues(alpha: 0.15)
                                    : AppColors.orange.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                item.type == ListingType.product
                                    ? t.vendor_listings.card.type_product
                                    : t.vendor_listings.card.type_service,
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: item.type == ListingType.product
                                      ? AppColors.primary
                                      : AppColors.orange,
                                ),
                              ),
                            ),
                            if (item.type == ListingType.product &&
                                item.product != null) ...[
                              const Gap(AppSpacing.sm),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.primaryContainer,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  t.vendor_listings.card.stock_label.replaceAll(
                                    '{count}',
                                    item.product!.stockQuantity
                                        .toInt()
                                        .toString(),
                                  ),
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(AppSpacing.md),
              Row(
                children: [
                  Icon(Icons.attach_money, size: 16, color: AppColors.primary),
                  Flexible(
                    child: Text(
                      '${_formatPrice(item.price ?? '0')}${t.vendor_listings.card.currency_suffix}',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
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

  Widget _buildImage() {
    final url = item.imageUrl;
    if (url != null && url.trim().isNotEmpty) {
      final resolvedUrl = FallbackImages.resolveUrl(url);
      return buildPlatformImage(
        url: resolvedUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        placeholder: _buildPlaceholder(),
        borderRadius: BorderRadius.circular(10),
      );
    }
    return _buildPlaceholder();
  }

  Widget _buildPlaceholder() {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Icon(
        item.type == ListingType.product
            ? Icons.inventory_2_outlined
            : Icons.miscellaneous_services_outlined,
        color: AppColors.primary,
        size: 28,
      ),
    );
  }

  Widget _buildStatusBadge(BuildContext context) {
    final t = Translations.of(context);
    if (item.isArchived) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.red.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          t.vendor_listings.card.status_archived,
          style: GoogleFonts.poppins(fontSize: 10, color: AppColors.red),
        ),
      );
    }
    if (!item.isActive) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.textSecondary.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          t.vendor_listings.card.status_inactive,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: AppColors.textSecondary,
          ),
        ),
      );
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.green.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        t.vendor_listings.card.status_active,
        style: GoogleFonts.poppins(fontSize: 10, color: AppColors.green),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (item.type == ListingType.product && onToggleActive != null)
          Tooltip(
            message: item.isActive
                ? t.vendor_listings.tooltip.deactivate
                : t.vendor_listings.tooltip.activate,
            child: GestureDetector(
              onTap: isToggleLoading ? null : onToggleActive,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: item.isActive
                      ? AppColors.green.withValues(alpha: 0.15)
                      : AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isToggleLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Icon(
                        item.isActive
                            ? Icons.toggle_on_outlined
                            : Icons.toggle_off_outlined,
                        size: 18,
                        color: item.isActive
                            ? AppColors.green
                            : AppColors.primary,
                      ),
              ),
            ),
          ),
        if (item.type == ListingType.service) ...[
          if (item.isArchived && onRestore != null) ...[
            Tooltip(
              message: t.vendor_listings.tooltip.restore,
              child: GestureDetector(
                onTap: onRestore,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.green.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.restore,
                    size: 18,
                    color: AppColors.green,
                  ),
                ),
              ),
            ),
          ] else if (onArchive != null) ...[
            Tooltip(
              message: t.vendor_listings.tooltip.archive,
              child: GestureDetector(
                onTap: onArchive,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.orange.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.archive_outlined,
                    size: 18,
                    color: AppColors.orange,
                  ),
                ),
              ),
            ),
          ],
        ],
        if (onEdit != null) ...[
          const Gap(AppSpacing.sm),
          Tooltip(
            message: t.vendor_listings.tooltip.edit,
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
        ],
        if (item.type == ListingType.product && onDelete != null) ...[
          const Gap(AppSpacing.sm),
          Tooltip(
            message: t.vendor_listings.tooltip.delete,
            child: GestureDetector(
              onTap: isDeleteLoading ? null : onDelete,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.red.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isDeleteLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(
                        Icons.delete_outline,
                        size: 18,
                        color: AppColors.red,
                      ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  String _formatPrice(String price) {
    final value = double.tryParse(price);
    if (value == null) return price;
    final intValue = value.toInt();
    if (value == intValue) return intValue.toString();
    return value.toString();
  }
}
