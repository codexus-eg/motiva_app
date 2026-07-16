import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/wallet/domain/entities/wallet_balance.dart';
import 'package:app/features/wallet/presentation/providers/wallet_provider.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/shimmer/shimmer_container.dart';

class PayoutRequestScreen extends ConsumerStatefulWidget {
  const PayoutRequestScreen({super.key});

  @override
  ConsumerState<PayoutRequestScreen> createState() =>
      _PayoutRequestScreenState();
}

class _PayoutRequestScreenState extends ConsumerState<PayoutRequestScreen> {
  final _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    // Schedule a post-frame callback to set up the listener
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.listenManual(createPayoutRequestProvider, (previous, next) {
        if (!mounted) return;
        next.whenOrNull(
          data: (_) {
            final t =
                Translations.of(context).vendor_dashboard.wallet.payout_request;
            toastification.show(
              context: context,
              title: Text(t.success),
              type: ToastificationType.success,
              style: ToastificationStyle.flat,
              autoCloseDuration: const Duration(seconds: 3),
              alignment: Alignment.bottomCenter,
            );
            Navigator.pop(context);
          },
          error: (error, _) {
            final t =
                Translations.of(context).vendor_dashboard.wallet.payout_request;
            toastification.show(
              context: context,
              title: Text(t.error),
              type: ToastificationType.error,
              style: ToastificationStyle.flat,
              autoCloseDuration: const Duration(seconds: 3),
              alignment: Alignment.bottomCenter,
            );
            setState(() => _isSubmitting = false);
          },
        );
      });
    });
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _submitPayoutRequest() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSubmitting = true);

    ref.read(createPayoutRequestProvider.notifier).createPayoutRequest(
          _amountController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_dashboard.wallet;
    final payoutT = t.payout_request;

    final balanceAsync = ref.watch(walletBalanceProvider);

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        backgroundColor: theme.surface,
        elevation: 0,
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back_ios_new, color: theme.onSurface, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          payoutT.title,
          style: GoogleFonts.poppins(
            color: theme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Wallet Balance Card
              balanceAsync.when(
                data: (balance) => _balanceCard(context, balance.balance),
                loading: () => _shimmerBalanceCard(context),
                error: (_, __) => _errorBalanceCard(context),
              ),
              const Gap(AppSpacing.xl),

              // Bank Details Section
              _sectionTitle(context, payoutT.bank_details),
              const Gap(AppSpacing.md),
              _bankDetailsSection(context),
              const Gap(AppSpacing.xl),

              // Amount Input
              _sectionTitle(context, payoutT.amount_label),
              const Gap(AppSpacing.md),
              _amountInputField(context, balanceAsync),
              const Gap(AppSpacing.xl),

              // Submit Button
              GradientButton(
                text: _isSubmitting ? Translations.of(context).vendor_dashboard.wallet.submitting : payoutT.submit,
                onTap: _isSubmitting ? null : _submitPayoutRequest,
                height: 50,
                textStyle: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(BuildContext context, String title) {
    final theme = Theme.of(context).colorScheme;
    return Text(
      title,
      style: GoogleFonts.poppins(
        color: theme.onSurface,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _balanceCard(BuildContext context, String balance) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_dashboard.wallet;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDC8735), width: 1.4),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.available_balance,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFFB5B5B5),
                  ),
                ),
                const Gap(AppSpacing.sm),
                Text(
                  'KWD $balance',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    color: theme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.account_balance_wallet_outlined,
            color: AppColors.secondary,
            size: 40,
          ),
        ],
      ),
    );
  }

  Widget _shimmerBalanceCard(BuildContext context) {
    return ShimmerContainer(
      child: Container(
        width: double.infinity,
        height: 100,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _errorBalanceCard(BuildContext context) {
    final t = Translations.of(context).vendor_dashboard.wallet;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDC8735), width: 1.4),
      ),
      child: Text(
        t.failed_to_load_balance,
        style: GoogleFonts.poppins(
          color: const Color(0xFF9FA1AA),
          fontSize: 14,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _bankDetailsSection(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final payoutT =
        Translations.of(context).vendor_dashboard.wallet.payout_request;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _bankDetailRow(context, payoutT.bank_name, '—'),
          const Gap(AppSpacing.sm),
          _bankDetailRow(context, payoutT.account_number, '—'),
          const Gap(AppSpacing.sm),
          _bankDetailRow(context, payoutT.account_holder, '—'),
          const Gap(AppSpacing.sm),
          _bankDetailRow(context, payoutT.kuwait_code, '—'),
          const Gap(AppSpacing.md),
          Center(
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                payoutT.update_bank_details,
                style: GoogleFonts.poppins(
                  color: AppColors.secondary,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bankDetailRow(BuildContext context, String label, String value) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            color: const Color(0xFFB5B5B5),
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.poppins(
            color: theme.onSurface,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _amountInputField(
    BuildContext context,
    AsyncValue<WalletBalance> balanceAsync,
  ) {
    final theme = Theme.of(context).colorScheme;
    final payoutT =
        Translations.of(context).vendor_dashboard.wallet.payout_request;

    return TextFormField(
      controller: _amountController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      style: GoogleFonts.poppins(
        color: theme.onSurface,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        hintText: payoutT.amount_hint,
        hintStyle: GoogleFonts.poppins(
          color: const Color(0xFF7E8087),
          fontSize: 14,
        ),
        prefixText: 'KWD ',
        prefixStyle: GoogleFonts.poppins(
          color: AppColors.secondary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: theme.primaryContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return payoutT.invalid_amount;
        }
        final amount = double.tryParse(value.trim());
        if (amount == null || amount <= 0) {
          return payoutT.invalid_amount;
        }
        final balance = balanceAsync.valueOrNull?.balance;
        if (balance != null) {
          final balanceValue = double.tryParse(balance);
          if (balanceValue != null && amount > balanceValue) {
            return payoutT.insufficient_balance;
          }
        }
        return null;
      },
    );
  }
}
