import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class VendorServiceCategoriesScreen extends StatelessWidget {
  const VendorServiceCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerSection(context),
              const Gap(AppSpacing.lg),
              _serviceCategoriesGrid(context),
              const Spacer(),
              GradientButton(
                text: t.vendor_dashboard.service_categories.add_new,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.secondary,
            size: 24,
          ),
        ),
        const Gap(AppSpacing.md),
        Text(
          t.vendor_dashboard.service_categories.screen_title,
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: theme.onSurface,
            height: 1.34,
          ),
        ),
      ],
    );
  }

  Widget _serviceCategoriesGrid(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 24,
      childAspectRatio: 0.8,
      children: [
        _serviceCategoryCard('Oil Filters', context),
        _serviceCategoryCard('Fix my Car', context),
        _serviceCategoryCard('Car Batteries', context),
      ],
    );
  }

  Widget _serviceCategoryCard(String title, BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.transparent,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 135,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.surface.withValues(alpha: 0.8),
                  theme.surface.withValues(alpha: 0.6),
                ],
              ),
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary.withValues(alpha: .2),
                      AppColors.secondary.withValues(alpha: .1),
                    ],
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    _getImageAssetForCategory(title),
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 54,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.primaryContainer,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Text(
                title,
                style: GoogleFonts.poppins(
                  color: theme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getImageAssetForCategory(String title) {
    switch (title) {
      case 'Oil Filters':
        return 'assets/images/listing_thumb_1.png';
      case 'Fix my Car':
        return 'assets/images/fix_my_car.png';
      case 'Car Batteries':
        return 'assets/images/car_batteries.png';
      default:
        return 'assets/images/services_accessories.png';
    }
  }
}
