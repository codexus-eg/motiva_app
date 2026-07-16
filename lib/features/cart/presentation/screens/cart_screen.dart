import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/cart/domain/entities/cart.dart';
import 'package:app/features/cart/domain/entities/cart_item.dart';
import 'package:app/features/cart/presentation/providers/cart_provider.dart';
import 'package:app/features/cart/presentation/screens/checkout_screen.dart';
import 'package:app/features/cart/presentation/widgets/cart_item_card.dart';
import 'package:app/features/home/presentation/screens/home/home_screen.dart';
import 'package:app/shared/ui/buttons/gradient_elevated_button.dart';
import 'package:app/shared/ui/cards/provider_card.dart';
import 'package:app/shared/ui/status_bar/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:google_fonts/google_fonts.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;
    final cartAsync = ref.watch(cartProvider);

    return SystemUiWrapper(
      statusBarColor: theme.surface,
      child: Scaffold(
        backgroundColor: theme.surface,
        body: SafeArea(
          child: Column(
            children: [
              // Header Section
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.md,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Text(
                          t.cart.title,
                          style: GoogleFonts.poppins(
                            color: theme.onSurface,
                            fontSize: 26,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset(
                      'assets/icons/nav_cart.svg',
                      colorFilter: ColorFilter.mode(
                        theme.onSurface,
                        BlendMode.srcIn,
                      ),
                      height: 24,
                    ),
                  ],
                ),
              ),
              const Gap(AppSpacing.lg),
              Expanded(
                child: cartAsync.when(
                  data: (cart) => _CartContent(cart: cart),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (error, stackTrace) => Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Text(
                        '${t.cart.error_loading} $error',
                        style: GoogleFonts.poppins(
                          color: theme.onSurface,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
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

class _CartContent extends ConsumerWidget {
  final Cart cart;

  const _CartContent({required this.cart});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context).colorScheme;

    if (cart.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 80,
                color: theme.onSurface.withValues(alpha: 0.3),
              ),
              const Gap(AppSpacing.lg),
              Text(
                t.cart.empty.title,
                style: GoogleFonts.poppins(
                  color: theme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(AppSpacing.sm),
              Text(
                t.cart.empty.subtitle,
                style: GoogleFonts.poppins(
                  color: theme.onSurface.withValues(alpha: 0.6),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const Gap(AppSpacing.xl),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(initialIndex: 1),
                    ),
                    (route) => false,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFE8C00),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    t.cart.empty.browse_button,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(AppSpacing.lg),
          Text(
            t.cart.delivering_from,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.onSurface,
            ),
          ),
          const Gap(AppSpacing.md),
          ..._buildVendorCards(cart),
          const Gap(AppSpacing.xl),
          Text(
            t.cart.all_items,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const Gap(AppSpacing.md),
          // List of Items from API
          ...cart.items.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: CartItemCard(
                title: item.name,
                description: item.description,
                price: 'KD ${_formatPrice(item.price)}',
                bonusPoints: item.bonusPoints,
                quantity: item.quantity,
                imagePath:
                    item.imageUrl ?? 'assets/images/services_spare_parts.png',
                onIncrement: () =>
                    _updateQuantity(ref, item.id, item.quantity + 1),
                onDecrement: () =>
                    _updateQuantity(ref, item.id, item.quantity - 1),

                onDelete: () => _removeItem(ref, item.id),
              ),
            );
          }),
          const Gap(AppSpacing.xl),
          // Special Request Section
          Text(
            t.cart.special_request,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.onSurface,
            ),
          ),
          const Gap(AppSpacing.md),
          Container(
            height: 96,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              style: GoogleFonts.poppins(fontSize: 14, color: theme.onSurface),
              maxLines: null,
              decoration: InputDecoration(
                hintText: t.cart.special_request_hint,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  color: theme.onSurface.withValues(alpha: 0.5),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
          const Gap(AppSpacing.xl),
          // Apply Promo code Section
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Text(
          //       'APPLY PROMO CODE',
          //       style: GoogleFonts.poppins(
          //         fontSize: 16,
          //         fontWeight: FontWeight.w600,
          //         color: theme.onSurface,
          //       ),
          //     ),
          //     Icon(Icons.keyboard_arrow_down, color: theme.onSurface),
          //   ],
          // ),
          // const Gap(AppSpacing.md),
          // Container(
          //   padding: const EdgeInsets.all(16),
          //   decoration: BoxDecoration(
          //     color: AppColors.surfaceDark,
          //     borderRadius: BorderRadius.circular(10),
          //   ),
          //   child: Row(
          //     children: [
          //       Expanded(
          //         child: Text(
          //           cart.promoCode ?? 'Enter promocode',
          //           style: GoogleFonts.poppins(
          //             fontSize: 14,
          //             color: theme.onSurface,
          //           ),
          //         ),
          //       ),
          //       if (cart.promoCode != null)
          //         const Icon(Icons.check_circle, color: Colors.green, size: 24),
          //     ],
          //   ),
          // ),
          // const Gap(AppSpacing.xl),

          // Summary Section
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFDC8735), width: 1.4),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SummaryRow(
                  label: '${t.cart.price} (${cart.itemCount} ${t.cart.items})',
                  value: '${_formatPrice(cart.totalAmount)} KWD',
                ),
                const Gap(AppSpacing.sm),
                if (cart.discount != null) ...[
                  _SummaryRow(
                    label: t.cart.promo_code,
                    value: '-${_formatPrice(cart.discount!)}',
                    valueColor: AppColors.secondary,
                  ),
                  const Gap(AppSpacing.sm),
                ],
                _SummaryRow(
                  label: t.cart.total_amount,
                  value: 'KWD ${_formatPrice(cart.totalAmount)}',
                  isTotal: true,
                ),
                const Gap(AppSpacing.md),
                if (cart.discount != null)
                  Text(
                    '${t.cart.you_saved} ${_formatPrice(cart.discount!)} ${t.cart.order}',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
              ],
            ),
          ),
          const Gap(AppSpacing.lg),
          GradientElevatedButton(
            text: t.cart.checkout_button,
            textStyle: const TextStyle(
              fontFamily: 'Pepsi',
              fontSize: 20,
              color: Colors.white,
              letterSpacing: 0.2,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CheckoutScreen(cart: cart),
                ),
              );
            },
          ),
          const Gap(90),
        ],
      ),
    );
  }

  void _updateQuantity(WidgetRef ref, String itemId, int newQuantity) {
    if (newQuantity < 1) {
      _removeItem(ref, itemId);
      return;
    }
    ref
        .read(updateCartItemNotifierProvider.notifier)
        .updateItem(itemId, newQuantity);
  }

  void _removeItem(WidgetRef ref, String itemId) {
    ref.read(removeCartItemNotifierProvider.notifier).removeItem(itemId);
  }

  List<Widget> _buildVendorCards(Cart cart) {
    final vendorItems = <String, CartItem>{};
    for (final item in cart.items) {
      if (item.vendorId != null && item.vendorName != null) {
        vendorItems.putIfAbsent(item.vendorId!, () => item);
      }
    }

    if (vendorItems.isEmpty) {
      return [
        ProviderCard(
          logoAsset: 'assets/images/bumper.png',
          title: 'Bumper to Bumper',
          subtitle: t.cart.vendor_subtitle,
          rating: '4.8',
          onTap: () {},
        ),
      ];
    }

    return vendorItems.values.map((item) {
      return ProviderCard(
        logoAsset: item.vendorLogoUrl ?? 'assets/images/bumper.png',
        title: item.vendorName!,
        subtitle: t.cart.vendor_subtitle,
        rating: item.vendorRating ?? '4.8',
        isNetworkImage: item.vendorLogoUrl != null,
        onTap: () {},
      );
    }).toList();
  }

  String _formatPrice(String price) {
    final value = double.tryParse(price);
    if (value == null) return price;
    final intValue = value.toInt();
    if (value == intValue) return intValue.toString();
    return value.toString();
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isTotal;

  const _SummaryRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isTotal = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: theme.onSurface,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: valueColor ?? theme.onSurface,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
