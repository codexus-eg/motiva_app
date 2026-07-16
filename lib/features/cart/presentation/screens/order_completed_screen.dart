import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/cart/domain/entities/checkout_result.dart';
import 'package:app/shared/ui/buttons/gradient_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class OrderCompletedScreen extends StatelessWidget {
  final CheckoutResult result;

  const OrderCompletedScreen({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final now = DateTime.now();
    final formattedTime = DateFormat('dd MMM yyyy, HH:mm').format(now);

    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Gap(AppSpacing.xl + AppSpacing.lg + AppSpacing.md),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    CustomPaint(
                      painter: ReceiptPainter(color: theme.primaryContainer),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 32,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Gap(AppSpacing.lg + AppSpacing.md),
                            _buildDashedLine(),
                            const Gap(AppSpacing.lg + AppSpacing.sm),
                            Text(
                              t.checkout.order_confirmed,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: theme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Gap(AppSpacing.sm),
                            Text(
                              t.checkout.order_placed,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: theme.onSurface.withValues(alpha: 0.72),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Gap(AppSpacing.lg + AppSpacing.sm),
                            Text(
                              t.checkout.total_payment,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: theme.onSurface.withValues(alpha: 0.72),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Gap(AppSpacing.sm),
                            Text(
                              '${result.total} ${result.currency}',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: theme.onSurface,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Gap(AppSpacing.lg + AppSpacing.sm),
                            _buildPaymentDetails(context, formattedTime),
                            const Gap(AppSpacing.md),
                            if (result.estimatedDelivery.isNotEmpty)
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  border: Border.all(
                                    color: theme.onSurface.withValues(
                                      alpha: 0.16,
                                    ),
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      t.checkout.estimated_delivery,
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        color: theme.onSurface.withValues(
                                          alpha: 0.72,
                                        ),
                                      ),
                                    ),
                                    const Gap(AppSpacing.xs),
                                    Text(
                                      result.estimatedDelivery,
                                      style: GoogleFonts.poppins(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: theme.onSurface,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(top: -60, child: _buildSuccessIcon()),
                  ],
                ),
                const Gap(AppSpacing.lg),
                _buildActionButtons(context),
                const Gap(AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 120,
          height: 120,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.1),
          ),
        ),
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary.withValues(alpha: 0.2),
          ),
        ),
        Container(
          width: 70,
          height: 70,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.primary,
          ),
          child: const Icon(Icons.check, color: AppColors.white, size: 36),
        ),
      ],
    );
  }

  Widget _buildDashedLine() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 6.0;
        const dashSpace = 4.0;
        final dashCount = (boxWidth / (dashWidth + dashSpace)).floor();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: 1,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.16),
                ),
              ),
            );
          }),
        );
      },
    );
  }

  Widget _buildPaymentDetails(BuildContext context, String formattedTime) {
    return Column(
      children: [
        Row(
          children: [
            _buildDetailItem(context, t.checkout.order_number, result.orderId),
            const Gap(AppSpacing.sm + AppSpacing.xs),
            _buildDetailItem(context, t.checkout.payment_time, formattedTime),
          ],
        ),
        const Gap(AppSpacing.sm + AppSpacing.xs),
        Row(
          children: [
            _buildDetailItem(context, t.checkout.payment_method, result.paymentMethod),
            const Gap(AppSpacing.sm + AppSpacing.xs),
            _buildDetailItem(context, t.checkout.items, '${result.itemCount}'),
          ],
        ),
      ],
    );
  }

  Widget _buildDetailItem(BuildContext context, String label, String value, {String? icon}) {
    final theme = Theme.of(context).colorScheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: theme.onSurface.withValues(alpha: 0.16)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: theme.onSurface.withValues(alpha: 0.72),
              ),
            ),
            const Gap(AppSpacing.xs),
            Row(
              children: [
                if (value.startsWith('+')) ...[
                  Text(
                    value,
                    style: GoogleFonts.montserrat(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.secondary,
                    ),
                  ),
                ] else ...[
                  Expanded(
                    child: Text(
                      value,
                      style: GoogleFonts.poppins(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: theme.onSurface,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
                if (icon != null) ...[
                  const Gap(AppSpacing.xs),
                  SvgPicture.asset(
                    icon,
                    width: 12,
                    height: 12,
                    colorFilter: const ColorFilter.mode(
                      AppColors.secondary,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      children: [
        GradientElevatedButton(
          text: t.checkout.continue_shopping,
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          width: double.infinity,
        ),
        const Gap(AppSpacing.md + AppSpacing.sm),
        GradientElevatedButton(
          text: t.checkout.back_home,
          isPrimary: false,
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
          width: double.infinity,
          textStyle: TextStyle(
            fontFamily: 'Pepsi',
            fontSize: 20,
            color: theme.onSurface,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}

class ReceiptPainter extends CustomPainter {
  final Color color;

  ReceiptPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    const double radius = 12.0;
    const double cutoutRadius = 12.0;
    const double cutoutY = 76.0;

    path.moveTo(radius, 0);
    path.lineTo(size.width - radius, 0);
    path.quadraticBezierTo(size.width, 0, size.width, radius);

    // Right cutout
    path.lineTo(size.width, cutoutY - cutoutRadius);
    path.arcToPoint(
      Offset(size.width, cutoutY + cutoutRadius),
      radius: const Radius.circular(cutoutRadius),
      clockwise: false,
    );

    path.lineTo(size.width, size.height - radius);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - radius,
      size.height,
    );
    path.lineTo(radius, size.height);
    path.quadraticBezierTo(0, size.height, 0, size.height - radius);

    // Left cutout
    path.lineTo(0, cutoutY + cutoutRadius);
    path.arcToPoint(
      Offset(0, cutoutY - cutoutRadius),
      radius: const Radius.circular(cutoutRadius),
      clockwise: false,
    );

    path.lineTo(0, radius);
    path.quadraticBezierTo(0, 0, radius, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
