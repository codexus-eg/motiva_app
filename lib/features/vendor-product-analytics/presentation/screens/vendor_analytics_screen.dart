import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/core/utils/fallback_images.dart';
import 'package:app/features/vendor-product-analytics/presentation/providers/vendor_product_analytics_provider.dart';
import 'package:app/features/vendor-product-analytics/presentation/providers/vendor_product_analytics_state.dart';
import 'package:app/features/vendor-product-analytics/presentation/widgets/metric_stat_card.dart';
import 'package:app/features/vendor-product-analytics/presentation/widgets/revenue_line_chart.dart';
import 'package:app/features/vendor-product-analytics/presentation/widgets/time_period_filter.dart';
import 'package:app/features/vendor-product-analytics/presentation/widgets/top_products_bar_chart.dart';
import 'package:app/features/vendor-product-analytics/domain/entities/vendor_product_analytics.dart';
import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';
import 'package:app/shared/ui/images/platform_image.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorAnalyticsScreen extends ConsumerStatefulWidget {
  final VendorProduct product;

  const VendorAnalyticsScreen({super.key, required this.product});

  @override
  ConsumerState<VendorAnalyticsScreen> createState() =>
      _VendorAnalyticsScreenState();
}

class _VendorAnalyticsScreenState extends ConsumerState<VendorAnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final analyticsAsync = ref.watch(
      vendorProductAnalyticsNotifierProvider(widget.product.id),
    );

    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref
                .read(
                  vendorProductAnalyticsNotifierProvider(
                    widget.product.id,
                  ).notifier,
                )
                .refresh();
          },
          color: AppColors.primary,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: _buildHeader(context, theme)),
              SliverToBoxAdapter(
                child: analyticsAsync.when(
                  data: (state) => _buildContent(context, theme, state),
                  loading: () => _buildLoadingState(context, theme),
                  error: (error, stack) =>
                      _buildErrorState(context, theme, error),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ColorScheme theme) {
    final t = Translations.of(context).vendor_product_analytics;
    final product = widget.product;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios, color: AppColors.orange),
                onPressed: () => Navigator.pop(context),
              ),
              const Spacer(),
              Text(
                t.screen_title,
                style: GoogleFonts.poppins(
                  color: theme.onSurface,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Spacer(),
              const SizedBox(width: 40),
            ],
          ),
          const Gap(AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                _buildProductImage(product),
                const Gap(AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.onSurface,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Gap(AppSpacing.sm),
                      Row(
                        children: [
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
                              '${_formatPrice(product.price)} ${product.currency}',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
                              border: Border.all(
                                color: AppColors.textSecondary.withValues(
                                  alpha: 0.2,
                                ),
                              ),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              '${t.stock}: ${product.stockQuantity.toInt()}',
                              style: GoogleFonts.poppins(
                                fontSize: 12,
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
          ),
        ],
      ),
    );
  }

  Widget _buildProductImage(VendorProduct product) {
    final imageUrl = product.images.firstWhere(
      (url) => url.trim().isNotEmpty,
      orElse: () => '',
    );
    if (imageUrl.isNotEmpty) {
      final resolvedUrl = FallbackImages.resolveUrl(imageUrl);
      return buildPlatformImage(
        url: resolvedUrl,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
        placeholder: _buildImagePlaceholder(),
        borderRadius: BorderRadius.circular(10),
      );
    }
    return _buildImagePlaceholder();
  }

  Widget _buildImagePlaceholder() {
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

  String _formatPrice(String price) {
    final value = double.tryParse(price);
    if (value == null) return price;
    final intValue = value.toInt();
    if (value == intValue) return intValue.toString();
    return value.toString();
  }

  Widget _buildContent(
    BuildContext context,
    ColorScheme theme,
    VendorProductAnalyticsState state,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: TimePeriodFilter(
              selectedPeriod: state.timePeriod,
              onPeriodSelected: (period) {
                ref
                    .read(
                      vendorProductAnalyticsNotifierProvider(
                        widget.product.id,
                      ).notifier,
                    )
                    .setTimePeriod(period);
              },
            ),
          ),
          const Gap(AppSpacing.lg),
          _buildMetricsRow(context, state.analytics),
          const Gap(AppSpacing.lg),
          RevenueLineChart(data: state.analytics.revenueOverTime),
          const Gap(AppSpacing.lg),
          TopProductsBarChart(data: state.analytics.topProducts),
          const Gap(AppSpacing.xl),
        ],
      ),
    );
  }

  Widget _buildMetricsRow(
    BuildContext context,
    VendorProductAnalytics analytics,
  ) {
    final t = Translations.of(context).vendor_product_analytics.metrics;
    return Row(
      children: [
        Expanded(
          child: MetricStatCard(
            title: t.total_views,
            value: analytics.totalViews.toString(),
            icon: Icons.visibility_outlined,
            iconColor: AppColors.primary,
          ),
        ),
        const Gap(AppSpacing.md),
        Expanded(
          child: MetricStatCard(
            title: t.conversion,
            value: '${analytics.conversionRate.toStringAsFixed(1)}%',
            icon: Icons.trending_up_outlined,
            iconColor: AppColors.green,
          ),
        ),
        const Gap(AppSpacing.md),
        Expanded(
          child: MetricStatCard(
            title: t.total_orders,
            value: analytics.totalOrders.toString(),
            icon: Icons.shopping_bag_outlined,
            iconColor: AppColors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildLoadingState(BuildContext context, ColorScheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const Gap(AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ShimmerSkeletons.chipSkeleton(),
              const Gap(AppSpacing.sm),
              ShimmerSkeletons.chipSkeleton(),
              const Gap(AppSpacing.sm),
              ShimmerSkeletons.chipSkeleton(),
            ],
          ),
          const Gap(AppSpacing.lg),
          Row(
            children: [
              Expanded(child: ShimmerSkeletons.cardSkeleton(height: 100)),
              const Gap(AppSpacing.md),
              Expanded(child: ShimmerSkeletons.cardSkeleton(height: 100)),
              const Gap(AppSpacing.md),
              Expanded(child: ShimmerSkeletons.cardSkeleton(height: 100)),
            ],
          ),
          const Gap(AppSpacing.lg),
          ShimmerSkeletons.cardSkeleton(height: 220),
          const Gap(AppSpacing.lg),
          ShimmerSkeletons.cardSkeleton(height: 220),
        ],
      ),
    );
  }

  Widget _buildErrorState(
    BuildContext context,
    ColorScheme theme,
    Object error,
  ) {
    final t = Translations.of(context).vendor_product_analytics.error;
    return Padding(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.red.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.error_outline,
              size: 40,
              color: AppColors.red,
            ),
          ),
          const Gap(AppSpacing.lg),
          Text(
            t.title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: theme.onSurface,
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            t.message,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const Gap(AppSpacing.lg),
          ElevatedButton(
            onPressed: () {
              ref
                  .read(
                    vendorProductAnalyticsNotifierProvider(
                      widget.product.id,
                    ).notifier,
                  )
                  .refresh();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              foregroundColor: theme.onSurface,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text(
              t.retry,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
