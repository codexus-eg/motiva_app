import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/theme_provider.dart';
import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class AppModeBottomSheet extends ConsumerWidget {
  const AppModeBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(themeProvider);
    final themeNotifier = ref.read(themeProvider.notifier);

    final selectedAppMode = themeMode == ThemeMode.dark ? 'Dark' : 'Light';
    final t = Translations.of(context).user_dashboard.settings.app_mode;

    void onThemeChanged(String mode) {
      final newMode = mode == 'Dark' ? ThemeMode.dark : ThemeMode.light;
      themeNotifier.setThemeMode(newMode);
    }

    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(24, 20, 24, 32),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
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
                  ).user_dashboard.settings.app_mode.title,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const Gap(AppSpacing.lg),
            _appModeOption(
              t.dark,
              selectedAppMode == 'Dark',
              () => onThemeChanged('Dark'),
              context,
            ),
            const Gap(AppSpacing.md),
            _appModeOption(
              t.light,
              selectedAppMode == 'Light',
              () => onThemeChanged('Light'),
              context,
            ),
          ],
        ),
      ),
    );
  }
}

Widget _appModeOption(
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
      ],
    ),
  );
}
