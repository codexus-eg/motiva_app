import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class CountryBottomSheet extends StatefulWidget {
  const CountryBottomSheet({super.key});

  @override
  State<CountryBottomSheet> createState() => _CountryBottomSheetState();
}

class _CountryBottomSheetState extends State<CountryBottomSheet> {
  String _selectedCountry = 'Kuwait';

  List<Widget> _buildCountryOptions(BuildContext context) {
    final t = Translations.of(context).user_dashboard.settings.country;
    final countries = [
      {
        'key': 'Kuwait',
        'label': t.kuwait,
        'flag': 'assets/images/kuwait_flag.png',
      },
      {
        'key': 'Bahrain',
        'label': t.bahrain,
        'flag': 'assets/images/bahrain_flag.png',
      },
      {'key': 'UAE', 'label': t.uae, 'flag': 'assets/images/uae_flag.png'},
      {'key': 'Oman', 'label': t.oman, 'flag': 'assets/images/oman_flag.png'},
      {
        'key': 'Qatar',
        'label': t.qatar,
        'flag': 'assets/images/qatar_flag.png',
      },
      {
        'key': 'Saudi Arabia',
        'label': t.saudi_arabia,
        'flag': 'assets/images/saudi_arabia_flag.png',
      },
    ];
    return [
      for (var i = 0; i < countries.length; i++) ...[
        _countryOption(
          countries[i]['label']!,
          countries[i]['flag']!,
          _selectedCountry == countries[i]['key']!,
          () => setState(() => _selectedCountry = countries[i]['key']!),
          context,
        ),
        if (i < countries.length - 1) const Gap(AppSpacing.md),
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  tooltip: SemanticLabels.closeButton,
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(
                    Icons.close,
                    color: theme.colorScheme.onSurface,
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
                const Gap(AppSpacing.md),
                Text(
                  Translations.of(
                    context,
                  ).user_dashboard.settings.country.title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const Gap(AppSpacing.lg),
            ..._buildCountryOptions(context),
          ],
        ),
      ),
    );
  }
}

Widget _countryOption(
  String label,
  String icon,
  bool isSelected,
  VoidCallback onTap,
  BuildContext context,
) {
  final theme = Theme.of(context);
  return GestureDetector(
    onTap: onTap,
    child: Row(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          width: 3,
          height: 32,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.secondary : Colors.transparent,
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        const Gap(AppSpacing.md),
        Expanded(
          child: Row(
            children: [
              Image.asset(icon, width: 15, height: 15),
              Gap(8),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
