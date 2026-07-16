import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class FtDetailsGCTab extends StatefulWidget {
  final void Function(String description) onDescriptionChanged;

  const FtDetailsGCTab({super.key, required this.onDescriptionChanged});

  @override
  State<FtDetailsGCTab> createState() => _FtDetailsGCTabState();
}

class _FtDetailsGCTabState extends State<FtDetailsGCTab> {
  final TextEditingController _descriptionController = TextEditingController();

  // Feature categories
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

  @override
  void initState() {
    _descriptionController.addListener(_onDescriptionChanged);
    super.initState();
  }

  void _onDescriptionChanged() {
    widget.onDescriptionChanged(_descriptionController.text);
  }

  @override
  void dispose() {
    _descriptionController.removeListener(_onDescriptionChanged);
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDescriptionSection(),
          const Gap(AppSpacing.lg),
          _buildCarFeaturesSection(),
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
          Translations.of(context).sell_your_car.description.title,
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
            style: TextStyle(color: theme.colorScheme.onSurface, fontSize: 14),
            decoration:  InputDecoration(
              hintText: Translations.of(context).sell_your_car.description.hint,
              hintStyle: TextStyle(
                color: Color(0xffC9C9C9),
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
          Translations.of(context).sell_your_car.additional_info.features_title,
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
                      color: theme.colorScheme.onSurface,
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
              ? const Color(0xFFD4933A).withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFD4933A)
                : theme.colorScheme.onSurface.withValues(alpha: 0.7),
          ),
        ),
        child: Text(
          feature,
          style: TextStyle(
            color: isSelected
                ? const Color(0xFFD4933A)
                : theme.colorScheme.onSurface.withValues(alpha: 0.7),
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
