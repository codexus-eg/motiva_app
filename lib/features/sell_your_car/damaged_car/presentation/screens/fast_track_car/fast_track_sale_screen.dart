import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/sell_your_car/damaged_car/presentation/screens/fast_track_car/fast_track_condition_screen.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class FastTrackCarSaleScreen extends StatefulWidget {
  const FastTrackCarSaleScreen({super.key});

  @override
  State<FastTrackCarSaleScreen> createState() => _FastTrackCarSaleScreenState();
}

class _FastTrackCarSaleScreenState extends State<FastTrackCarSaleScreen> {
  bool isApproved = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).sell_your_car.screens.fast_track_sale;
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Stack(
        children: [
          // Background image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 300,
            child: Image.asset(
              "assets/images/fast_track_car.png",
              fit: BoxFit.cover,
              color: Colors.black.withValues(alpha: 0.3),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          // Content
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Gap(AppSpacing.xl),
                // Title and subtitle
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.title,
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Pepsi',
                        ),
                      ),
                      Gap(AppSpacing.md),
                      Text(
                        t.subtitle,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(AppSpacing.lg),
                // Sheet
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            height: 4,
                            width: 50,
                            decoration: BoxDecoration(
                              color: theme.colorScheme.onSurface,
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),

                        const Gap(AppSpacing.lg),

                        Text(
                          t.description_title,
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.colorScheme.onSurface,
                            fontFamily: 'Poppins',
                          ),
                        ),

                        const Gap(AppSpacing.md),

                        Text(
                          t.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xffA8A8A8),
                            fontFamily: 'Poppins',
                          ),
                        ),

                        const Gap(AppSpacing.xl),

                        Text(
                          t.terms_title,
                          style: TextStyle(
                            fontSize: 16,
                            color: theme.colorScheme.onSurface,
                            fontFamily: 'Poppins',
                          ),
                        ),

                        const Gap(AppSpacing.md),

                        Text(
                          t.terms_intro,
                          style: TextStyle(
                            fontSize: 14,
                            color: Color(0xffA8A8A8),
                            fontFamily: 'Poppins',
                          ),
                        ),

                        const Gap(AppSpacing.md),

                        _buildBullet(t.bullet_1),
                        _buildBullet(t.bullet_2),
                        _buildBullet(t.bullet_3),
                        _buildBullet(t.bullet_4),
                        _buildBullet(t.bullet_5),

                        const Gap(AppSpacing.lg),

                        Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white24),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Checkbox(
                                value: isApproved,
                                activeColor: Colors.orange,
                                onChanged: (value) {
                                  setState(() {
                                    isApproved = value ?? false;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(
                                  t.approve_checkbox,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: theme.colorScheme.onSurface,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Gap(AppSpacing.xl),

                        GradientButton(
                          text: t.kContinue,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const FastTrackConditionScreen(),
                              ),
                            );
                          },
                        ),
                        Gap(AppSpacing.lg),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "•  ",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xffA8A8A8),
              fontFamily: 'Poppins',
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                color: Color(0xffA8A8A8),
                fontFamily: 'Poppins',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
