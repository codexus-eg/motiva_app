import 'package:app/features/search/presentation/screens/search_screen.dart';
import 'package:app/features/user_dashboard/presentation/screens/notifications_screen.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).home.customer;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchScreen()),
              );
            },
            child: Container(
              height: 44,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(64),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/search.svg',
                    width: 16,
                    height: 16,
                  ),
                  const Gap(AppSpacing.md),
                  Text(
                    t.search,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFF757575),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const Gap(AppSpacing.md),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotificationsScreen()),
            );
          },
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer, 
              // Color(0xFF2D2F33),
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/icons/notification.svg',
                    width: 16,
                    height: 16,
                  ),
                ),
                Positioned(
                  left: 32,
                  top: 2, // Approximate from Figma
                  child: SvgPicture.asset(
                    'assets/icons/notification_dot.svg',
                    width: 10,
                    height: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
