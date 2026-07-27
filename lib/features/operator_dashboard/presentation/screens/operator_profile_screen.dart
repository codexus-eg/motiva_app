import 'package:app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:app/features/auth/presentation/providers/auth_state.dart';
import 'package:app/features/operator_dashboard/presentation/widgets/profile_screen/operator_profile_menu_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class OperatorProfileScreen extends ConsumerWidget {
  const OperatorProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              _buildOperatorHeader(context, ref),
              Gap(AppSpacing.lg),
              OperatorProfileMenuSection(),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildOperatorHeader(BuildContext context, WidgetRef ref) {
  final theme = Theme.of(context).colorScheme;
  final authState = ref.watch(authNotifierProvider);
    
    String operatorName = 'Operator';
    String initial = 'O';
    
    if (authState.value != null && authState.value is AuthAuthenticated) {
      final user = (authState.value as AuthAuthenticated).user;
      if (user.fullName != null && user.fullName!.isNotEmpty) {
        operatorName = user.fullName!;
        initial = operatorName[0].toUpperCase();
      }
    }

  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        children: [
           CircleAvatar(
            radius: 22,
            backgroundColor: Colors.orange,
            child: Text(
              initial,
              style: TextStyle(
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
              Text(
                "Hi $operatorName!",
                style: TextStyle(
                  fontSize: 24,
                  fontFamily: 'Poppins',
                  color: theme.onSurface,
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
                    'Kuwait',
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Poppins',
                      color: theme.onSurface,
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
          onTap: () {},
          child: SvgPicture.asset(
            'assets/icons/notification.svg',
            height: 28,
            width: 28,
          ),
        ),
      ),
    ],
  );
}
