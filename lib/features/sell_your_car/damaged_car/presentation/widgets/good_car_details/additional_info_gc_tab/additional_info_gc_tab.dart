import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/sell_your_car/domain/entities/listing_plan.dart';
import 'package:app/features/sell_your_car/presentation/providers/providers.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/core/theme/spacing.dart';

class AdditionalInfoGCTab extends ConsumerStatefulWidget {
  final void Function(String description) onDescriptionChanged;
  final VoidCallback onSubmit;

  const AdditionalInfoGCTab({
    super.key,
    required this.onDescriptionChanged,
    required this.onSubmit,
  });

  @override
  ConsumerState<AdditionalInfoGCTab> createState() => _EndGCTabState();
}

class _EndGCTabState extends ConsumerState<AdditionalInfoGCTab> {
  final TextEditingController _descriptionController = TextEditingController();

  final Map<String, List<String>> _featureCategories = {
    'Interior': [
      'Navigation System',
      'Sunroof',
      'Touch Screen',
      'Panorama Roof',
      'Steering Wheel Control',
      'Rear Camera',
    ],
    'Exterior': [
      'Alloy Wheels',
      'LED Headlights',
      'Tinted Windows',
      'Roof Rack',
      'Spoiler',
    ],
    'Comfort': [
      'Heated Seats',
      'Ventilated Seats',
      'Memory Seats',
      'Keyless Entry',
      'Auto Climate Control',
    ],
    'Entertainment': [
      'Premium Sound System',
      'Apple CarPlay',
      'Android Auto',
      'Rear Entertainment',
      'USB Ports',
    ],
    'Safety & driver assistance systems': [
      'Lane Assist',
      'Blind Spot Monitor',
      'Parking Sensors',
      'Adaptive Cruise Control',
      'ABS',
    ],
  };

  final Map<String, bool> _expandedCategories = {
    'Interior': true,
    'Exterior': false,
    'Comfort': false,
    'Entertainment': false,
    'Safety & driver assistance systems': false,
  };

  final Set<String> _selectedFeatures = {};

  bool _isSubmitting = false;
  String? _errorMessage;

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  String _labelForPlan(ListingPlan plan) {
    final t = Translations.of(context).sell_your_car.additional_info;
    if (plan.durationUnit == 'WEEKS' && plan.durationCount == 1)
      return t.one_week;
    if (plan.durationUnit == 'WEEKS' && plan.durationCount == 2)
      return t.two_weeks;
    if (plan.durationUnit == 'MONTHS' && plan.durationCount == 1)
      return t.one_month;
    return plan.durationLabel;
  }

  Future<void> _handleSubmit() async {
    if (_isSubmitting) return;

    setState(() {
      _isSubmitting = true;
      _errorMessage = null;
    });

    try {
      widget.onDescriptionChanged(_descriptionController.text);
      widget.onSubmit();

      // The parent will handle the submission via createListingNotifierProvider
      // We listen to state changes in build method
    } catch (e, stackTrace) {
      AppLogger.error('_handleSubmit failed', error: e, stackTrace: stackTrace);
      setState(() {
        _isSubmitting = false;
        _errorMessage = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final createListingState = ref.watch(createListingNotifierProvider);
    final plansAsync = ref.watch(listingPlansNotifierProvider);
    final formState = ref.watch(goodCarFormNotifierProvider);
    final selectedPlanId = formState.selectedPlanId;

    // Listen for state changes
    ref.listen<AsyncValue<CreateListingState>>(createListingNotifierProvider, (
      previous,
      next,
    ) {
      next.when(
        data: (state) {
          if (state is CreateListingSuccess && _isSubmitting) {
            setState(() {
              _isSubmitting = false;
            });
            _showSuccessDialog(state.listingId);
          } else if (state is CreateListingError) {
            setState(() {
              _isSubmitting = false;
              _errorMessage = state.message;
            });
          }
        },
        loading: () {
          // Keep submitting state - already set in _handleSubmit
        },
        error: (error, stack) {
          setState(() {
            _isSubmitting = false;
            _errorMessage = error.toString();
          });
        },
      );
    });

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDescriptionSection(),
          const Gap(AppSpacing.lg),
          _buildCarFeaturesSection(),
          const Gap(AppSpacing.md),
          _buildFeatureYourCarSection(plansAsync, selectedPlanId),
          const Gap(AppSpacing.xl),
          _buildBottomBar(plansAsync, selectedPlanId),
          const Gap(AppSpacing.xl),
          if (_errorMessage != null || createListingState.hasError)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                _errorMessage ?? createListingState.error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          GradientButton(
            text: _isSubmitting ? 'SAVING...' : 'SUBMIT LISTING',
            onTap: _isSubmitting ? null : _handleSubmit,
          ),
          const Gap(AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Gap(AppSpacing.md),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _descriptionController,
            maxLines: null,
            expands: true,
            style: TextStyle(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: 'Write any extra details about your\n Car.',
              hintStyle: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCarFeaturesSection() {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select your car features',
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Gap(AppSpacing.md),
        ..._featureCategories.keys.map(
          (category) => _buildCategoryCard(category),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(String category) {
    final isExpanded = _expandedCategories[category] ?? false;
    final features = _featureCategories[category] ?? [];
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => setState(() {
              _expandedCategories[category] = !isExpanded;
            }),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              child: Row(
                children: [
                  Text(
                    category,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.54,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            const Divider(color: Colors.white12, height: 1),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: features.map((f) => _buildFeatureChip(f)).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildFeatureChip(String feature) {
    final isSelected = _selectedFeatures.contains(feature);
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () => setState(() {
        if (isSelected) {
          _selectedFeatures.remove(feature);
        } else {
          _selectedFeatures.add(feature);
        }
      }),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primary.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface,
          ),
        ),
        child: Text(
          feature,
          style: TextStyle(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.onSurface.withValues(alpha: 0.7),
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureYourCarSection(
    AsyncValue<ListingPlansResponse> plansAsync,
    String? selectedPlanId,
  ) {
    final theme = Theme.of(context);

    return plansAsync.when(
      loading: () => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.primary, width: 1.5),
        ),
        child: const Center(
          child: SizedBox(
            width: 24,
            height: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      ),
      error: (error, _) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.colorScheme.primary, width: 1.5),
        ),
        child: Column(
          children: [
            Text(
              Translations.of(
                context,
              ).sell_your_car.additional_info.feature_your_car,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 20,
                fontFamily: 'Poppins',
              ),
            ),
            const Gap(AppSpacing.sm),
            Text(
              'Failed to load listing plans.',
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 13,
              ),
            ),
            const Gap(AppSpacing.sm),
            TextButton(
              onPressed: () =>
                  ref.read(listingPlansNotifierProvider.notifier).refresh(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (response) {
        final plans = response.getForCondition('GOOD');

        if (plans.isEmpty) {
          return Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: theme.colorScheme.primary, width: 1.5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.workspace_premium_outlined,
                      color: theme.colorScheme.primary,
                      size: 22,
                    ),
                    const Gap(AppSpacing.sm),
                    Text(
                      Translations.of(
                        context,
                      ).sell_your_car.additional_info.feature_your_car,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
                const Gap(AppSpacing.md),
                Text(
                  'No listing plans are currently available. Please contact support.',
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.primary, width: 1.5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.workspace_premium_outlined,
                    color: theme.colorScheme.primary,
                    size: 22,
                  ),
                  const Gap(AppSpacing.sm),
                  Text(
                    Translations.of(
                      context,
                    ).sell_your_car.additional_info.feature_your_car,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 20,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ],
              ),
              const Gap(AppSpacing.sm),
              Text(
                Translations.of(
                  context,
                ).sell_your_car.additional_info.feature_description,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 10,
                  height: 1.4,
                ),
              ),
              const Gap(AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: plans.map((plan) {
                  final isActive = plan.isActive;
                  final isSelected = selectedPlanId == plan.id;
                  return _buildFeaturedOption(
                    label: _labelForPlan(plan),
                    price: 'KD ${plan.price.toStringAsFixed(0)}',
                    isSelected: isSelected,
                    isEnabled: isActive,
                    onTap: isActive
                        ? () {
                            // Use the dedicated setter method (matches the
                            // established pattern used by setMake, setModel, etc.).
                            ref
                                .read(goodCarFormNotifierProvider.notifier)
                                .setSelectedPlanId(isSelected ? null : plan.id);
                          }
                        : null,
                  );
                }).toList(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFeaturedOption({
    required String label,
    required String price,
    required bool isSelected,
    required VoidCallback? onTap,
    bool isEnabled = true,
  }) {
    final theme = Theme.of(context);
    final opacity = isEnabled ? 1.0 : 0.4;
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: opacity,
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
                    color: isSelected
                        ? theme.colorScheme.primary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  child: isSelected
                      ? Icon(
                          Icons.check,
                          size: 14,
                          color: theme.colorScheme.onSurface,
                        )
                      : null,
                ),
                const Gap(AppSpacing.sm),
                Text(
                  label,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Gap(AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary.withValues(alpha: 0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withValues(alpha: 0.54),
                ),
              ),
              child: Text(
                price,
                style: TextStyle(
                  color: isSelected
                      ? theme.colorScheme.primary
                      : theme.colorScheme.onSurface.withValues(alpha: 0.54),
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(
    AsyncValue<ListingPlansResponse> plansAsync,
    String? selectedPlanId,
  ) {
    final theme = Theme.of(context);

    return plansAsync.when(
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
      data: (response) {
        final plans = response.getForCondition('GOOD');
        final selectedPlan = plans
            .where((p) => p.id == selectedPlanId)
            .firstOrNull;
        final totalPrice = selectedPlan?.price;

        return Container(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
          child: Row(
            children: [
              Text(
                Translations.of(
                  context,
                ).sell_your_car.additional_info.total_price,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(AppSpacing.lg),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  totalPrice != null
                      ? 'KD ${totalPrice.toStringAsFixed(0)}'
                      : '—',
                  style: TextStyle(
                    color: theme.colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              if (totalPrice == null) ...[
                const Gap(AppSpacing.sm),
                Text(
                  'Please select a plan',
                  style: TextStyle(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  void _showSuccessDialog(String listingId) {
    final theme = Theme.of(context);
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.primaryContainer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_circle, color: Color(0xFF4CAF50), size: 64),
            const Gap(AppSpacing.md),
            Text(
              'Listing Created Successfully!',
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.sm),
            Text(
              'Your car listing has been saved.\nListing ID: $listingId',
              style: TextStyle(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFDC8735),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
