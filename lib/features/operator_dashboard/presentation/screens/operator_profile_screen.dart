import 'package:app/features/operator_dashboard/presentation/widgets/profile_screen/operator_profile_menu_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class OperatorProfileScreen extends StatelessWidget {
  const OperatorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildOperatorHeader(context),
            Gap(AppSpacing.lg),
            OperatorProfileMenuSection(),
          ],
        ),
      ),
    );
  }
}
Widget _buildOperatorHeader(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.orange,
              child: Text(
                "M",
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
                  "Hi Muhammad!",
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
