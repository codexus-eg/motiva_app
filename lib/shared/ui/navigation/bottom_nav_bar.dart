import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/navigation/opertor_nav_items.dart';
import 'package:app/shared/ui/navigation/vendor_nav_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class NavItem {
  final String label;
  final String iconPath;
  final String? translationKey;

  const NavItem({
    required this.label,
    required this.iconPath,
    this.translationKey,
  });
}

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;
  final List<NavItem>? navItems;
  final bool isVendor;
  final bool isOperator;

  static const _defaultCustomerNavItems = [
    NavItem(
      label: 'Home',
      iconPath: 'assets/icons/nav_home.svg',
      translationKey: 'bottom_nav.customer.home',
    ),
    NavItem(
      label: 'Services',
      iconPath: 'assets/icons/nav_services.svg',
      translationKey: 'bottom_nav.customer.services',
    ),
    NavItem(
      label: 'Offers',
      iconPath: 'assets/icons/nav_offers.svg',
      translationKey: 'bottom_nav.customer.offers',
    ),
    NavItem(
      label: 'Cart',
      iconPath: 'assets/icons/nav_cart.svg',
      translationKey: 'bottom_nav.customer.cart',
    ),
    NavItem(
      label: 'Profile',
      iconPath: 'assets/icons/nav_profile.svg',
      translationKey: 'bottom_nav.customer.profile',
    ),
  ];

  const BottomNavBar({
    super.key,
    this.selectedIndex = 0,
    required this.onTap,
    this.navItems,
    this.isVendor = false,
    this.isOperator = false,
  });

  @override
  Widget build(BuildContext context) {
    final items =
        navItems ??
        (isVendor
            ? vendorNavItems
            : isOperator
            ? operatorNavItems
            : _defaultCustomerNavItems);
    final theme = Theme.of(context);

    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      height: 65 + bottomPadding,
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 8,
        bottom: bottomPadding,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.surfaceContainerHighest.withValues(
              alpha: 0.25,
            ),
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: items
            .asMap()
            .entries
            .map(
              (entry) => _buildNavItem(
                entry.value.label,
                entry.value.iconPath,
                entry.value.translationKey,
                entry.key,
                context,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildNavItem(
    String label,
    String iconPath,
    String? translationKey,
    int index,
    BuildContext context,
  ) {
    final bool isSelected = selectedIndex == index;
    final theme = Theme.of(context);
    final resolvedLabel = translationKey != null
        ? context.t[translationKey]
        : label;

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            iconPath,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              isSelected
                  ? theme.colorScheme.onSurface
                  : const Color(0xFF8D8D8D),
              BlendMode.srcIn,
            ),
          ),
          const Gap(AppSpacing.xs),
          Text(
            resolvedLabel,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected
                  ? theme.colorScheme.onSurface
                  : const Color(0xFF8D8D8D),
            ),
          ),
        ],
      ),
    );
  }
}
