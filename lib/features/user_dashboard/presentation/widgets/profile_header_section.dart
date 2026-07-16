import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:app/features/auth/presentation/providers/auth_state.dart';
import 'package:app/features/user_dashboard/presentation/screens/setting/setting_screen.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auto_size_text/flutter_auto_size_text.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class ProfileHeaderSection extends ConsumerWidget {
  const ProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final authState = ref.watch(authNotifierProvider);

    final User? user = authState.when(
      data: (state) => state is AuthAuthenticated ? state.user : null,
      loading: () => null,
      error: (_, _) => null,
    );

    final t = Translations.of(context).user_dashboard.profile;
    final String displayName = user?.fullName ?? t.guest;
    final String avatarInitial = displayName.isNotEmpty
        ? displayName[0].toUpperCase()
        : t.guest_initial;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.orange,
              child: Text(
                avatarInitial,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Gap(AppSpacing.lg),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  t.greeting.replaceAll('{name}', displayName),
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Poppins',
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/kuwait_flag.png',
                      height: 14.29,
                      width: 13.5,
                    ),
                    Gap(AppSpacing.md),
                    Text(
                      t.location,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingScreen()),
              );
            },
            child: SvgPicture.asset(
              'assets/icons/user_profile/settings.svg',
              height: 28,
              width: 28,
              colorFilter: ColorFilter.mode(
                theme.colorScheme.onPrimaryContainer,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
