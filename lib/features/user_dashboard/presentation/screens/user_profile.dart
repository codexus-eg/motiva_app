import 'package:app/features/user_dashboard/presentation/widgets/profile_header_section.dart';
import 'package:app/features/user_dashboard/presentation/widgets/profile_menu_section.dart';
import 'package:app/features/user_dashboard/presentation/widgets/profile_promo_banner.dart';
import 'package:app/shared/ui/status_bar/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SystemUiWrapper(
      statusBarColor: theme.colorScheme.surface,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ProfileHeaderSection(),
                  Gap(AppSpacing.xl),
                  ProfilePromoBanner(),
                  Gap(AppSpacing.xl),
                  ProfileMenuSection(),
                  Gap(AppSpacing.xl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
