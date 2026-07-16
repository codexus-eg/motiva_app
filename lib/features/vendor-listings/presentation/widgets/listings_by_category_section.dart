import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:app/features/service-categories/presentation/providers/service_categories_provider.dart';
import 'package:app/features/vendor-listings/domain/entities/vendor_listing_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/i18n/strings.g.dart';

class ListingsByCategorySection extends ConsumerWidget {
  final String groupKey;
  final List<VendorListingItem> items;
  final Widget Function(VendorListingItem item) itemBuilder;

  const ListingsByCategorySection({
    super.key,
    required this.groupKey,
    required this.items,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final serviceCategoriesAsync = ref.watch(serviceCategoriesProvider);
    final (typeLabel, categoryId) = _parseKey(groupKey);
    final categoryName = _resolveCategoryName(
      t,
      serviceCategoriesAsync.valueOrNull,
      typeLabel,
      categoryId,
    );
    final activeCount = items.where((i) => i.isActive && !i.isArchived).length;
    final inactiveCount = items
        .where((i) => !i.isActive || i.isArchived)
        .length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                categoryName,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: theme.onSurface,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.primaryContainer,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  '$activeCount ${t.vendor_listings.category.active}${inactiveCount > 0 ? ' \u2022 $inactiveCount ${t.vendor_listings.category.inactive}' : ''}',
                  style: GoogleFonts.poppins(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
        const Gap(AppSpacing.md),
        ...items.map(itemBuilder),
      ],
    );
  }

  (String, String) _parseKey(String key) {
    final separatorIndex = key.indexOf(':');
    if (separatorIndex == -1) return ('unknown', 'uncategorized');
    final typeLabel = key.substring(0, separatorIndex);
    final categoryId = key.substring(separatorIndex + 1);
    return (typeLabel, categoryId);
  }

  String _resolveCategoryName(
    Translations t,
    List<ServiceCategory>? categories,
    String typeLabel,
    String categoryId,
  ) {
    if (typeLabel == 'service') {
      if (categories != null) {
        final category = categories
            .where((c) => c.id == categoryId)
            .firstOrNull;
        if (category != null) return category.name;
      }
      return t.vendor_listings.category.services_fallback;
    }
    return t.vendor_listings.category.products_fallback;
  }
}
