import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class MechanicalIssuesTab extends StatefulWidget {
  final VoidCallback onContinue;
  final void Function(String value) onMechanicalIssuesSelected;

  const MechanicalIssuesTab({
    super.key,
    required this.onContinue,
    required this.onMechanicalIssuesSelected,
  });

  @override
  State<MechanicalIssuesTab> createState() => _MechanicalIssuesTabState();
}

class _MechanicalIssuesTabState extends State<MechanicalIssuesTab> {
  String selected = '';

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translations.of(
                    context,
                  ).sell_your_car.car_condition.mechanical_title,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
                Gap(AppSpacing.xl),
                _buildOption(
                  Translations.of(context).sell_your_car.car_condition.yes,
                ),
                Gap(AppSpacing.md),
                _buildOption(
                  Translations.of(context).sell_your_car.car_condition.no,
                ),
                Gap(AppSpacing.md),
                _buildOption(
                  Translations.of(
                    context,
                  ).sell_your_car.car_condition.dont_know,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOption(String value) {
    final bool isSelected = selected == value;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        setState(() => selected = value);
        widget.onMechanicalIssuesSelected(value);

        Future.delayed(const Duration(milliseconds: 150), () {
          widget.onContinue();
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? const Color(0xFFDC8735) : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Text(
          value,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
