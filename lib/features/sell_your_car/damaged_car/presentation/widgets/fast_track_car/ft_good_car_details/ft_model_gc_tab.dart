import 'package:app/features/sell_your_car/domain/entities/entities.dart';
import 'package:app/features/sell_your_car/presentation/providers/providers.dart';
import 'package:app/shared/ui/inputs/custom_search_bar.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class FtModelGCTab extends ConsumerStatefulWidget {
  final void Function(CarModel model) onModelSelected;

  const FtModelGCTab({super.key, required this.onModelSelected});

  @override
  ConsumerState<FtModelGCTab> createState() => _FtModelGCTabState();
}

class _FtModelGCTabState extends ConsumerState<FtModelGCTab> {
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translations.of(context).sell_your_car.model_tab.title,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 18,
                  ),
                ),
                Gap(AppSpacing.lg),
              ],
            ),
          ),

          SliverToBoxAdapter(
            child: Column(
              children: [
                CustomSearchBar(
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  hintText: Translations.of(
                    context,
                  ).sell_your_car.model_tab.search_hint,
                  isBuyCar: false,
                ),
                const Gap(AppSpacing.xl),
              ],
            ),
          ),

          carDataState.when(
            data: (state) {
              if (state is CarDataLoaded) {
                final models = state.models;
                final filteredModels = searchQuery.isEmpty
                    ? models
                    : models
                          .where(
                            (m) => m.name.toLowerCase().contains(
                              searchQuery.toLowerCase(),
                            ),
                          )
                          .toList();

                if (filteredModels.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(32),
                        child: Text(
                          state.selectedMake == null
                              ? Translations.of(
                                  context,
                                ).sell_your_car.model_tab.select_make_first
                              : (searchQuery.isEmpty
                                    ? Translations.of(
                                        context,
                                      ).sell_your_car.model_tab.no_available
                                    : Translations.of(
                                        context,
                                      ).sell_your_car.model_tab.no_found),
                          style: TextStyle(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.54,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final model = filteredModels[index];
                    final isSelected = state.selectedModel?.id == model.id;
                    return GestureDetector(
                      onTap: () => widget.onModelSelected(model),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.symmetric(vertical: 18),
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
                          model.name,
                          style: TextStyle(
                            color: isSelected
                                ? const Color(0xFFDC8735)
                                : theme.colorScheme.onSurface,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                    );
                  }, childCount: filteredModels.length),
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
                          onPressed: () {
                            final currentState = ref.read(
                              carDataNotifierProvider,
                            );
                            currentState.whenData((s) {
                              if (s is CarDataLoaded &&
                                  s.selectedMake != null) {
                                ref
                                    .read(carDataNotifierProvider.notifier)
                                    .loadModels(s.selectedMake!.id);
                              }
                            });
                          },
                          child: Text(
                            Translations.of(
                              context,
                            ).sell_your_car.model_tab.retry,
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
                      onPressed: () {
                        final currentState = ref.read(carDataNotifierProvider);
                        currentState.whenData((s) {
                          if (s is CarDataLoaded && s.selectedMake != null) {
                            ref
                                .read(carDataNotifierProvider.notifier)
                                .loadModels(s.selectedMake!.id);
                          }
                        });
                      },
                      child: Text(
                        Translations.of(context).sell_your_car.model_tab.retry,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
