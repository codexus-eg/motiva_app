import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class RunsAndDrivesTab extends StatefulWidget {
  final VoidCallback onContinue;
  final void Function(bool value) onRunsAndDrivesSelected;

  const RunsAndDrivesTab({
    super.key,
    required this.onContinue,
    required this.onRunsAndDrivesSelected,
  });

  @override
  State<RunsAndDrivesTab> createState() => _RunsAndDrivesTabState();
}

class _RunsAndDrivesTabState extends State<RunsAndDrivesTab> {
  bool? selected;

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
                  ).sell_your_car.car_condition.runs_drives_title,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
                const Gap(AppSpacing.xl),
                _buildOption(
                  Translations.of(context).sell_your_car.car_condition.yes,
                  true,
                ),
                const Gap(AppSpacing.md),
                _buildOption(
                  Translations.of(context).sell_your_car.car_condition.no,
                  false,
                ),
              ],
            ),
          ),
          GradientButton(
            onTap: () {
              if (selected != null) {
                widget.onContinue();
              }
            },
            text: Translations.of(context).sell_your_car.mileage_tab.kContinue,
          ),
          const Gap(AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildOption(String label, bool value) {
    final isSelected = selected == value;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        setState(() => selected = value);
        widget.onRunsAndDrivesSelected(value);
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
          label,
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
