import 'package:app/features/home/presentation/widgets/ad_banners.dart';
import 'package:app/features/home/presentation/widgets/premium_banner.dart';
import 'package:app/features/home/presentation/widgets/top_bar.dart';
import 'package:app/features/services/presentation/widgets/all_services_grid.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class ServicesScreenContent extends StatefulWidget {
  const ServicesScreenContent({super.key});

  @override
  State<ServicesScreenContent> createState() => _ServicesScreenContentState();
}

class _ServicesScreenContentState extends State<ServicesScreenContent> {
  final _searchController = TextEditingController();
  final String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 20, bottom: 90),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(),
          Gap(AppSpacing.md),
          // CustomSearchBar(
          //   controller: _searchController,
          //   onChanged: (value) {
          //     setState(() {
          //       _searchQuery = value.toLowerCase();
          //     });
          //   },
          //   hintText: Translations.of(context).services.screen.search_hint,
          //   isBuyCar: false,
          // ),
          Gap(AppSpacing.lg),
          PremiumBanner(),
          Gap(AppSpacing.lg),
          AdBanners(),
          Gap(AppSpacing.lg),
          Text(
            Translations.of(context).services.screen.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          Gap(AppSpacing.md),
          AllServicesGrid(searchQuery: _searchQuery),
        ],
      ),
    );
  }
}
