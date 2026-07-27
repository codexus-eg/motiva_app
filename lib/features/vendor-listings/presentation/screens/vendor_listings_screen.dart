import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/screens/good_car_details_screen.dart';
import 'package:app/features/vendor-listings/domain/entities/vendor_listing_item.dart';
import 'package:app/features/vendor-listings/presentation/widgets/listing_card.dart';
import 'package:app/features/vendor-listings/presentation/widgets/listings_by_category_section.dart';
import 'package:app/features/vendor-product-analytics/presentation/screens/vendor_analytics_screen.dart';
import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';
import 'package:app/features/vendor-products/presentation/providers/vendor_products_provider.dart';
import 'package:app/features/vendor-products/presentation/providers/vendor_products_state.dart';
import 'package:app/features/vendor-products/presentation/screens/create_product_screen.dart';
import 'package:app/features/vendor-services/domain/entities/vendor_service.dart';
import 'package:app/features/vendor-services/presentation/providers/vendor_services_provider.dart';
import 'package:app/features/vendor-services/presentation/providers/vendor_services_state.dart';
import 'package:app/features/vendor-services/presentation/screens/create_service_screen.dart';
import 'package:app/features/vendor-services/presentation/screens/select_category_screen.dart';
import 'package:app/features/vendor-cars/presentation/providers/vendor_cars_provider.dart';
import 'package:app/features/vendor-cars/presentation/providers/vendor_cars_state.dart';
import 'package:app/features/vendor-cars/domain/entities/vendor_car.dart';
import 'package:app/shared/ui/dialogs/confirmation_dialog.dart';
import 'package:app/shared/ui/empty_states/empty_state_widget.dart';
import 'package:app/shared/ui/inputs/custom_search_bar.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

enum ListingFilter { all, product, service, car }

class VendorListingsScreen extends ConsumerStatefulWidget {
  final bool? isHomePage;
  const VendorListingsScreen({super.key, this.isHomePage = false});

  @override
  ConsumerState<VendorListingsScreen> createState() =>
      _VendorListingsScreenState();
}

class _VendorListingsScreenState extends ConsumerState<VendorListingsScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  ListingFilter _filter = ListingFilter.all;
  final Set<String> _toggleLoadingIds = {};
  final Set<String> _deleteLoadingIds = {};

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(vendorProductsNotifierProvider);
    final servicesAsync = ref.watch(vendorServicesNotifierProvider);
    final carsAsync = ref.watch(vendorCarsNotifierProvider);
    final theme = Theme.of(context).colorScheme;

    final isLoading =
        (productsAsync.isLoading && !productsAsync.hasValue) ||
        (servicesAsync.isLoading && !servicesAsync.hasValue) ||
        (carsAsync.isLoading && !carsAsync.hasValue);

    final hasError =
        productsAsync.hasError &&
        servicesAsync.hasError &&
        carsAsync.hasError &&
        !productsAsync.hasValue &&
        !servicesAsync.hasValue &&
        !carsAsync.hasValue;

    return Scaffold(
      backgroundColor: theme.surface,
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
              child: isLoading
                  ? ShimmerSkeletons.cardSkeleton()
                  : hasError
                  ? _buildErrorState(context)
                  : _buildListContent(productsAsync, servicesAsync, carsAsync),
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (widget.isHomePage != true) ...[
            IconButton(
              tooltip: SemanticLabels.backButton,
              icon: Icon(Icons.arrow_back_ios, color: AppColors.orange),
              onPressed: () => Navigator.pop(context),
            ),
          ],
          Text(
            t.vendor_listings.screen_title,
            style: GoogleFonts.poppins(
              color: theme.onSurface,
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),
          _buildFAB(),
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
        hintText: t.vendor_listings.search_hint,
        isBuyCar: false,
      ),
    );
  }

  Widget _buildFilterChips() {
    final productsAsync = ref.watch(vendorProductsNotifierProvider);
    final servicesAsync = ref.watch(vendorServicesNotifierProvider);
    final carsAsync = ref.watch(vendorCarsNotifierProvider);

    final products = productsAsync.valueOrNull?.products ?? [];
    final services = servicesAsync.valueOrNull?.services ?? [];
    final cars = carsAsync.valueOrNull?.cars ?? [];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip(
              label: t.vendor_listings.filter_all,
              filter: ListingFilter.all,
              count: products.length + services.length + cars.length,
            ),
            const Gap(AppSpacing.sm),
            _buildFilterChip(
              label: t.vendor_listings.filter_product,
              filter: ListingFilter.product,
              count: products.length,
            ),
            const Gap(AppSpacing.sm),
            _buildFilterChip(
              label: t.vendor_listings.filter_service,
              filter: ListingFilter.service,
              count: services.length,
            ),
            const Gap(AppSpacing.sm),
            _buildFilterChip(
              label: t.vendor_listings.filter_car,
              filter: ListingFilter.car,
              count: cars.length,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required ListingFilter filter,
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

  Widget _buildListContent(
    AsyncValue<VendorProductsState> productsAsync,
    AsyncValue<VendorServicesState> servicesAsync,
    AsyncValue<VendorCarsState> carsAsync,
  ) {
    final products = productsAsync.valueOrNull?.products ?? [];
    final services = servicesAsync.valueOrNull?.services ?? [];
    final cars = carsAsync.valueOrNull?.cars ?? [];

    AppLogger.info(
      'VendorListingsScreen - Products: ${products.length}, Services: ${services.length}, Cars: ${cars.length}',
    );

    final items = <VendorListingItem>[
      ...products.map(VendorListingItem.fromProduct),
      ...services.map(VendorListingItem.fromService),
      ...cars.map(VendorListingItem.fromCar),
    ];

    AppLogger.info(
      'VendorListingsScreen - Total items after mapping: ${items.length}',
    );

    items.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    final filtered = _filterItems(items);

    AppLogger.info(
      'VendorListingsScreen - Items after filtering: ${filtered.length}, Filter: $_filter',
    );

    if (filtered.isEmpty) {
      return _buildEmptyState();
    }

    final grouped = _groupItemsByCategory(filtered);

    return RefreshIndicator(
      onRefresh: () async {
        await ref.read(vendorProductsNotifierProvider.notifier).refresh();
        await ref.read(vendorServicesNotifierProvider.notifier).refresh();
        await ref.read(vendorCarsNotifierProvider.notifier).refresh();
      },
      color: AppColors.primary,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 100),
        itemCount: grouped.length,
        itemBuilder: (context, index) {
          final key = grouped.keys.elementAt(index);
          final groupItems = grouped[key]!;
          return ListingsByCategorySection(
            groupKey: key,
            items: groupItems,
            itemBuilder: _buildListingCard,
          );
        },
      ),
    );
  }

  Widget _buildListingCard(VendorListingItem item) {
    return ListingCard(
      item: item,
      onTap: () => _navigateToDetail(item),
      onEdit: () => _navigateToEdit(item),
      onDelete: item.type == ListingType.product
          ? () => _confirmDeleteProduct(item.product!)
          : item.type == ListingType.car
          ? () => _confirmDeleteCar(item.car!)
          : null,
      onToggleActive: item.type == ListingType.product
          ? () => _toggleProductActive(item.product!)
          : null,
      onArchive: item.type == ListingType.service && !item.isArchived
          ? () => _confirmArchiveService(item.service!)
          : null,
      onRestore: item.type == ListingType.service && item.isArchived
          ? () => _restoreService(item.service!)
          : null,
      isToggleLoading: _toggleLoadingIds.contains(item.id),
      isDeleteLoading: _deleteLoadingIds.contains(item.id),
    );
  }

  Map<String, List<VendorListingItem>> _groupItemsByCategory(
    List<VendorListingItem> items,
  ) {
    final grouped = <String, List<VendorListingItem>>{};
    for (final item in items) {
      final typePrefix = item.type == ListingType.service
          ? 'service'
          : item.type == ListingType.car
          ? 'car'
          : 'product';
      final catId = item.categoryId ?? 'uncategorized';
      final key = '$typePrefix:$catId';
      grouped.putIfAbsent(key, () => []).add(item);
    }
    return Map.fromEntries(
      grouped.entries.toList()..sort((a, b) => a.key.compareTo(b.key)),
    );
  }

  List<VendorListingItem> _filterItems(List<VendorListingItem> items) {
    var filtered = items;

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((item) {
        final nameMatch = item.name.toLowerCase().contains(_searchQuery);
        final descMatch =
            item.description?.toLowerCase().contains(_searchQuery) ?? false;
        return nameMatch || descMatch;
      }).toList();
    }

    switch (_filter) {
      case ListingFilter.product:
        filtered = filtered
            .where((item) => item.type == ListingType.product)
            .toList();
        break;
      case ListingFilter.service:
        filtered = filtered
            .where((item) => item.type == ListingType.service)
            .toList();
        break;
      case ListingFilter.car:
        filtered = filtered
            .where((item) => item.type == ListingType.car)
            .toList();
        break;
      case ListingFilter.all:
        break;
    }

    return filtered;
  }

  void _navigateToDetail(VendorListingItem item) {
    if (item.type == ListingType.product && item.product != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VendorAnalyticsScreen(product: item.product!),
        ),
      );
    } else if (item.type == ListingType.service && item.service != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CreateServiceScreen(existingService: item.service!),
        ),
      );
    } else if (item.type == ListingType.car && item.car != null) {
      // Navigate to car details - using GoodCarDetailsScreen as per existing pattern
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const GoodCarDetailsScreen()),
      );
    }
  }

  void _navigateToEdit(VendorListingItem item) {
    if (item.type == ListingType.product && item.product != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CreateProductScreen(existingProduct: item.product!),
        ),
      );
    } else if (item.type == ListingType.service && item.service != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CreateServiceScreen(existingService: item.service!),
        ),
      );
    } else if (item.type == ListingType.car && item.car != null) {
      // Navigate to car edit - using GoodCarDetailsScreen as per existing pattern
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const GoodCarDetailsScreen()),
      );
    }
  }

  Future<void> _toggleProductActive(VendorProduct product) async {
    setState(() => _toggleLoadingIds.add(product.id));
    final success = await ref
        .read(vendorProductsNotifierProvider.notifier)
        .toggleProductActive(product.id);
    setState(() => _toggleLoadingIds.remove(product.id));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? product.isActive
                      ? t.vendor_listings.snackbar.product_deactivated
                      : t.vendor_listings.snackbar.product_activated
                : t.vendor_listings.snackbar.update_status_failed,
          ),
          backgroundColor: success ? AppColors.green : AppColors.red,
        ),
      );
    }
  }

  Future<void> _confirmDeleteProduct(VendorProduct product) async {
    final confirmed = await ConfirmationDialog.show(
      context: context,
      title: t.vendor_listings.dialog.delete_product_title,
      message: t.vendor_listings.dialog.delete_product_message.replaceAll(
        '{name}',
        product.name,
      ),
      confirmText: t.vendor_listings.dialog.delete_confirm,
      confirmColor: AppColors.red,
      icon: Icons.delete_outline,
    );

    if (confirmed == true && mounted) {
      setState(() => _deleteLoadingIds.add(product.id));
      final success = await ref
          .read(vendorProductsNotifierProvider.notifier)
          .deleteProduct(product.id);
      setState(() => _deleteLoadingIds.remove(product.id));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? t.vendor_listings.snackbar.product_deleted
                  : t.vendor_listings.snackbar.delete_failed,
            ),
            backgroundColor: success ? AppColors.green : AppColors.red,
          ),
        );
      }
    }
  }

  Future<void> _confirmArchiveService(VendorService service) async {
    final confirmed = await ConfirmationDialog.show(
      context: context,
      title: t.vendor_listings.dialog.archive_service_title,
      message: t.vendor_listings.dialog.archive_service_message.replaceAll(
        '{name}',
        service.name,
      ),
      confirmText: t.vendor_listings.dialog.archive_confirm,
      confirmColor: AppColors.red,
      icon: Icons.archive,
    );

    if (confirmed == true && mounted) {
      final success = await ref
          .read(vendorServicesNotifierProvider.notifier)
          .archiveService(service.id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success
                  ? t.vendor_listings.snackbar.service_archived
                  : t.vendor_listings.snackbar.archive_failed,
            ),
            backgroundColor: success ? AppColors.green : AppColors.red,
          ),
        );
      }
    }
  }

  Future<void> _restoreService(VendorService service) async {
    final success = await ref
        .read(vendorServicesNotifierProvider.notifier)
        .restoreService(service.id);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success
                ? t.vendor_listings.snackbar.service_restored
                : t.vendor_listings.snackbar.restore_failed,
          ),
          backgroundColor: success ? AppColors.green : AppColors.red,
        ),
      );
    }
  }

  Future<void> _confirmDeleteCar(VendorCar car) async {
    final confirmed = await ConfirmationDialog.show(
      context: context,
      title: 'Delete Car',
      message:
          'Are you sure you want to delete "${car.make} ${car.model} ${car.year}"? This action cannot be undone.',
      confirmText: 'Delete',
      confirmColor: AppColors.red,
      icon: Icons.delete_outline,
    );

    if (confirmed == true && mounted) {
      setState(() => _deleteLoadingIds.add(car.id));
      final success = await ref
          .read(vendorCarsNotifierProvider.notifier)
          .deleteCar(car.id);
      setState(() => _deleteLoadingIds.remove(car.id));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'Car deleted successfully' : 'Failed to delete car',
            ),
            backgroundColor: success ? AppColors.green : AppColors.red,
          ),
        );
      }
    }
  }

  Widget _buildEmptyState() {
    final t = Translations.of(context);
    return EmptyStateWidget(
      icon: Icons.inventory_2_outlined,
      title: _searchQuery.isNotEmpty
          ? t.vendor_listings.empty.no_results
          : _filter == ListingFilter.product
          ? t.vendor_listings.empty.no_products
          : _filter == ListingFilter.service
          ? t.vendor_listings.empty.no_services
          : _filter == ListingFilter.car
          ? 'No Cars Yet'
          : t.vendor_listings.empty.no_listings,
      subtitle: _searchQuery.isNotEmpty
          ? t.vendor_listings.empty.adjust_search
          : _filter == ListingFilter.product
          ? t.vendor_listings.empty.create_product_prompt
          : _filter == ListingFilter.service
          ? t.vendor_listings.empty.create_service_prompt
          : _filter == ListingFilter.car
          ? 'Create your first car listing to start selling.'
          : t.vendor_listings.empty.create_listing_prompt,
      actionText: _searchQuery.isEmpty
          ? t.vendor_listings.empty.create_listing_button
          : null,
      onAction: _searchQuery.isEmpty ? _showCreateBottomSheet : null,
    );
  }

  Widget _buildErrorState(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
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
              t.vendor_listings.error.title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.onSurface,
              ),
            ),
            const Gap(AppSpacing.sm),
            Text(
              t.vendor_listings.error.message,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const Gap(AppSpacing.lg),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(vendorProductsNotifierProvider);
                ref.invalidate(vendorServicesNotifierProvider);
                ref.invalidate(vendorCarsNotifierProvider);
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
                t.vendor_listings.error.retry,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAB() {
    return FloatingActionButton.small(
      onPressed: _showCreateBottomSheet,
      backgroundColor: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Icon(Icons.add, color: AppColors.white),
    );
  }

  void _showCreateBottomSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.vendor_listings.bottom_sheet.title,
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const Gap(AppSpacing.lg),
                _buildBottomSheetOption(
                  icon: Icons.inventory_2_outlined,
                  label: t.vendor_listings.bottom_sheet.product_label,
                  description:
                      t.vendor_listings.bottom_sheet.product_description,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const CreateProductScreen(),
                      ),
                    );
                  },
                ),
                const Gap(AppSpacing.md),
                _buildBottomSheetOption(
                  icon: Icons.miscellaneous_services_outlined,
                  label: t.vendor_listings.bottom_sheet.service_label,
                  description:
                      t.vendor_listings.bottom_sheet.service_description,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SelectCategoryScreen(),
                      ),
                    );
                  },
                ),
                const Gap(AppSpacing.md),
                _buildBottomSheetOption(
                  icon: Icons.car_repair,
                  label: t.vendor_listings.bottom_sheet.car_label,
                  description: t.vendor_listings.bottom_sheet.car_description,
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const GoodCarDetailsScreen(),
                      ),
                    );
                  },
                ),
                const Gap(AppSpacing.lg),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBottomSheetOption({
    required IconData icon,
    required String label,
    required String description,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary),
            ),
            const Gap(AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.onSurface,
                    ),
                  ),
                  Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: AppColors.primary,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
