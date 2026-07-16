import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/cart/domain/entities/cart.dart';
import 'package:app/features/cart/domain/entities/delivery_address.dart';
import 'package:app/features/cart/data/models/delivery_address_model.dart';
import 'package:app/features/cart/presentation/providers/cart_provider.dart';
import 'package:app/features/cart/presentation/providers/checkout_provider.dart';
import 'package:app/features/cart/presentation/screens/order_completed_screen.dart';
import 'package:app/features/cart/presentation/widgets/payment_method_tile.dart';
import 'package:app/shared/ui/buttons/gradient_elevated_button.dart';
import 'package:app/shared/ui/status_bar/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uuid/uuid.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  final Cart cart;

  const CheckoutScreen({super.key, required this.cart});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  int _selectedPaymentMethod = 2;
  DeliveryAddress? _selectedAddress;
  final _voucherController = TextEditingController();
  bool _voucherApplied = false;
  bool _useWallet = false;

  @override
  void dispose() {
    _voucherController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final savedAddressesAsync = ref.watch(savedAddressesProvider);
    final walletBalance = ref.watch(walletBalanceProvider);
    final checkoutState = ref.watch(checkoutNotifierProvider);

    ref.listen<AsyncValue<dynamic>>(checkoutNotifierProvider, (previous, next) {
      next.whenOrNull(
        data: (result) {
          ref.read(clearCartNotifierProvider.notifier).clearCart();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OrderCompletedScreen(result: result),
            ),
          );
        },
        error: (error, _) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error.toString(),
                style: GoogleFonts.poppins(color: Colors.white),
              ),
              backgroundColor: Colors.red.shade800,
            ),
          );
        },
      );
    });

    return SystemUiWrapper(
      statusBarColor: theme.surface,
      child: Scaffold(
        backgroundColor: theme.surface,
        body: SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: theme.onSurface,
                          size: 20,
                        ),
                      ),
                    ),
                    const Gap(AppSpacing.sm),
                    Text(
                      t.checkout.title,
                      style: GoogleFonts.poppins(
                        color: theme.onSurface,
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(AppSpacing.lg),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Order Summary
                      Text(
                        t.checkout.order_summary,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.onSurface,
                        ),
                      ),
                      const Gap(AppSpacing.md),
                      ...widget.cart.items.map((item) {
                        return _OrderSummaryItem(
                          name: item.name,
                          quantity: item.quantity,
                          price: item.price,
                        );
                      }),
                      const Gap(AppSpacing.sm),
                      _buildSummaryRow(
                        t.checkout.subtotal,
                        'KWD ${_formatPrice(widget.cart.totalAmount)}',
                      ),
                      const Gap(AppSpacing.xs),
                      _buildSummaryRow(
                        t.checkout.delivery_fee,
                        'KWD 0.500',
                        valueColor: AppColors.secondary,
                      ),
                      if (_voucherApplied) ...[
                        const Gap(AppSpacing.xs),
                        _buildSummaryRow(
                          t.checkout.voucher_discount,
                          '-KWD 1.00',
                          valueColor: AppColors.secondary,
                        ),
                      ],
                      if (_useWallet) ...[
                        const Gap(AppSpacing.xs),
                        _buildSummaryRow(
                          t.checkout.wallet_used,
                          '-KWD 2.50',
                          valueColor: AppColors.secondary,
                        ),
                      ],
                      const Divider(
                        height: AppSpacing.lg,
                        color: AppColors.textSecondary,
                      ),
                      _buildSummaryRow(
                        t.checkout.total,
                        'KWD ${_calculateTotal()}',
                        isBold: true,
                      ),
                      const Gap(AppSpacing.xl),

                      // Delivery Address
                      Text(
                        t.checkout.delivery_address,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.onSurface,
                        ),
                      ),
                      const Gap(AppSpacing.md),
                      savedAddressesAsync.when(
                        data: (addresses) {
                          if (addresses.isEmpty) {
                            return _buildAddAddressButton();
                          }
                          return Column(
                            children: [
                              ...addresses.map((address) {
                                return _AddressTile(
                                  address: address,
                                  isSelected:
                                      _selectedAddress?.id == address.id,
                                  onTap: () => setState(
                                    () => _selectedAddress = address,
                                  ),
                                );
                              }),
                              const Gap(AppSpacing.sm),
                              _buildAddAddressButton(),
                            ],
                          );
                        },
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (_, __) => _buildAddAddressButton(),
                      ),
                      const Gap(AppSpacing.xl),

                      // Voucher
                      Text(
                        t.checkout.voucher_code,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.onSurface,
                        ),
                      ),
                      const Gap(AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.md,
                              ),
                              decoration: BoxDecoration(
                                color: theme.primaryContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: TextField(
                                controller: _voucherController,
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: theme.onSurface,
                                ),
                                decoration: InputDecoration(
                                  hintText: t.checkout.enter_voucher,
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: theme.onSurface.withValues(
                                      alpha: 0.5,
                                    ),
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          const Gap(AppSpacing.sm),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _voucherApplied =
                                    _voucherController.text.isNotEmpty;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.secondary,
                              foregroundColor: AppColors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.lg,
                                vertical: AppSpacing.md,
                              ),
                            ),
                            child: Text(
                              'Apply',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (_voucherApplied) ...[
                        const Gap(AppSpacing.sm),
                        Text(
                          t.checkout.voucher_applied,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppColors.secondary,
                          ),
                        ),
                      ],
                      const Gap(AppSpacing.xl),

                      // Wallet
                      Text(
                        t.checkout.wallet_balance,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.onSurface,
                        ),
                      ),
                      const Gap(AppSpacing.md),
                      GestureDetector(
                        onTap: () => setState(() => _useWallet = !_useWallet),
                        child: Container(
                          padding: const EdgeInsets.all(AppSpacing.md),
                          decoration: BoxDecoration(
                            color: theme.primaryContainer,
                            borderRadius: BorderRadius.circular(8),
                            border: _useWallet
                                ? Border.all(
                                    color: AppColors.secondary,
                                    width: 2,
                                  )
                                : null,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                color: theme.onSurface,
                              ),
                              const Gap(AppSpacing.md),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      t.checkout.motiva_wallet,
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: theme.onSurface,
                                      ),
                                    ),
                                    Text(
                                      '${t.checkout.balance} $walletBalance',
                                      style: GoogleFonts.poppins(
                                        fontSize: 12,
                                        color: theme.onSurface.withValues(
                                          alpha: 0.7,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (_useWallet)
                                const Icon(
                                  Icons.check_circle,
                                  color: AppColors.secondary,
                                ),
                            ],
                          ),
                        ),
                      ),
                      const Gap(AppSpacing.xl),

                      // Payment Methods
                      Text(
                        t.checkout.payment_methods,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.onSurface,
                        ),
                      ),
                      const Gap(AppSpacing.md),
                      PaymentMethodTile(
                        index: 0,
                        icon: 'assets/images/mastercard_logo.png',
                        title: 'xxxx xxxx xxxx xxxx',
                        isSelected: _selectedPaymentMethod == 0,
                        onTap: () => setState(() => _selectedPaymentMethod = 0),
                      ),
                      const Gap(AppSpacing.md),
                      PaymentMethodTile(
                        index: 1,
                        icon: 'assets/images/apple_pay_logo.png',
                        title: 'Apple Pay',
                        isSelected: _selectedPaymentMethod == 1,
                        onTap: () => setState(() => _selectedPaymentMethod = 1),
                      ),
                      const Gap(AppSpacing.md),
                      PaymentMethodTile(
                        index: 2,
                        icon: 'assets/images/motiva_logo.png',
                        title: t.checkout.motiva_wallet,
                        isSelected: _selectedPaymentMethod == 2,
                        onTap: () => setState(() => _selectedPaymentMethod = 2),
                      ),
                      const Gap(AppSpacing.xl),

                      // Pay Button
                      GradientElevatedButton(
                        text: checkoutState.isLoading
                            ? t.checkout.processing
                            : t.checkout.pay,
                        textStyle: const TextStyle(
                          fontFamily: 'Pepsi',
                          fontSize: 24,
                          color: Colors.white,
                          letterSpacing: 0.24,
                        ),
                        onPressed: checkoutState.isLoading
                            ? null
                            : () => _placeOrder(),
                      ),
                      const Gap(AppSpacing.lg),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(
    String label,
    String value, {
    Color? valueColor,
    bool isBold = false,
  }) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: theme.onSurface,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: valueColor ?? theme.onSurface,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildAddAddressButton() {
    final theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: () => _showAddAddressSheet(),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: theme.onSurface.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            Icon(Icons.add_location_alt_outlined, color: theme.onSurface),
            const Gap(AppSpacing.md),
            Text(
              t.checkout.add_new_address,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: theme.onSurface,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios, color: theme.onSurface, size: 16),
          ],
        ),
      ),
    );
  }

  String _formatPrice(String price) {
    final value = double.tryParse(price);
    if (value == null) return price;
    final intValue = value.toInt();
    if (value == intValue) return intValue.toString();
    return value.toStringAsFixed(2);
  }

  String _calculateTotal() {
    final total = double.tryParse(widget.cart.totalAmount) ?? 0;
    final delivery = 0.5;
    var finalTotal = total + delivery;
    if (_voucherApplied) finalTotal -= 1.0;
    if (_useWallet) finalTotal -= 2.5;
    if (finalTotal < 0) finalTotal = 0;
    return _formatPrice(finalTotal.toStringAsFixed(2));
  }

  void _placeOrder() {
    ref
        .read(checkoutNotifierProvider.notifier)
        .checkout(address: _selectedAddress);
  }

  void _showAddAddressSheet() {
    final theme = Theme.of(context).colorScheme;
    final labelController = TextEditingController();
    final streetController = TextEditingController();
    final areaController = TextEditingController();
    final blockController = TextEditingController();
    final buildingController = TextEditingController();
    final floorController = TextEditingController();
    final apartmentController = TextEditingController();
    final notesController = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: theme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(ctx).viewInsets.bottom,
            left: AppSpacing.lg,
            right: AppSpacing.lg,
            top: AppSpacing.lg,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.checkout.add_new_address,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: theme.onSurface,
                  ),
                ),
                const Gap(AppSpacing.md),
                _buildTextField(labelController, t.checkout.address_label_hint),
                const Gap(AppSpacing.sm),
                _buildTextField(streetController, t.checkout.street),
                const Gap(AppSpacing.sm),
                _buildTextField(areaController, t.checkout.area),
                const Gap(AppSpacing.sm),
                _buildTextField(blockController, t.checkout.block),
                const Gap(AppSpacing.sm),
                _buildTextField(buildingController, t.checkout.building),
                const Gap(AppSpacing.sm),
                _buildTextField(floorController, t.checkout.floor),
                const Gap(AppSpacing.sm),
                _buildTextField(apartmentController, t.checkout.apartment),
                const Gap(AppSpacing.sm),
                _buildTextField(notesController, t.checkout.notes),
                const Gap(AppSpacing.lg),
                GradientElevatedButton(
                  text: t.checkout.save_address,
                  onPressed: () async {
                    if (streetController.text.isEmpty ||
                        areaController.text.isEmpty ||
                        blockController.text.isEmpty) {
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(t.checkout.fill_required_fields),
                        ),
                      );
                      return;
                    }
                    final newAddress = DeliveryAddress(
                      id: const Uuid().v4(),
                      label: labelController.text.isEmpty
                          ? t.checkout.default_address_label
                          : labelController.text,
                      street: streetController.text,
                      area: areaController.text,
                      block: blockController.text,
                      building: buildingController.text.isEmpty
                          ? null
                          : buildingController.text,
                      floor: floorController.text.isEmpty
                          ? null
                          : floorController.text,
                      apartment: apartmentController.text.isEmpty
                          ? null
                          : apartmentController.text,
                      notes: notesController.text.isEmpty
                          ? null
                          : notesController.text,
                    );
                    final localDataSource = ref.read(
                      addressLocalDataSourceProvider,
                    );
                    await localDataSource.saveAddress(
                      DeliveryAddressModel.fromEntity(newAddress),
                    );
                    ref.invalidate(savedAddressesProvider);
                    if (ctx.mounted) Navigator.pop(ctx);
                    setState(() => _selectedAddress = newAddress);
                  },
                ),
                const Gap(AppSpacing.lg),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.poppins(fontSize: 14, color: theme.onSurface),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: theme.onSurface.withValues(alpha: 0.5),
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

class _OrderSummaryItem extends StatelessWidget {
  final String name;
  final int quantity;
  final String price;

  const _OrderSummaryItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: AppColors.secondary,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: Text(
              '$name x$quantity',
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: theme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ),
          Text(
            'KWD ${_formatPrice(price)}',
            style: GoogleFonts.poppins(
              fontSize: 13,
              color: theme.onSurface,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(String price) {
    final value = double.tryParse(price);
    if (value == null) return price;
    final intValue = value.toInt();
    if (value == intValue) return intValue.toString();
    return value.toStringAsFixed(2);
  }
}

class _AddressTile extends StatelessWidget {
  final DeliveryAddress address;
  final bool isSelected;
  final VoidCallback onTap;

  const _AddressTile({
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: AppColors.secondary, width: 2)
              : null,
        ),
        child: Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: isSelected,
              onChanged: (_) => onTap(),
              activeColor: AppColors.secondary,
            ),
            const Gap(AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    address.label,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: theme.onSurface,
                    ),
                  ),
                  Text(
                    '${address.street}, ${address.area}, ${t.checkout.block_label} ${address.block}',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: theme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  if (address.building != null)
                    Text(
                      '${t.checkout.building_label} ${address.building}${address.floor != null ? ', ${t.checkout.floor_label} ${address.floor}' : ''}${address.apartment != null ? ', ${t.checkout.apartment_label} ${address.apartment}' : ''}',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: theme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
