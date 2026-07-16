import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/setting/vendor_documents_screen.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/setting/vendor_service_area_screen.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/dialogs/confirmation_dialog.dart';
import 'package:app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:app/features/auth/presentation/widgets/auth_wrapper.dart';
import 'package:app/features/user_dashboard/presentation/screens/setting/app_mode_bottom_sheet.dart';
import 'package:app/features/user_dashboard/presentation/screens/setting/language_bottom_sheet.dart';
import 'package:app/features/user_dashboard/presentation/screens/setting/notification_preferences_screen.dart';
import 'package:app/features/user_dashboard/presentation/widgets/setting/setting_card.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/setting/vendor_business_logo_screen.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/setting/vendor_cover_image_screen.dart';
// import 'package:app/features/vendor_dashboard/presentation/screens/setting/vendor_documents_screen.dart';
// import 'package:app/features/vendor_dashboard/presentation/screens/setting/vendor_service_area_screen.dart';
// import 'package:app/features/vendor_dashboard/presentation/screens/setting/vendor_service_categories_screen.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/setting/vendor_working_hour_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class _VendorSettingItem {
  final String title;
  final VoidCallback? onTap;
  final bool isDestructive;

  _VendorSettingItem({required this.title, this.onTap, this.isDestructive = false});
}

class VendorSettingMenuSection extends ConsumerWidget {
  final String? searchQuery;

  const VendorSettingMenuSection({super.key, this.searchQuery});

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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_dashboard.settings;

    final items = <_VendorSettingItem>[
      _VendorSettingItem(
        title: t.menu.uploaded_documents,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VendorDocumentsScreen(),
            ),
          );
        },
      ),
      _VendorSettingItem(
        title: t.menu.service_area,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VendorServiceAreaScreen(),
            ),
          );
        },
      ),
      _VendorSettingItem(
        title: t.menu.business_logo,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VendorBusinessLogoScreen(),
            ),
          );
        },
      ),
      _VendorSettingItem(
        title: t.menu.cover_image,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VendorCoverImageScreen(),
            ),
          );
        },
      ),
      _VendorSettingItem(
        title: t.menu.working_hours,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const VendorWorkingHourScreen(),
            ),
          );
        },
      ),
      _VendorSettingItem(
        title: t.menu.notifications,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const NotificationPreferencesScreen(),
            ),
          );
        },
      ),
      _VendorSettingItem(
        title: t.menu.language,
        onTap: () => _showLanguageBottomSheet(context),
      ),
      _VendorSettingItem(
        title: t.menu.app_mode,
        onTap: () => _showAppModeBottomSheet(context),
      ),
      _VendorSettingItem(
        title: t.menu.logout,
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
      _VendorSettingItem(
        title: t.menu.delete_account,
        isDestructive: true,
        onTap: () async {
          final confirm = await ConfirmationDialog.show(
            context: context,
            title: Translations.of(context)
                .vendor_dashboard
                .settings
                .delete_account_confirm
                .title,
            message: Translations.of(context)
                .vendor_dashboard
                .settings
                .delete_account_confirm
                .message,
            confirmText: Translations.of(context)
                .vendor_dashboard
                .settings
                .delete_account_confirm
                .confirm,
            cancelText: Translations.of(context)
                .vendor_dashboard
                .settings
                .delete_account_confirm
                .cancel,
            confirmColor: Theme.of(context).colorScheme.error,
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
                          .vendor_dashboard
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
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: filtered.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(
                  t.not_found,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
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
