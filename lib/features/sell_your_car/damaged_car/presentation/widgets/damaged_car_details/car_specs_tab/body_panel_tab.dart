import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class BodyPanelTab extends StatefulWidget {
  final VoidCallback onContinue;
  final void Function(String bodyPanelDamage) onBodyPanelDamageSelected;

  const BodyPanelTab({
    super.key,
    required this.onContinue,
    required this.onBodyPanelDamageSelected,
  });

  @override
  State<BodyPanelTab> createState() => _BodyPanelTabState();
}

class _BodyPanelTabState extends State<BodyPanelTab> {
  String selected = '';

  @override
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
                  Translations.of(context).sell_your_car.body_panel_tab.title,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                  ),
                ),
                Gap(AppSpacing.xl),
                _buildOption(
                  Translations.of(context).sell_your_car.body_panel_tab.yes,
                ),
                Gap(AppSpacing.md),
                _buildOption(
                  Translations.of(context).sell_your_car.body_panel_tab.no,
                ),
                Gap(AppSpacing.md),
                _buildOption(
                  Translations.of(
                    context,
                  ).sell_your_car.body_panel_tab.dont_know,
                ),
              ],
            ),
          ),
          GradientButton(
            onTap: () {
              if (selected.isNotEmpty) {
                widget.onBodyPanelDamageSelected(selected);
                widget.onContinue();
              }
            },
            text: Translations.of(
              context,
            ).sell_your_car.body_panel_tab.kContinue,
          ),
          const Gap(AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildOption(String value) {
    final bool isSelected = selected == value;
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        setState(() {
          selected = value;
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
