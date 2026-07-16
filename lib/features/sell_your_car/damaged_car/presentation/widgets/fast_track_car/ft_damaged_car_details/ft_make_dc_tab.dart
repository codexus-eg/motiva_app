import 'package:app/features/sell_your_car/domain/entities/entities.dart';
import 'package:app/features/sell_your_car/presentation/providers/providers.dart';
import 'package:app/shared/ui/inputs/custom_search_bar.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class FtMakeDCTab extends ConsumerStatefulWidget {
  final void Function(CarMake make) onMakeSelected;

  const FtMakeDCTab({super.key, required this.onMakeSelected});

  @override
  ConsumerState<FtMakeDCTab> createState() => _FtMakeDCTabState();
}

class _FtMakeDCTabState extends ConsumerState<FtMakeDCTab> {
  String searchQuery = '';
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final carDataState = ref.watch(carDataNotifierProvider);
    final theme = Theme.of(context);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              Translations.of(context).sell_your_car.make_tab.title,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 18,
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(child: Gap(AppSpacing.lg)),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomSearchBar(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                });
              },
              hintText: Translations.of(
                context,
              ).sell_your_car.make_tab.search_hint,
              isBuyCar: false,
            ),
          ),
        ),

        const SliverToBoxAdapter(child: Gap(AppSpacing.xl)),

        carDataState.when(
          data: (state) {
            if (state is CarDataLoaded) {
              final makes = state.makes;
              final filteredMakes = searchQuery.isEmpty
                  ? makes
                  : makes
                        .where(
                          (m) => m.name.toLowerCase().contains(
                            searchQuery.toLowerCase(),
                          ),
                        )
                        .toList();

              if (filteredMakes.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      searchQuery.isEmpty
                          ? Translations.of(
                              context,
                            ).sell_your_car.make_tab.no_available
                          : Translations.of(
                              context,
                            ).sell_your_car.make_tab.no_found,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.54,
                        ),
                      ),
                    ),
                  ),
                );
              }

              return SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                sliver: SliverGrid(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final make = filteredMakes[index];
                    final isSelected = state.selectedMake?.id == make.id;
                    return GestureDetector(
                      onTap: () => widget.onMakeSelected(make),
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: isSelected
                                ? const Color(0xFFDC8735)
                                : Colors.transparent,
                            width: isSelected ? 2 : 0,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          make.name,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFFDC8735)
                                : theme.colorScheme.onSurface,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }, childCount: filteredMakes.length),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    mainAxisExtent: 90,
                  ),
                ),
              );
            } else if (state is CarDataError) {
              return SliverToBoxAdapter(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        state.message,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const Gap(AppSpacing.md),
                      ElevatedButton(
                        onPressed: () => ref
                            .read(carDataNotifierProvider.notifier)
                            .loadMakes(),
                        child: Text(
                          Translations.of(context).sell_your_car.make_tab.retry,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
            return const SliverToBoxAdapter(child: SizedBox());
          },
          loading: () =>
              SliverToBoxAdapter(child: ShimmerSkeletons.cardSkeleton()),
          error: (error, stack) => SliverToBoxAdapter(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    error.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                  const Gap(AppSpacing.md),
                  ElevatedButton(
                    onPressed: () =>
                        ref.read(carDataNotifierProvider.notifier).loadMakes(),
                    child: Text(
                      Translations.of(context).sell_your_car.make_tab.retry,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
