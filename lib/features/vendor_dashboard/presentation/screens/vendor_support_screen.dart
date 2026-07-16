import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/vendor_dashboard/presentation/widgets/support_screen/vendor_faq_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class VendorSupportScreen extends StatefulWidget {
  const VendorSupportScreen({super.key});

  @override
  State<VendorSupportScreen> createState() => _VendorSupportScreenState();
}

class _VendorSupportScreenState extends State<VendorSupportScreen> {
  final Set<int> _expandedFaqs = {0};

  void _toggleFaq(int index) {
    setState(() {
      if (_expandedFaqs.contains(index)) {
        _expandedFaqs.remove(index);
      } else {
        _expandedFaqs.add(index);
      }
    });
  }

  List<VendorFaqItemData> _faqs(BuildContext context) {
    final t = Translations.of(context);
    return [
      VendorFaqItemData(
        question: t.vendor_dashboard.support.faq_1_question,
        answer: t.vendor_dashboard.support.faq_1_answer,
      ),
      VendorFaqItemData(question: t.vendor_dashboard.support.faq_2_question),
      VendorFaqItemData(question: t.vendor_dashboard.support.faq_3_question),
      VendorFaqItemData(question: t.vendor_dashboard.support.faq_4_question),
      VendorFaqItemData(question: t.vendor_dashboard.support.faq_5_question),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerSection(context),
              const Gap(AppSpacing.xl),
              VendorFaqSection(
                faqs: _faqs(context),
                expandedFaqs: _expandedFaqs,
                onToggle: _toggleFaq,
              ),
              const Gap(AppSpacing.xl),
              _vendorContactCard(),
              const Gap(AppSpacing.lg),
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
            Icons.arrow_back_ios_new,
            size: 20,
            color: AppColors.secondary,
          ),
        ),
        const Gap(AppSpacing.md),
        Text(
          t.vendor_dashboard.support.screen_title,
          style: GoogleFonts.poppins(
            color: theme.onSurface,
            fontSize: 26,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _vendorContactCard() {
    final theme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        border: Border.all(color: AppColors.secondary, width: 1.5),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -19,
            right: -19,
            bottom: -19,
            child: SvgPicture.asset(
              'assets/images/wallet_card.svg',
              width: 166,
              height: 230,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Gap(AppSpacing.sm),
              Text(
                t.vendor_dashboard.support.contact_us,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: theme.onSurface,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              const Gap(AppSpacing.sm),
              Text(
                t.vendor_dashboard.support.contact_description,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: theme.onSurface,
                  fontSize: 12,
                  fontWeight: FontWeight.w300,
                  height: 1.5,
                ),
              ),
              const Gap(AppSpacing.xl),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.primary, width: 1.4),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          t.vendor_dashboard.support.email_us,
                          style: GoogleFonts.poppins(
                            color: theme.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Gap(AppSpacing.md),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: const LinearGradient(
                          colors: [Color(0xFFE28C37), Color(0xFF854609)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          t.vendor_dashboard.support.chat,
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(AppSpacing.lg),
              Text(
                t.vendor_dashboard.support.or,
                style: GoogleFonts.poppins(color: theme.onSurface, fontSize: 12),
              ),
              const Gap(AppSpacing.sm),
              Text(
                t.vendor_dashboard.support.submit_ticket,
                style: GoogleFonts.poppins(
                  color: AppColors.secondary,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(AppSpacing.sm),
            ],
          ),
        ],
      ),
    );
  }
}

