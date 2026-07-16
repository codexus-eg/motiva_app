import 'package:app/features/user_dashboard/presentation/widgets/setting/setting_menu_section.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _searchAndNotificationBar(context),
              const Gap(AppSpacing.lg),
              _headerSection(context),
              const Gap(AppSpacing.lg),
              SettingMenuSection(searchQuery: _searchController.text),
              const Gap(AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchAndNotificationBar(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: _isSearching
              ? Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(64),
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            _isSearching = false;
                            _searchController.clear();
                          });
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFF757575),
                          size: 20,
                        ),
                      ),
                      const Gap(AppSpacing.md),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          autofocus: true,
                          onChanged: (_) => setState(() {}),
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: theme.colorScheme.onSurface,
                          ),
                          decoration: InputDecoration(
                            hintText: Translations.of(
                              context,
                            ).user_dashboard.settings.search_hint,
                            hintStyle: GoogleFonts.poppins(
                              fontSize: 14,
                              color: const Color(0xFF757575),
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      if (_searchController.text.isNotEmpty)
                        GestureDetector(
                          onTap: () =>
                              setState(() => _searchController.clear()),
                          child: const Icon(
                            Icons.clear,
                            color: Color(0xFF757575),
                            size: 18,
                          ),
                        ),
                    ],
                  ),
                )
              : GestureDetector(
                  onTap: () => setState(() => _isSearching = true),
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
                          Translations.of(
                            context,
                          ).user_dashboard.settings.search_hint,
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
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
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
                top: 2,
                child: SvgPicture.asset(
                  'assets/icons/notification_dot.svg',
                  width: 10,
                  height: 10,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _headerSection(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: Color(0xFFE28C37),
            size: 20,
          ),
        ),
        const Gap(AppSpacing.md),
        Text(
          Translations.of(context).user_dashboard.settings.screen_title,
          style: GoogleFonts.poppins(
            color: theme.colorScheme.onSurface,
            fontSize: 26,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
