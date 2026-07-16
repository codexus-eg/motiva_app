import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class DurationOATab extends StatefulWidget {
  const DurationOATab({super.key});

  @override
  State<DurationOATab> createState() => _DurationOATabState();
}

class _DurationOATabState extends State<DurationOATab> {
  bool _isFeatured = true;
  bool _is3days = true;
  bool _is5days = false;
  bool _is7days = false;

  static const double _basePrice = 160.0;
  static const double _featurePrice = 50.0;

  double get _totalPrice {
    double total = _basePrice;
    if (_isFeatured) total += _featurePrice;
    return total;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translations.of(context).sell_your_car.duration_tab.title,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const Gap(AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildRadioOption(
                label: Translations.of(
                  context,
                ).sell_your_car.duration_tab.days_3,
                isSelected: _is3days,
                onTap: () => setState(() {
                  _is3days = true;
                  _is5days = false;
                  _is7days = false;
                }),
              ),
              _buildRadioOption(
                label: Translations.of(
                  context,
                ).sell_your_car.duration_tab.days_5,
                isSelected: _is5days,
                onTap: () => setState(() {
                  _is3days = false;
                  _is5days = true;
                  _is7days = false;
                }),
              ),
              _buildRadioOption(
                label: Translations.of(
                  context,
                ).sell_your_car.duration_tab.days_7,
                isSelected: _is7days,
                onTap: () => setState(() {
                  _is3days = false;
                  _is5days = false;
                  _is7days = true;
                }),
              ),
            ],
          ),
          const Gap(AppSpacing.lg),
          Text(
            Translations.of(context).sell_your_car.duration_tab.auction_start,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const Gap(AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Translations.of(
                    context,
                  ).sell_your_car.duration_tab.starting_price,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Poppins',
                  ),
                ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: const Color(0xFFE28C37),
                      child: Icon(Icons.add, color: Colors.white, size: 15),
                    ),
                    Gap(AppSpacing.md),
                    Text(
                      'KWD 200',
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    Gap(AppSpacing.md),
                    CircleAvatar(
                      radius: 10,
                      backgroundColor: const Color(0xFFE28C37),
                      child: Icon(Icons.remove, color: Colors.white, size: 15),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(AppSpacing.lg),
          _buildFeatureSection(),
          const Gap(AppSpacing.xl),
          _buildBottomBar(),
          const Gap(AppSpacing.lg),
          GradientButton(
            text: Translations.of(
              context,
            ).sell_your_car.duration_tab.proceed_payment,
            onTap: () {},
          ),
          const Gap(AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildRadioOption({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(30),
      child: Row(
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: isSelected
                  ? const Color(0xFF65558F).withValues(alpha: 0.12)
                  : theme.colorScheme.onSurface.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 24,
                width: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                  color: isSelected
                      ? theme.colorScheme.onSurface
                      : Colors.transparent,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureSection() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      height: 156,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDC8735), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _isFeatured = !_isFeatured),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    color: _isFeatured
                        ? const Color(0xFFDC8735)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(3),
                    border: Border.all(
                      color: _isFeatured
                          ? const Color(0xFFDC8735)
                          : theme.colorScheme.onSurface,
                      width: 1.5,
                    ),
                  ),
                  child: _isFeatured
                      ? const Icon(Icons.check, size: 12, color: Colors.white)
                      : null,
                ),
              ),
              const Gap(AppSpacing.md),
              Text(
                Translations.of(
                  context,
                ).sell_your_car.duration_tab.feature_auction,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  fontFamily: 'Poppins',
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.lg),
          Text(
            Translations.of(
              context,
            ).sell_your_car.duration_tab.feature_description,
            style: TextStyle(
              color: theme.colorScheme.onPrimaryContainer,
              fontSize: 10,
              height: 1.4,
              fontFamily: 'Montserrat',
              letterSpacing: 0.15,
            ),
          ),
          const Gap(AppSpacing.lg),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(color: const Color(0xFFDC8735)),
            ),
            child: const Text(
              '+ KD 50',
              style: TextStyle(
                color: Color(0xFFDC8735),
                fontSize: 10,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar() {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
      child: Row(
        children: [
          Text(
            Translations.of(context).sell_your_car.duration_tab.total_price,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
          const Gap(AppSpacing.lg),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'KD ${_totalPrice.toStringAsFixed(0)}',
              style: const TextStyle(
                color: Color(0xFFFE8C00),
                fontSize: 18,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
              ),
            ),
          ),
          const Gap(AppSpacing.lg),
          if (_isFeatured) ...[
            const Text(
              '+ 3',
              style: TextStyle(
                color: Color(0xFFFF5500),
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'Montserrat',
              ),
            ),
            const Gap(AppSpacing.xs),
            const Icon(
              Icons.workspace_premium_outlined,
              color: Color(0xFFFF5500),
              size: 24,
            ),
          ],
        ],
      ),
    );
  }
}
