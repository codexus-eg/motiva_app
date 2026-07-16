import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class VendorServiceAreaScreen extends StatefulWidget {
  const VendorServiceAreaScreen({super.key});

  @override
  State<VendorServiceAreaScreen> createState() =>
      _VendorServiceAreaScreenState();
}

class _VendorServiceAreaScreenState extends State<VendorServiceAreaScreen> {
  final List<String> _cities = const [
    'Kuwait City',
    'Salmiya',
    'Hawalli',
    'Fahaheel',
    'Jahra',
    'Mangaf',
    'Mahboula',
    'Ahmadi',
  ];

  final Set<String> _selectedCities = {'Kuwait City', 'Hawalli', 'Mahboula'};

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerSection(context),
              const Gap(AppSpacing.lg),
              _searchFieldSection(),
              const Gap(AppSpacing.lg),
              Expanded(
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final city = _cities[index];
                    final isSelected = _selectedCities.contains(city);
                    return _CityTile(
                      label: city,
                      isSelected: isSelected,
                      onTap: () => setState(() {
                        if (isSelected) {
                          _selectedCities.remove(city);
                        } else {
                          _selectedCities.add(city);
                        }
                      }),
                    );
                  },
                  separatorBuilder: (_, _) => const Gap(AppSpacing.lg),
                  itemCount: _cities.length,
                ),
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
          child: Icon(
            Icons.arrow_back_ios_new,
            color: AppColors.orange,
            size: 20,
          ),
        ),
        const Gap(AppSpacing.md),
        Text(
          t.vendor_dashboard.service_area.screen_title,
          style: GoogleFonts.poppins(
            color: theme.onSurface,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _searchFieldSection() {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Container(
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(64),
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/search.svg',
            width: 18,
            height: 18,
            colorFilter: const ColorFilter.mode(
              Color(0xFF757575),
              BlendMode.srcIn,
            ),
          ),
          const Gap(AppSpacing.md),
          Text(
            t.vendor_dashboard.service_area.search_hint,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFF757575),
            ),
          ),
        ],
      ),
    );
  }
}

class _CityTile extends StatelessWidget {
  const _CityTile({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _Checkbox(isSelected: isSelected),
          const Gap(AppSpacing.md),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? const Color(0xFFDC8735) : theme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Checkbox extends StatelessWidget {
  const _Checkbox({required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeInOut,
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: isSelected
              ? theme.onSurface
              : theme.onSurface.withValues(alpha: 0.7),
          width: 1.2,
        ),
      ),
      child: isSelected
          ? Icon(Icons.check, size: 14, color: theme.onSurface)
          : null,
    );
  }
}
