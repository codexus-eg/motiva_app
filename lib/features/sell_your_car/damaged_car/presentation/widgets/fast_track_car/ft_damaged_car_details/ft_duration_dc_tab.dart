import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/sell_your_car/domain/entities/fast_track_settings.dart';
import 'package:app/features/sell_your_car/presentation/providers/fast_track_notifiers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';

class FtDurationDcTab extends ConsumerStatefulWidget {
  final VoidCallback onSubmit;

  const FtDurationDcTab({super.key, required this.onSubmit});

  @override
  ConsumerState<FtDurationDcTab> createState() => _FtDurationDcTabState();
}

class _FtDurationDcTabState extends ConsumerState<FtDurationDcTab> {
  final Set<int> _selectedOptionIndices = {0};
  static const double _basePrice = 160.0;

  // Fallback options when backend settings are unavailable
  static const List<FastTrackDurationOption> _fallbackOptions = [
    FastTrackDurationOption(hours: 10, discountPercentage: 30, price: 50),
    FastTrackDurationOption(hours: 24, discountPercentage: 25, price: 150),
    FastTrackDurationOption(hours: 72, discountPercentage: 20, price: 200),
  ];

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(fastTrackSettingsNotifierProvider.notifier).fetchSettings();
    });
  }

  double get _totalPrice {
    final settings = ref.watch(fastTrackSettingsNotifierProvider);
    final options = settings.valueOrNull?.options ?? _fallbackOptions;
    double total = _basePrice;
    for (final index in _selectedOptionIndices) {
      if (index < options.length) {
        total += options[index].price;
      }
    }
    return total;
  }

  int get _featuredHours {
    final settings = ref.watch(fastTrackSettingsNotifierProvider);
    final options = settings.valueOrNull?.options ?? _fallbackOptions;
    int hours = 0;
    for (final index in _selectedOptionIndices) {
      if (index < options.length) {
        hours += options[index].hours;
      }
    }
    return hours;
  }

  @override
  Widget build(BuildContext context) {
    final settingsAsync = ref.watch(fastTrackSettingsNotifierProvider);

    return settingsAsync.when(
      loading: () => _buildLoadingState(),
      error: (error, stack) => _buildErrorState(error),
      data: (settings) => _buildContentState(settings),
    );
  }

  Widget _buildLoadingState() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 26,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFDC8735),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Translations.of(
                          context,
                        ).sell_your_car.ft_duration.title,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 20,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const Gap(AppSpacing.md),
                      ...List.generate(
                        3,
                        (index) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: ShimmerSkeletons.cardSkeleton(height: 40),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(AppSpacing.xl),
          _buildBottomBar(fallbackOptions: _fallbackOptions),
          Gap(AppSpacing.xl),
          GradientButton(
            text: Translations.of(
              context,
            ).sell_your_car.ft_duration.submit_request,
            onTap: widget.onSubmit,
          ),
          Gap(AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 26,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFFDC8735),
                      width: 1.5,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline,
                        color: Colors.red.shade300,
                        size: 48,
                      ),
                      const Gap(AppSpacing.md),
                      Text(
                        Translations.of(
                          context,
                        ).sell_your_car.ft_duration.failed_load,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface,
                          fontSize: 16,
                        ),
                      ),
                      const Gap(AppSpacing.md),
                      TextButton(
                        onPressed: () {
                          ref
                              .read(fastTrackSettingsNotifierProvider.notifier)
                              .fetchSettings();
                        },
                        child: Text(
                          Translations.of(
                            context,
                          ).sell_your_car.ft_duration.retry,
                          style: TextStyle(color: Color(0xFFDC8735)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Gap(AppSpacing.xl),
          _buildBottomBar(fallbackOptions: _fallbackOptions),
          Gap(AppSpacing.xl),
          GradientButton(
            text: Translations.of(
              context,
            ).sell_your_car.ft_duration.submit_request,
            onTap: widget.onSubmit,
          ),
          Gap(AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildContentState(FastTrackSettings settings) {
    final options = settings.options.isNotEmpty
        ? settings.options
        : _fallbackOptions;
    final isFallback = settings.options.isEmpty;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                _buildFeatureYourCarSection(
                  options: options,
                  isFallback: isFallback,
                ),
              ],
            ),
          ),
          const Gap(AppSpacing.xl),
          _buildBottomBar(fallbackOptions: null),
          Gap(AppSpacing.xl),
          GradientButton(
            text: Translations.of(
              context,
            ).sell_your_car.ft_duration.submit_request,
            onTap: widget.onSubmit,
          ),
          Gap(AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildFeatureYourCarSection({
    required List<FastTrackDurationOption> options,
    required bool isFallback,
  }) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDC8735), width: 1.5),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -24,
            right: -24,
            bottom: -24,
            child: SvgPicture.asset(
              'assets/images/wallet_card.svg',
              width: 166,
              height: 258,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      Translations.of(context).sell_your_car.ft_duration.title,
                      style: TextStyle(
                        color: theme.onSurface,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  if (isFallback)
                    Tooltip(
                      message: Translations.of(
                        context,
                      ).sell_your_car.ft_duration.fallback_tooltip,
                      child: Icon(
                        Icons.warning_amber,
                        color: Colors.orange.shade700,
                        size: 20,
                      ),
                    ),
                ],
              ),
              const Gap(AppSpacing.md),
              Column(
                children: options.asMap().entries.map((entry) {
                  final index = entry.key;
                  final option = entry.value;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: _buildFeaturedOption(
                      label: Translations.of(context)
                          .sell_your_car
                          .ft_duration
                          .hours_label
                          .replaceAll('{hours}', '${option.hours}')
                          .replaceAll(
                            '{discount}',
                            '${option.discountPercentage.toInt()}',
                          ),
                      isSelected: _selectedOptionIndices.contains(index),
                      onTap: () => _toggleOption(index),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _toggleOption(int index) {
    setState(() {
      if (_selectedOptionIndices.contains(index)) {
        _selectedOptionIndices.remove(index);
      } else {
        _selectedOptionIndices.add(index);
      }
    });
  }

  Widget _buildFeaturedOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: theme.onSurface),
                ),
                child: isSelected
                    ? Icon(Icons.check, size: 14, color: theme.onSurface)
                    : null,
              ),
              const Gap(AppSpacing.md),
              Expanded(
                child: AutoSizeText(
                  label,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: TextStyle(
                    color: theme.onSurface,
                    fontSize: 12,
                    fontFamily: 'Poppins',
                    
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar({List<FastTrackDurationOption>? fallbackOptions}) {
    final theme = Theme.of(context).colorScheme;
    // final settings = ref.watch(fastTrackSettingsNotifierProvider);
    // final options = fallbackOptions ?? (settings.valueOrNull?.options ?? _fallbackOptions);

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Row(
        children: [
          Text(
            Translations.of(context).sell_your_car.ft_duration.total_price,
            style: TextStyle(
              color: theme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Gap(AppSpacing.lg),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: theme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'KD ${_totalPrice.toStringAsFixed(0)}',
              style: const TextStyle(
                color: Color(0xFFD4933A),
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          Gap(AppSpacing.lg),
          if (_featuredHours > 0) ...[
            const Gap(AppSpacing.sm),
            Text(
              '+$_featuredHours',
              style: const TextStyle(
                color: Color(0xFFFF5500),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Gap(AppSpacing.xs),
            const Icon(
              Icons.workspace_premium_outlined,
              color: Color(0xFFFF5500),
              size: 20,
            ),
          ],
        ],
      ),
    );
  }
}
