import 'package:app/features/cart/domain/entities/delivery_address.dart';
import 'package:app/features/user_dashboard/presentation/screens/setting/edit_address_screen.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class AddressTileWidget extends StatelessWidget {
  final DeliveryAddress address;
  final bool showDivider;

  const AddressTileWidget({
    super.key,
    required this.address,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mutedColor = theme.colorScheme.onSurface.withValues(alpha: 0.6);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditAddressScreen(address: address),
          ),
        );
      },
      child: Container(
        height: 104,
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: showDivider
            ? const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFF4B4C52))),
              )
            : null,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        address.label,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const Gap(AppSpacing.sm),
                      Text(
                        address.area,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: mutedColor,
                        ),
                      ),
                    ],
                  ),
                  const Gap(AppSpacing.sm),
                  Text(
                    '${address.street}, ${Translations.of(context).user_dashboard.settings.address_tile.block.replaceAll('{n}', address.block)}${address.building != null ? ', ${Translations.of(context).user_dashboard.settings.address_tile.building.replaceAll('{n}', address.building!)}' : ''}${address.apartment != null ? ', ${Translations.of(context).user_dashboard.settings.address_tile.apt.replaceAll('{n}', address.apartment!)}' : ''}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      height: 1.4,
                      color: mutedColor,
                    ),
                  ),
                  if (address.phone != null)
                    Text(
                      Translations.of(context)
                          .user_dashboard
                          .settings
                          .address_tile
                          .mobile_number
                          .replaceAll('{n}', address.phone!),
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        height: 1.4,
                        color: mutedColor,
                      ),
                    ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurface,
              size: 22,
            ),
          ],
        ),
      ),
    );
  }
}
