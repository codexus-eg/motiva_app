import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/core/utils/error_display.dart';
import 'package:app/core/utils/fallback_images.dart';
import 'package:app/features/cart/presentation/providers/cart_provider.dart';
import 'package:app/features/public_marketplace/presentation/providers/public_marketplace_provider.dart';
import 'package:app/features/public_marketplace/presentation/widgets/compatibility_list_widget.dart';
import 'package:app/features/reviews/presentation/providers/reviews_provider.dart';
import 'package:app/features/reviews/presentation/widgets/reviews_section.dart';
import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';
import 'package:app/shared/ui/images/network_image_widget.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/i18n/strings.g.dart';

class MarketplaceDetailScreen extends ConsumerStatefulWidget {
  final String productId;

  const MarketplaceDetailScreen({super.key, required this.productId});

  @override
  ConsumerState<MarketplaceDetailScreen> createState() =>
      _MarketplaceDetailScreenState();
}

class _MarketplaceDetailScreenState
    extends ConsumerState<MarketplaceDetailScreen> {
  int _quantity = 1;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadReviews();
    });
  }

  void _loadReviews() {
    final productAsync = ref.read(
      publicProductDetailsProvider(widget.productId),
    );
    productAsync.whenData((product) {
      if (product != null) {
        final reviewsNotifier = ref.read(
          reviewsListNotifierProvider(widget.productId).notifier,
        );
        reviewsNotifier.setContext(
          productId: widget.productId,
          vendorId: product.vendorId,
        );
        reviewsNotifier.loadReviews();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final productAsync = ref.watch(
      publicProductDetailsProvider(widget.productId),
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: productAsync.when(
        loading: () => SafeArea(child: ShimmerSkeletons.screenSkeleton()),
        error: (err, stack) => SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                err.toString(),
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(color: theme.colorScheme.onSurface),
              ),
            ),
          ),
        ),
        data: (product) {
          if (product == null) {
            final t = Translations.of(
              context,
            ).public_marketplace.details_screen;
            return SafeArea(child: Center(child: Text(t.product_not_found)));
          }
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAppBar(context),
                  _buildServiceImage(product),
                  _buildServiceInfo(product),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Divider(color: Color(0xFF383A42)),
                  ),
                  _buildDescription(product),
                  _buildSpecifications(product),
                  _buildQuantitySelector(product),
                  const Gap(AppSpacing.md),
                  _buildActionButtons(product),
                  const Gap(AppSpacing.lg),
                  _buildReviewSection(),
                  _buildSimilarProducts(),
                  const Gap(AppSpacing.xl),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).public_marketplace.details_screen;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          IconButton(
            tooltip: SemanticLabels.backButton,
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme.colorScheme.onSurface,
              size: 20,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const Gap(AppSpacing.xl),
          Text(
            t.app_bar_title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          // const Icon(Icons.share, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  Widget _buildServiceImage(VendorProduct product) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: theme.colorScheme.primaryContainer,
        ),
        clipBehavior: Clip.antiAlias,
        child: _buildProductImage(product.images),
      ),
    );
  }

  Widget _buildProductImage(List<String> images) {
    if (images.isNotEmpty && images.first.startsWith('assets/')) {
      return Image.asset(images.first, fit: BoxFit.cover);
    }
    return NetworkImageWidget(
      imageUrl: images.isNotEmpty ? images.first : null,
      fallbackAsset: FallbackImages.serviceDefault,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildServiceInfo(VendorProduct product) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.name,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            '${product.currency} ${_formatPrice(product.price)}',
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFFE8C00),
            ),
          ),
          const Gap(AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildDescription(VendorProduct product) {
    final theme = Theme.of(context);
    final t = Translations.of(context).public_marketplace.details_screen;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.description,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            product.description ?? t.no_description,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFFA8A8A8),
              height: 1.5,
            ),
          ),
          const Gap(AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildSpecifications(VendorProduct product) {
    if (product.productType != 'spare_part') {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);
    final t = Translations.of(context).public_marketplace.spare_parts;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.08),
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.details_screen.specifications,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 12),
            _buildSpecRow(t.details_screen.brand, product.brand, isMono: true),
            const SizedBox(height: 8),
            _buildSpecRow(
              t.details_screen.part_number,
              product.partNumber,
              isMono: true,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  t.details_screen.warranty,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const Spacer(),
                if (product.warrantyMonths != null && product.warrantyMonths! > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.secondary),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      t.details_screen.warranty_months_suffix.replaceAll(
                        '{months}',
                        product.warrantyMonths.toString(),
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.secondary,
                      ),
                    ),
                  )
                else
                  Text(
                    t.details_screen.no_value,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              t.details_screen.compatibility,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 4),
            CompatibilityListWidget(entries: product.compatibility ?? const []),
            const Gap(AppSpacing.md),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecRow(String label, String? value, {bool isMono = false}) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        const Spacer(),
        Text(
          value ?? Translations.of(context).public_marketplace.spare_parts.details_screen.no_value,
          style: isMono
              ? GoogleFonts.jetBrainsMono(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface,
                )
              : GoogleFonts.poppins(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface,
                ),
        ),
      ],
    );
  }

  Widget _buildQuantitySelector(VendorProduct product) {
    final theme = Theme.of(context).colorScheme;
    final maxQty = product.stockQuantity;
    final t = Translations.of(context).public_marketplace.details_screen;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.quantity,
              style: TextStyle(
                fontSize: 16,
                color: theme.onSurface,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              children: [
                _QuantityButton(
                  icon: Icons.remove,
                  onTap: _quantity > 1
                      ? () => setState(() => _quantity--)
                      : null,
                ),
                const Gap(AppSpacing.md),
                Text(
                  '$_quantity',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.onSurface,
                  ),
                ),
                const Gap(AppSpacing.md),
                _QuantityButton(
                  icon: Icons.add,
                  onTap: _quantity < maxQty
                      ? () => setState(() => _quantity++)
                      : null,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(VendorProduct product) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).public_marketplace.details_screen;
    final addCartState = ref.watch(addCartItemNotifierProvider);
    final isAdding = addCartState.isLoading;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GestureDetector(
        onTap: isAdding
            ? null
            : () async {
                try {
                  await ref
                      .read(addCartItemNotifierProvider.notifier)
                      .addItem(product.id, _quantity);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${product.name} ${t.added_to_cart}',
                          style: GoogleFonts.poppins(),
                        ),
                        backgroundColor: Colors.green.shade700,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                } catch (e, stackTrace) {
                  if (mounted) {
                    ErrorDisplay.showSnackBar(
                      context,
                      e,
                      stackTrace: stackTrace,
                    );
                  }
                }
              },
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            border: Border.all(
              color: isAdding
                  ? theme.onSurface.withValues(alpha: 0.4)
                  : theme.onSurface,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: isAdding
                ? SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: theme.onSurface,
                    ),
                  )
                : Text(
                    t.add_to_cart_button,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: theme.onSurface,
                      letterSpacing: 1.0,
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildReviewSection() {
    final reviewsState = ref.watch(
      reviewsListNotifierProvider(widget.productId),
    );
    final reviewsNotifier = ref.read(
      reviewsListNotifierProvider(widget.productId).notifier,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ReviewsSection(
        reviews: reviewsState.reviews,
        averageRating: reviewsState.averageRating,
        totalReviews: reviewsState.totalReviews,
        selectedRating: reviewsState.selectedRating,
        selectedSort: reviewsState.selectedSort,
        isLoading: reviewsState.isLoading,
        hasMore: reviewsState.hasMore,
        onRatingFilter: (rating) => reviewsNotifier.applyFilter(rating),
        onSortChange: (sort) => reviewsNotifier.applySort(sort),
        onLoadMore: () => reviewsNotifier.loadMore(),
        onRefresh: () {
          final productAsync = ref.read(
            publicProductDetailsProvider(widget.productId),
          );
          productAsync.whenData((product) {
            if (product != null) {
              reviewsNotifier.loadReviews(
                productId: widget.productId,
                vendorId: product.vendorId,
              );
            }
          });
        },
      ),
    );
  }

  Widget _buildSimilarProducts() {
    final theme = Theme.of(context);
    final t = Translations.of(context).public_marketplace.details_screen;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            t.similar_products,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        const Gap(AppSpacing.md),
        SizedBox(
          height: 175,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            scrollDirection: Axis.horizontal,
            itemCount: 2,
            separatorBuilder: (_, _) => const Gap(AppSpacing.md),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {},
                child: SizedBox(
                  width: 142,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 150,
                        width: 142,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: theme.colorScheme.primaryContainer,
                        ),
                        clipBehavior: Clip.antiAlias,
                        child: Image.asset(
                          'assets/images/battery.png',
                          fit: BoxFit.cover,
                        ),
                        // NetworkImageWidget(
                        //   imageUrl: service.imageUrl,
                        //   fallbackAsset: FallbackImages.serviceDefault,
                        //   fit: BoxFit.cover,
                        // ),
                      ),
                      const Gap(AppSpacing.sm),
                      Text(
                        'oil filter',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
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

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _QuantityButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: onTap != null
              ? theme.onSurface.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: onTap != null
              ? theme.onSurface
              : theme.onSurface.withValues(alpha: 0.3),
          size: 18,
        ),
      ),
    );
  }
}
