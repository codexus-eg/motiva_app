import 'package:app/shared/ui/status_bar/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SystemUiWrapper(
      statusBarColor: theme.colorScheme.surface,
      child: Scaffold(
        backgroundColor: theme.colorScheme.surface,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildHeader(context),
                Gap(AppSpacing.xl),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      GridView.count(
                        crossAxisCount: 4,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        mainAxisSpacing: 20,
                        crossAxisSpacing: 10,
                        childAspectRatio: 0.75,
                        children: [
                          _buildItem(
                            context,
                            'Accessories',
                            'assets/icons/home/wheel.png',
                            false,
                            () {},
                          ),
                          _buildItem(
                            context,
                            'Repair',
                            'assets/icons/home/hummer.png',
                            false,
                            () {},
                          ),
                          _buildItem(
                            context,
                            'Free Delivery',
                            'assets/icons/home/free_delivery.png',
                            true,
                            () {},
                          ),
                          _buildItem(
                            context,
                            'Assistance',
                            'assets/icons/home/road_assistance.png',
                            false,
                            () {},
                          ),
                          _buildItem(
                            context,
                            'Car Rental',
                            'assets/icons/home/sell_car.png',
                            false,
                            () {},
                          ),
                          _buildItem(
                            context,
                            'Spare Parts',
                            'assets/icons/home/hummer.png',
                            false,
                            () {},
                          ),
                          _buildItem(
                            context,
                            'Car Wash',
                            'assets/icons/home/car_wash.png',
                            false,
                            () {},
                          ),
                          _buildItem(
                            context,
                            'Car Protection',
                            'assets/icons/home/road_assistance.png',
                            false,
                            () {},
                          ),
                        ],
                      ),
                      Gap(AppSpacing.lg),
                      Row(
                        children: [
                          Text(
                            'Trending Offers',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/icons/offers.svg',
                            height: 19,
                            width: 19,
                          ),
                        ],
                      ),
                      Gap(AppSpacing.md),
                      Center(
                        child: Text(
                          'No Offers',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 205,
      width: double.infinity,
      decoration: BoxDecoration(color: theme.colorScheme.surface),
      child: Stack(
        children: [
          // Background Illustration
          Positioned(
            right: -20,
            top: 30,
            bottom: 0,
            child: SizedBox(
              width: 240,
              height: 140,
              child: Image.asset(
                'assets/images/offers.png',
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Header Content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.orange,
                        size: 20,
                      ),
                    ),
                  ),
                  Gap(AppSpacing.sm),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Welcome Text
                      Text(
                        'Welcome to your\nrewards and\noffers',
                        style: GoogleFonts.poppins(
                          fontSize: 26,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                          height: 1.2,
                        ),
                      ),
                      const Gap(AppSpacing.lg),
                      // Explore Partners Button
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFFE28C37), Color(0xFF854609)],
                          ),
                          borderRadius: BorderRadius.circular(8.6),
                        ),
                        child: Text(
                          'Explore Partners',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItem(
    BuildContext context,
    String label,
    String emoji,
    bool isSelected,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(15),
                border: isSelected
                    ? Border.all(color: const Color(0xFFDC8735), width: 2)
                    : null,
              ),
              child: Center(child: Image.asset(emoji, width: 52, height: 52)),
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
