import 'package:app/features/cart/domain/entities/delivery_address.dart';
import 'package:app/features/cart/presentation/providers/checkout_provider.dart';
import 'package:app/features/user_dashboard/presentation/screens/setting/edit_address_screen.dart';
import 'package:app/features/user_dashboard/presentation/widgets/setting/Addresses_screen/address_title_widget.dart';
import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class SavedAddressesScreen extends ConsumerWidget {
  const SavedAddressesScreen({super.key});

  static const Color _accentColor = Color(0xFFDC8735);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final savedAddressesAsync = ref.watch(savedAddressesProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const Gap(AppSpacing.xl),
              savedAddressesAsync.when(
                data: (addresses) {
                  if (addresses.isEmpty) {
                    return _buildEmptyState(context);
                  }
                  return _buildAddressList(context, addresses);
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (_, _) => _buildEmptyState(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          tooltip: SemanticLabels.backButton,
          onPressed: () => Navigator.of(context).pop(),
          splashRadius: 20,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: _accentColor,
        ),
        const Gap(AppSpacing.xs),
        Text(
          Translations.of(
            context,
          ).user_dashboard.settings.saved_addresses.screen_title,
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditAddressScreen(),
              ),
            );
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 12),
          ),
          child: Text(
            Translations.of(
              context,
            ).user_dashboard.settings.saved_addresses.add_button,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: _accentColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddressList(
    BuildContext context,
    List<DeliveryAddress> addresses,
  ) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: List.generate(addresses.length, (index) {
              final address = addresses[index];
              final isLast = index == addresses.length - 1;
              return AddressTileWidget(address: address, showDivider: !isLast);
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            children: [
              Text(
                Translations.of(
                  context,
                ).user_dashboard.settings.saved_addresses.empty_title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const Gap(AppSpacing.md),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditAddressScreen(),
                    ),
                  );
                },
                child: Text(
                  Translations.of(
                    context,
                  ).user_dashboard.settings.saved_addresses.add_new_button,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: _accentColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
