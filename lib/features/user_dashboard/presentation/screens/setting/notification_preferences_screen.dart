import 'package:app/core/providers/notification_preferences_provider.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationPreferencesScreen extends ConsumerWidget {
  const NotificationPreferencesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final prefs = ref.watch(notificationPreferencesProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerSection(context),
              const Gap(AppSpacing.lg * 2),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      secondary: const Icon(
                        Icons.shopping_bag_outlined,
                        color: AppColors.primary,
                      ),
                      title: Text(
                        Translations.of(context)
                            .user_dashboard
                            .settings
                            .notification_preferences
                            .order_updates,
                        style: GoogleFonts.poppins(
                          color: theme.colorScheme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: prefs.orderUpdates,
                      activeThumbColor: AppColors.primary,
                      activeTrackColor: AppColors.primary.withValues(
                        alpha: 0.5,
                      ),
                      onChanged: (value) => ref
                          .read(notificationPreferencesProvider.notifier)
                          .setOrderUpdates(value),
                    ),
                    const Divider(
                      color: AppColors.textSecondary,
                      height: 1,
                      indent: 16,
                      endIndent: 16,
                    ),
                    SwitchListTile(
                      secondary: const Icon(
                        Icons.local_offer_outlined,
                        color: AppColors.primary,
                      ),
                      title: Text(
                        Translations.of(context)
                            .user_dashboard
                            .settings
                            .notification_preferences
                            .promotions,
                        style: GoogleFonts.poppins(
                          color: theme.colorScheme.onSurface,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      value: prefs.promotions,
                      activeThumbColor: AppColors.primary,
                      activeTrackColor: AppColors.primary.withValues(
                        alpha: 0.5,
                      ),
                      onChanged: (value) => ref
                          .read(notificationPreferencesProvider.notifier)
                          .setPromotions(value),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFE28C37),
            size: 20,
          ),
        ),
        const Gap(AppSpacing.md),
        AutoSizeText(
          Translations.of(
            context,
          ).user_dashboard.settings.notification_preferences.screen_title,
          style: GoogleFonts.poppins(
            color: theme.colorScheme.onSurface,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
