import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/core/utils/fallback_images.dart';
import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';
import 'package:app/shared/ui/images/platform_image.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class ProductCard extends StatelessWidget {
  final VendorProduct product;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final VoidCallback? onToggleActive;
  final bool isToggleLoading;
  final bool isDeleteLoading;

  const ProductCard({
    super.key,
    required this.product,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.onToggleActive,
    this.isToggleLoading = false,
    this.isDeleteLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isInactive = !product.isActive;
    final theme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          border: isInactive
              ? Border.all(
                  color: AppColors.textSecondary.withValues(alpha: 0.3),
                )
              : null,
        ),
        child: Opacity(
          opacity: isInactive ? 0.7 : 1.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildProductImage(),
                  const Gap(AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                product.name,
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: theme.onSurface,
                                ),
                              ),
                            ),
                            if (isInactive)
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
                                  Translations.of(
                                    context,
                                  ).vendor_products.card.inactive,
                                  style: GoogleFonts.poppins(
                                    fontSize: 10,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        if (product.description != null &&
                            product.description!.isNotEmpty) ...[
                          const Gap(AppSpacing.xs),
                          Text(
                            product.description!,
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
                                color: AppColors.primary.withValues(
                                  alpha: 0.15,
                                ),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _productTypeLabel(context, product.productType),
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
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
                                Translations.of(
                                  context,
                                ).vendor_products.card.stock_label.replaceAll(
                                  '{count}',
                                  product.stockQuantity.toString(),
                                ),
                                style: GoogleFonts.poppins(
                                  fontSize: 10,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ),
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
                      '${_formatPrice(product.price)} ${product.currency}',
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
              if (product.productType == 'spare_part' &&
                  (product.brand != null || product.partNumber != null)) ...[
                const SizedBox(height: 4),
                Text(
                  '${product.brand ?? ''}${product.brand != null && product.partNumber != null ? ' · ' : ''}${product.partNumber ?? ''}',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductImage() {
    AppLogger.debug('ProductCard(${product.id}) images: ${product.images}');
    final imageUrl = product.images.firstWhere(
      (url) => url.trim().isNotEmpty,
      orElse: () => '',
    );
    if (imageUrl.isNotEmpty) {
      final resolvedUrl = FallbackImages.resolveUrl(imageUrl);
      AppLogger.debug('ProductCard(${product.id}) resolvedUrl: $resolvedUrl');
      return buildPlatformImage(
        url: resolvedUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        placeholder: _buildPlaceholder(),
        borderRadius: BorderRadius.circular(10),
      );
    }
    AppLogger.debug(
      'ProductCard(${product.id}) no valid image URL, showing placeholder',
    );
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
      child: const Icon(
        Icons.inventory_2_outlined,
        color: AppColors.primary,
        size: 28,
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onToggleActive != null)
          Tooltip(
            message: product.isActive
                ? Translations.of(context).vendor_products.tooltip.deactivate
                : Translations.of(context).vendor_products.tooltip.activate,
            child: GestureDetector(
              onTap: isToggleLoading ? null : onToggleActive,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: product.isActive
                      ? AppColors.green.withValues(alpha: 0.15)
                      : AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isToggleLoading
                    ? ShimmerSkeletons.cardSkeleton()
                    : Icon(
                        product.isActive
                            ? Icons.toggle_on_outlined
                            : Icons.toggle_off_outlined,
                        size: 18,
                        color: product.isActive
                            ? AppColors.green
                            : AppColors.primary,
                      ),
              ),
            ),
          ),
        if (onEdit != null) ...[
          const Gap(AppSpacing.sm),
          Tooltip(
            message: Translations.of(context).vendor_products.tooltip.edit,
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
        if (onDelete != null) ...[
          const Gap(AppSpacing.sm),
          Tooltip(
            message: Translations.of(context).vendor_products.tooltip.delete,
            child: GestureDetector(
              onTap: isDeleteLoading ? null : onDelete,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.red.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: isDeleteLoading
                    ? ShimmerSkeletons.cardSkeleton()
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

  String _productTypeLabel(BuildContext context, String type) {
    final t = Translations.of(context).vendor_products.card;
    switch (type) {
      case 'spare_part':
        return t.type_spare_part;
      case 'accessory':
        return t.type_accessory;
      default:
        return type;
    }
  }
}
