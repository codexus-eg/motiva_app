import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/vendor-services/domain/entities/vendor_service.dart';
import 'package:app/features/vendor-services/presentation/screens/select_category_screen.dart';
import 'package:app/features/vendor-services/presentation/providers/vendor_services_provider.dart';
import 'package:app/features/vendor-services/presentation/widgets/services_by_category_section.dart';
import 'package:app/shared/ui/empty_states/empty_state_widget.dart';
import 'package:app/shared/ui/inputs/custom_search_bar.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

enum ServiceFilter { all, active, archived }

class VendorServicesScreen extends ConsumerStatefulWidget {
  final bool? isHomePage;

  const VendorServicesScreen({super.key, this.isHomePage = false});

  @override
  ConsumerState<VendorServicesScreen> createState() =>
      _VendorServicesScreenState();
}

class _VendorServicesScreenState extends ConsumerState<VendorServicesScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  ServiceFilter _filter = ServiceFilter.all;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final servicesState = ref.watch(vendorServicesNotifierProvider);

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
              child: servicesState.when(
                data: (state) {
                  final filteredServices = _filterServices(state.services);
                  final groupedServices = _groupAndSortServices(
                    filteredServices,
                  );

                  if (groupedServices.isEmpty) {
                    return _buildEmptyState(context);
                  }
                  return _buildServicesList(context, groupedServices);
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
          if (widget.isHomePage != true) ...[
            IconButton(
              tooltip: SemanticLabels.backButton,
              icon: Icon(Icons.arrow_back_ios, color: AppColors.orange),
              onPressed: () => Navigator.pop(context),
            ),
            Spacer(),
          ],
          Text(
            t.vendor_services.screen.title,
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
                MaterialPageRoute(
                  builder: (context) => const SelectCategoryScreen(),
                ),
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
        hintText: t.vendor_services.screen.search_hint,
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
            label: t.vendor_services.filter.all,
            filter: ServiceFilter.all,
            count: _getTotalCount(),
          ),
          const Gap(AppSpacing.sm),
          _buildFilterChip(
            label: t.vendor_services.filter.active,
            filter: ServiceFilter.active,
            count: _getActiveCount(),
          ),
          const Gap(AppSpacing.sm),
          _buildFilterChip(
            label: t.vendor_services.filter.archived,
            filter: ServiceFilter.archived,
            count: _getArchivedCount(),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required ServiceFilter filter,
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
            .read(vendorServicesNotifierProvider)
            .valueOrNull
            ?.services
            .length ??
        0;
  }

  int _getActiveCount() {
    return ref
            .read(vendorServicesNotifierProvider)
            .valueOrNull
            ?.services
            .where((s) => !s.isArchived)
            .length ??
        0;
  }

  int _getArchivedCount() {
    return ref
            .read(vendorServicesNotifierProvider)
            .valueOrNull
            ?.services
            .where((s) => s.isArchived)
            .length ??
        0;
  }

  List<VendorService> _filterServices(List<VendorService> services) {
    var filtered = services;

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((s) {
        final nameMatch = s.name.toLowerCase().contains(_searchQuery);
        final descMatch =
            s.description?.toLowerCase().contains(_searchQuery) ?? false;
        return nameMatch || descMatch;
      }).toList();
    }

    // Apply status filter
    switch (_filter) {
      case ServiceFilter.active:
        filtered = filtered.where((s) => !s.isArchived).toList();
        break;
      case ServiceFilter.archived:
        filtered = filtered.where((s) => s.isArchived).toList();
        break;
      case ServiceFilter.all:
        break;
    }

    return filtered;
  }

  Map<String, List<VendorService>> _groupAndSortServices(
    List<VendorService> services,
  ) {
    final grouped = <String, List<VendorService>>{};
    for (final service in services) {
      grouped.putIfAbsent(service.categoryId, () => []).add(service);
    }
    return grouped;
  }

  Widget _buildEmptyState(BuildContext context) {
    return EmptyStateWidget(
      icon: Icons.inventory_2_outlined,
      title: _searchQuery.isNotEmpty
          ? t.vendor_services.empty.search.title
          : _filter == ServiceFilter.archived
          ? t.vendor_services.empty.archived.title
          : t.vendor_services.empty.no_services.title,
      subtitle: _searchQuery.isNotEmpty
          ? t.vendor_services.empty.search.subtitle
          : _filter == ServiceFilter.archived
          ? t.vendor_services.empty.archived.subtitle
          : t.vendor_services.empty.no_services.subtitle,
      actionText: _searchQuery.isEmpty && _filter != ServiceFilter.archived
          ? t.vendor_services.empty.no_services.action
          : null,
      onAction: _searchQuery.isEmpty && _filter != ServiceFilter.archived
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SelectCategoryScreen(),
                ),
              );
            }
          : null,
    );
  }

  Widget _buildServicesList(
    BuildContext context,
    Map<String, List<VendorService>> groupedServices,
  ) {
    return RefreshIndicator(
      onRefresh: () =>
          ref.read(vendorServicesNotifierProvider.notifier).refresh(),
      color: AppColors.primary,
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 100),
        itemCount: groupedServices.length,
        itemBuilder: (context, index) {
          final categoryId = groupedServices.keys.elementAt(index);
          final services = groupedServices[categoryId]!;
          return ServicesByCategorySection(
            categoryId: categoryId,
            services: services,
          );
        },
      ),
    );
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
              t.vendor_services.error.title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.onSurface,
              ),
            ),
            const Gap(AppSpacing.sm),
            Text(
              t.vendor_services.error.subtitle,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const Gap(AppSpacing.lg),
            ElevatedButton(
              onPressed: () {
                ref.read(vendorServicesNotifierProvider.notifier).refresh();
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
                t.vendor_services.error.retry,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
