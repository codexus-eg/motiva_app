import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class ColorsGCTab extends ConsumerStatefulWidget {
  final VoidCallback onContinue;
  final void Function(String color) onColorSelected;

  const ColorsGCTab({
    super.key,
    required this.onContinue,
    required this.onColorSelected,
  });

  @override
  ConsumerState<ColorsGCTab> createState() => _ColorsGCTabState();
}

class _ColorsGCTabState extends ConsumerState<ColorsGCTab> {
  CarColor? selectedExterior;
  CarColor? selectedInterior;

  bool showMoreExterior = false;
  bool showMoreInterior = false;

  bool get isContinueEnabled =>
      selectedExterior != null && selectedInterior != null;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translations.of(context).sell_your_car.colors_tab.title,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
          ),
          const Gap(AppSpacing.lg),

          /// Exterior
          ColorSection(
            title: Translations.of(
              context,
            ).sell_your_car.colors_tab.exterior_title,
            selectedColor: selectedExterior,
            showMore: showMoreExterior,
            onToggleViewMore: () {
              setState(() {
                showMoreExterior = !showMoreExterior;
              });
            },
            onSelect: (color) {
              setState(() {
                if (selectedExterior == color) {
                  selectedExterior = null;
                } else {
                  selectedExterior = color;
                }
              });
            },
          ),

          const Gap(AppSpacing.lg),

          /// Interior
          ColorSection(
            title: Translations.of(
              context,
            ).sell_your_car.colors_tab.interior_title,
            selectedColor: selectedInterior,
            showMore: showMoreInterior,
            onToggleViewMore: () {
              setState(() {
                showMoreInterior = !showMoreInterior;
              });
            },
            onSelect: (color) {
              setState(() {
                if (selectedInterior == color) {
                  selectedInterior = null;
                } else {
                  selectedInterior = color;
                }
              });
            },
          ),

          const Gap(AppSpacing.xl),
          GradientButton(
            text: Translations.of(context).sell_your_car.colors_tab.kContinue,
            onTap: isContinueEnabled
                ? () {
                    if (selectedExterior != null) {
                      widget.onColorSelected(selectedExterior!.label);
                    }
                    widget.onContinue();
                  }
                : null,
          ),
          Gap(AppSpacing.lg),
        ],
      ),
    );
  }
}

class ColorSection extends StatelessWidget {
  final String title;
  final CarColor? selectedColor;
  final bool showMore;
  final VoidCallback onToggleViewMore;
  final Function(CarColor) onSelect;

  const ColorSection({
    super.key,
    required this.title,
    required this.selectedColor,
    required this.showMore,
    required this.onToggleViewMore,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final colors = CarColor.values;
    final visibleColors = showMore ? colors : colors.take(8).toList();
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              fontSize: 16,
            ),
          ),
          const Divider(color: Colors.white24, height: 24),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: visibleColors.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 20,
              crossAxisSpacing: 12,
              childAspectRatio: .8,
            ),
            itemBuilder: (_, index) {
              final color = visibleColors[index];
              final isSelected = selectedColor == color;

              return GestureDetector(
                onTap: () => onSelect(color),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 53,
                          width: 53,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: color.color,
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check,
                            color: theme.colorScheme.onSurface,
                            size: 28,
                          ),
                      ],
                    ),
                    const Gap(AppSpacing.sm),
                    Text(
                      color.translatedLabel(context),
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          if (!showMore)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: theme.colorScheme.primary),
                  minimumSize: const Size(double.infinity, 48),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: onToggleViewMore,
                child: Text(
                  Translations.of(context).sell_your_car.colors_tab.view_more,
                  style: TextStyle(color: theme.colorScheme.primary),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

enum CarColor {
  white("White", Colors.white),
  black("Black", Colors.black),
  orange("Orange", Colors.orange),
  blue("Blue", Colors.blue),
  red("Red", Colors.red),
  green("Green", Colors.green),
  purple("Purple", Colors.purple),
  yellow("Yellow", Colors.yellow),
  aqua("Aqua", Color(0xFF1ED4D4)),
  snow("Snow", Color(0xFFEDEDED)),
  beige("Beige", Color(0xFFDCD7BE)),
  dimGray("DimGray", Color(0xFF6E6E6E));

  final String label;
  final Color color;

  const CarColor(this.label, this.color);

  String translatedLabel(BuildContext context) {
    final t = Translations.of(context).sell_your_car.car_color;
    switch (this) {
      case CarColor.white:
        return t.white;
      case CarColor.black:
        return t.black;
      case CarColor.orange:
        return t.orange;
      case CarColor.blue:
        return t.blue;
      case CarColor.red:
        return t.red;
      case CarColor.green:
        return t.green;
      case CarColor.purple:
        return t.purple;
      case CarColor.yellow:
        return t.yellow;
      case CarColor.aqua:
        return t.aqua;
      case CarColor.snow:
        return t.snow;
      case CarColor.beige:
        return t.beige;
      case CarColor.dimGray:
        return t.dim_gray;
    }
  }
}
