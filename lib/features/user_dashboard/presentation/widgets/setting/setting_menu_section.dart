import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:app/features/auth/presentation/widgets/auth_wrapper.dart';
import 'package:app/shared/ui/dialogs/confirmation_dialog.dart';
import 'package:app/features/user_dashboard/presentation/screens/setting/account_info_screen.dart';
import 'package:app/features/user_dashboard/presentation/screens/setting/app_mode_bottom_sheet.dart';
// import 'package:app/features/user_dashboard/presentation/screens/setting/country_bottom_sheet.dart';
import 'package:app/features/user_dashboard/presentation/screens/setting/language_bottom_sheet.dart';
import 'package:app/features/user_dashboard/presentation/screens/setting/change_email_screen.dart';
import 'package:app/features/user_dashboard/presentation/screens/setting/change_password_screen.dart';
import 'package:app/features/user_dashboard/presentation/screens/setting/saved_addresses_screen.dart';
import 'package:app/features/user_dashboard/presentation/screens/setting/notification_preferences_screen.dart';
import 'package:app/features/user_dashboard/presentation/widgets/setting/setting_card.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _SettingItem {
  final String title;
  final VoidCallback? onTap;
  final bool isDestructive;

  _SettingItem({required this.title, this.onTap, this.isDestructive = false});
}

class SettingMenuSection extends ConsumerWidget {
  final String? searchQuery;

  const SettingMenuSection({super.key, this.searchQuery});

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const LanguageBottomSheet(),
    );
  }

  void _showAppModeBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (_) => const AppModeBottomSheet(),
    );
  }

  // void _showCountryBottomSheet(BuildContext context) {
  //   showModalBottomSheet<void>(
  //     context: context,
  //     barrierColor: Colors.black.withValues(alpha: 0.6),
  //     backgroundColor: Colors.transparent,
  //     isScrollControlled: true,
  //     builder: (_) => const CountryBottomSheet(),
  //   );
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    final t = Translations.of(context).user_dashboard.settings.menu;
    final items = <_SettingItem>[
      _SettingItem(
        title: t.account_info,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AccountInfoScreen()),
          );
        },
      ),
      _SettingItem(
        title: t.saved_addresses,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SavedAddressesScreen(),
            ),
          );
        },
      ),
      _SettingItem(
        title: t.change_email,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ChangeEmailScreen()),
          );
        },
      ),
      _SettingItem(
        title: t.change_password,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChangePasswordScreen(),
            ),
          );
        },
      ),
      // _SettingItem(
      //   title: t.country,
      //   onTap: () => _showCountryBottomSheet(context),
      // ),
      _SettingItem(
        title: t.notifications,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotificationPreferencesScreen(),
            ),
          );
        },
      ),
      _SettingItem(
        title: t.language,
        onTap: () => _showLanguageBottomSheet(context),
      ),
      _SettingItem(
        title: t.app_mode,
        onTap: () => _showAppModeBottomSheet(context),
      ),
      _SettingItem(
        title: t.logout,
        onTap: () async {
          await ref.read(authNotifierProvider.notifier).logout();
          if (context.mounted) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (_) => const AuthWrapper()),
              (route) => false,
            );
          }
        },
      ),
      _SettingItem(
        title: t.delete_account,
        isDestructive: true,
        onTap: () async {
          final confirm = await ConfirmationDialog.show(
            context: context,
            title: Translations.of(context)
                .user_dashboard
                .settings
                .delete_account_confirm
                .title,
            message: Translations.of(context)
                .user_dashboard
                .settings
                .delete_account_confirm
                .message,
            confirmText: Translations.of(context)
                .user_dashboard
                .settings
                .delete_account_confirm
                .confirm,
            cancelText: Translations.of(context)
                .user_dashboard
                .settings
                .delete_account_confirm
                .cancel,
            confirmColor: theme.colorScheme.error,
          );
          if (confirm == true && context.mounted) {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );

            final success = await ref
                .read(authNotifierProvider.notifier)
                .deleteAccount();

            if (context.mounted) {
              Navigator.pop(context); // pop loading dialog
              if (success) {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (_) => const AuthWrapper()),
                  (route) => false,
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      Translations.of(context)
                          .user_dashboard
                          .settings
                          .delete_account_confirm
                          .error,
                    ),
                  ),
                );
              }
            }
          }
        },
      ),
    ];

    final query = (searchQuery ?? '').trim().toLowerCase();
    final filtered = query.isEmpty
        ? items
        : items
              .where((item) => item.title.toLowerCase().contains(query))
              .toList();

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: filtered.isEmpty
          ?  Padding(
              padding: EdgeInsets.all(24),
              child: Center(
                child: Text(
                  Translations.of(context).user_dashboard.settings.not_found,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            )
          : Column(
              children: [
                for (var i = 0; i < filtered.length; i++) ...[
                  SettingCard(
                    title: filtered[i].title,
                    onTap: filtered[i].onTap,
                    isDestructive: filtered[i].isDestructive,
                  ),
                  if (i < filtered.length - 1)
                    const Divider(color: AppColors.textSecondary, height: 1),
                ],
              ],
            ),
    );
  }
}
