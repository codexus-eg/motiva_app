import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageBottomSheet extends StatefulWidget {
  const LanguageBottomSheet({super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _selectedLanguage = LocaleSettings.currentLocale.languageCode == 'ar'
        ? 'Arabic'
        : 'English';
  }

  Future<void> _setLocale(String language) async {
    final locale = language == 'Arabic' ? AppLocale.ar : AppLocale.en;
    LocaleSettings.setLocale(locale);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('selected_locale', locale.languageCode);
    if (mounted) {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).user_dashboard.settings.language;
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
                  ).user_dashboard.settings.language.title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const Gap(AppSpacing.lg),
            _languageOption(
              t.english,
              _selectedLanguage == 'English',
              () => _setLocale('English'),
              context,
            ),
            const Gap(AppSpacing.md),
            _languageOption(
              t.arabic,
              _selectedLanguage == 'Arabic',
              () => _setLocale('Arabic'),
              context,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _languageOption(
  String label,
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
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
        if (isSelected) Icon(Icons.check, color: AppColors.secondary, size: 20),
      ],
    ),
  );
}
