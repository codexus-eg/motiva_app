import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:app/features/auth/presentation/widgets/auth_wrapper.dart';
import 'package:app/features/user_dashboard/presentation/widgets/setting/setting_card.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/dialogs/confirmation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OperatorProfileMenuSection extends ConsumerWidget {
  const OperatorProfileMenuSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).user_dashboard.settings;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          SettingCard(
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
          const Divider(color: AppColors.textSecondary, height: 1),
          SettingCard(
            title: t.menu.delete_account,
            isDestructive: true,
            onTap: () async {
              final confirm = await ConfirmationDialog.show(
                context: context,
                title: t.delete_account_confirm.title,
                message: t.delete_account_confirm.message,
                confirmText: t.delete_account_confirm.confirm,
                cancelText: t.delete_account_confirm.cancel,
                confirmColor: theme.error,
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
                        content: Text(t.delete_account_confirm.error),
                      ),
                    );
                  }
                }
              }
            },
          ),
        ],
      ),
    );
  }
}