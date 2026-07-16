import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class FtPaintConditionDCTab extends StatefulWidget {
  final VoidCallback onContinue;
  final void Function(String paintCondition) onPaintConditionSelected;

  const FtPaintConditionDCTab({
    super.key,
    required this.onContinue,
    required this.onPaintConditionSelected,
  });

  @override
  State<FtPaintConditionDCTab> createState() => _FtPaintConditionDCTabState();
}

class _FtPaintConditionDCTabState extends State<FtPaintConditionDCTab> {
  String selectedPaint = '';

  final List<String> paintConditions = const [
    'Original Paint',
    'Partial Paint',
    'Full Repaint',
    'Full Protection',
    'Paint Protection',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translations.of(context).sell_your_car.paint_condition_tab.title,
            style: TextStyle(
              color: theme.onSurface,
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
          ),
          Gap(AppSpacing.xl),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: paintConditions.length,
              separatorBuilder: (_, _) => const Gap(AppSpacing.md),
              itemBuilder: (context, index) {
                final paint = paintConditions[index];
                final isSelected = selectedPaint == paint;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedPaint = paint;
                    });
                    widget.onPaintConditionSelected(paint);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFDC8735)
                          : theme.primaryContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      paint,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isSelected ? Colors.white : theme.onSurface,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Gap(AppSpacing.lg),
          GradientButton(
            text: Translations.of(
              context,
            ).sell_your_car.paint_condition_tab.kContinue,
            onTap: selectedPaint.isNotEmpty
                ? () {
                    widget.onPaintConditionSelected(selectedPaint);
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
