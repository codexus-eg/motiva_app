import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';
import 'package:app/features/vendor-products/presentation/providers/vendor_products_provider.dart';
import 'package:app/features/vendor-product-analytics/presentation/screens/vendor_analytics_screen.dart';
import 'package:app/features/vendor-products/presentation/screens/create_product_screen.dart';
import 'package:app/features/vendor-products/presentation/widgets/product_card.dart';
import 'package:app/shared/ui/empty_states/empty_state_widget.dart';
import 'package:app/shared/ui/inputs/custom_search_bar.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

enum ProductFilter { all, active, inactive }

class VendorProductsScreen extends ConsumerStatefulWidget {
  const VendorProductsScreen({super.key});

  @override
  ConsumerState<VendorProductsScreen> createState() =>
      _VendorProductsScreenState();
}

class _VendorProductsScreenState extends ConsumerState<VendorProductsScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  ProductFilter _filter = ProductFilter.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsState = ref.watch(vendorProductsNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            const Gap(AppSpacing.md),
            _buildSearchBar(),
            const Gap(AppSpacing.md),
            _buildFilterChips(),
            const Gap(AppSpacing.md),
            Expanded(
              child: productsState.when(
                data: (state) {
                  final filteredProducts = _filterProducts(state.products);

                  if (filteredProducts.isEmpty) {
                    return _buildEmptyState(context);
                  }
                  return _buildProductsList(context, filteredProducts);
                },
                loading: () => ShimmerSkeletons.cardSkeleton(),
                error: (error, stack) => _buildErrorState(context, error),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.orange),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          Text(
            Translations.of(context).vendor_products.screen_title,
            style: GoogleFonts.poppins(
              color: theme.onSurface,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateProductScreen()),
              );
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(Icons.add, color: AppColors.white, size: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: CustomSearchBar(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase();
          });
        },
        hintText: Translations.of(context).vendor_products.search_hint,
        isBuyCar: false,
      ),
    );
  }

  Widget _buildFilterChips() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Row(
        children: [
          _buildFilterChip(
            label: Translations.of(context).vendor_products.filter_all,
            filter: ProductFilter.all,
            count: _getTotalCount(),
          ),
          const Gap(AppSpacing.sm),
          _buildFilterChip(
            label: Translations.of(context).vendor_products.filter_active,
            filter: ProductFilter.active,
            count: _getActiveCount(),
          ),
          const Gap(AppSpacing.sm),
          _buildFilterChip(
            label: Translations.of(context).vendor_products.filter_inactive,
            filter: ProductFilter.inactive,
            count: _getInactiveCount(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required ProductFilter filter,
    required int count,
  }) {
    final isSelected = _filter == filter;
    final theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () {
        setState(() {
          _filter = filter;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : theme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? null
              : Border.all(
                  color: AppColors.textSecondary.withValues(alpha: 0.2),
                ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: isSelected ? AppColors.white : theme.onSurface,
              ),
            ),
            const Gap(AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.white.withValues(alpha: 0.2)
                    : AppColors.textSecondary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                count.toString(),
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isSelected ? AppColors.white : AppColors.textSecondary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  int _getTotalCount() {
    return ref
            .read(vendorProductsNotifierProvider)
            .valueOrNull
            ?.products
            .length ??
        0;
  }

  int _getActiveCount() {
    return ref
            .read(vendorProductsNotifierProvider)
            .valueOrNull
            ?.products
            .where((p) => p.isActive)
            .length ??
        0;
  }

  int _getInactiveCount() {
    return ref
            .read(vendorProductsNotifierProvider)
            .valueOrNull
            ?.products
            .where((p) => !p.isActive)
            .length ??
        0;
  }

  List<VendorProduct> _filterProducts(List<VendorProduct> products) {
    var filtered = products;

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((p) {
        final nameMatch = p.name.toLowerCase().contains(_searchQuery);
        final descMatch =
            p.description?.toLowerCase().contains(_searchQuery) ?? false;
        return nameMatch || descMatch;
      }).toList();
    }

    switch (_filter) {
      case ProductFilter.active:
        filtered = filtered.where((p) => p.isActive).toList();
        break;
      case ProductFilter.inactive:
        filtered = filtered.where((p) => !p.isActive).toList();
        break;
      case ProductFilter.all:
        break;
    }

    return filtered;
  }

  Widget _buildEmptyState(BuildContext context) {
    return EmptyStateWidget(
      icon: Icons.inventory_2_outlined,
      title: _searchQuery.isNotEmpty
          ? Translations.of(context).vendor_products.empty.no_results
          : _filter == ProductFilter.inactive
          ? Translations.of(context).vendor_products.empty.no_inactive_products
          : Translations.of(context).vendor_products.empty.no_products,
      subtitle: _searchQuery.isNotEmpty
          ? Translations.of(context).vendor_products.empty.adjust_search
          : _filter == ProductFilter.inactive
          ? Translations.of(context).vendor_products.empty.inactive_subtitle
          : Translations.of(
              context,
            ).vendor_products.empty.create_product_prompt,
      actionText: _searchQuery.isEmpty && _filter != ProductFilter.inactive
          ? Translations.of(context).vendor_products.empty.create_product_button
          : null,
      onAction: _searchQuery.isEmpty && _filter != ProductFilter.inactive
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateProductScreen()),
              );
            }
          : null,
    );
  }

  Widget _buildProductsList(
    BuildContext context,
    List<VendorProduct> products,
  ) {
    return RefreshIndicator(
      onRefresh: () =>
          ref.read(vendorProductsNotifierProvider.notifier).refresh(),
      color: AppColors.primary,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 100),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(
            product: product,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VendorAnalyticsScreen(product: product),
                ),
              );
            },
            onEdit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CreateProductScreen(existingProduct: product),
                ),
              );
            },
            onDelete: () => _confirmDelete(context, product),
            onToggleActive: () => _toggleActive(product),
          );
        },
      ),
    );
  }

  Future<void> _confirmDelete(
    BuildContext context,
    VendorProduct product,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).colorScheme.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          Translations.of(context).vendor_products.dialog.delete_title,
          style: GoogleFonts.poppins(
            color: Theme.of(context).colorScheme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Text(
          Translations.of(context).vendor_products.dialog.delete_message
              .replaceAll('{name}', product.name),
          style: GoogleFonts.poppins(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(
              Translations.of(context).vendor_products.dialog.cancel,
              style: GoogleFonts.poppins(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(
              Translations.of(context).vendor_products.dialog.delete,
              style: GoogleFonts.poppins(color: AppColors.red),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final success = await ref
          .read(vendorProductsNotifierProvider.notifier)
          .deleteProduct(product.id);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? Translations.of(
                      context,
                    ).vendor_products.snackbar.product_deleted
                  : Translations.of(
                      context,
                    ).vendor_products.snackbar.delete_failed,
            ),
            backgroundColor: success ? AppColors.green : AppColors.red,
          ),
        );
      }
    }
  }

  Future<void> _toggleActive(VendorProduct product) async {
    final success = await ref
        .read(vendorProductsNotifierProvider.notifier)
        .toggleProductActive(product.id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? product.isActive
                      ? Translations.of(
                          context,
                        ).vendor_products.snackbar.product_deactivated
                      : Translations.of(
                          context,
                        ).vendor_products.snackbar.product_activated
                : Translations.of(
                    context,
                  ).vendor_products.snackbar.update_status_failed,
          ),
          backgroundColor: success ? AppColors.green : AppColors.red,
        ),
      );
    }
  }

  Widget _buildErrorState(BuildContext context, Object error) {
    final theme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
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
              Translations.of(context).vendor_products.error.title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.onSurface,
              ),
            ),
            const Gap(AppSpacing.sm),
            Text(
              Translations.of(context).vendor_products.error.message,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const Gap(AppSpacing.lg),
            ElevatedButton(
              onPressed: () {
                ref.read(vendorProductsNotifierProvider.notifier).refresh();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: theme.onSurface,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                Translations.of(context).vendor_products.error.retry,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
