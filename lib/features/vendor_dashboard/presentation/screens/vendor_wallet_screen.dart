import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/vendor_dashboard/presentation/widgets/wallet_screen/vendor_history_widget.dart';
import 'package:app/features/vendor_dashboard/presentation/widgets/wallet_screen/vendor_wallet_stats_grid_widget.dart';
import 'package:app/features/wallet/domain/entities/payout_request.dart';
import 'package:app/features/wallet/domain/entities/payout_requests_paginated.dart';
import 'package:app/features/wallet/domain/entities/vendor_dashboard_stats.dart';
import 'package:app/features/wallet/domain/entities/wallet_transactions_paginated.dart';
import 'package:app/features/wallet/presentation/providers/wallet_provider.dart';
import 'package:app/features/wallet/presentation/screens/payout_request_screen.dart';
import 'package:app/features/wallet/presentation/widgets/payout_status_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/shared/ui/shimmer/shimmer_container.dart';

class VendorWalletScreen extends ConsumerStatefulWidget {
  const VendorWalletScreen({super.key});

  @override
  ConsumerState<VendorWalletScreen> createState() => _VendorWalletScreenState();
}

class _VendorWalletScreenState extends ConsumerState<VendorWalletScreen> {
  int _selectedTab = 0;

  String get _period {
    switch (_selectedTab) {
      case 0:
        return 'daily';
      case 1:
        return 'weekly';
      case 2:
        return 'monthly';
      default:
        return 'daily';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    final balanceAsync = ref.watch(walletBalanceProvider);
    final transactionsAsync = ref.watch(
      walletTransactionsProvider(const WalletTransactionsFilter()),
    );
    final statsAsync = ref.watch(vendorDashboardStatsProvider(_period));
    final payoutRequestsAsync = ref.watch(payoutRequestsProvider(1));

    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerSection(context),
              const Gap(AppSpacing.xl),
              balanceAsync.when(
                data: (balance) => _walletSummaryCard(context, balance.balance),
                loading: () => _shimmerBalanceCard(context),
                error: (_, _) => _errorBalanceCard(context, t),
              ),
              const Gap(AppSpacing.xl),
              _buildTabs(),
              const Gap(AppSpacing.lg),
              statsAsync.when(
                data: (stats) => _statsGrid(context, stats),
                loading: () => _shimmerStatsGrid(context),
                error: (_, _) => _errorStatsGrid(context, t),
              ),
              const Gap(AppSpacing.xl),
              _sectionTitle(context, t.vendor_dashboard.wallet.completed_jobs),
              const Gap(AppSpacing.md),
              statsAsync.when(
                data: (stats) => _completedJobsCard(context, stats),
                loading: () => _shimmerCompletedJobsCard(context),
                error: (_, _) => const SizedBox.shrink(),
              ),
              const Gap(AppSpacing.xl),
              _sectionTitle(context, t.vendor_dashboard.wallet.history),
              const Gap(AppSpacing.md),
              _historySection(
                context,
                transactionsAsync,
                payoutRequestsAsync,
                t,
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
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(32),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: theme.onSurface,
            size: 18,
          ),
        ),
        const Spacer(),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Translations.of(context).vendor_dashboard.wallet.screen_title,
              style: GoogleFonts.poppins(
                color: theme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const Spacer(),
        const Gap(AppSpacing.lg),
      ],
    );
  }

  Widget _walletSummaryCard(BuildContext context, String balance) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_dashboard.wallet;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDC8735), width: 1.4),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: -24,
            right: -24,
            bottom: -24,
            child: SvgPicture.asset(
              'assets/images/wallet_card.svg',
              width: 166,
              height: 258,
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  t.total_label,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFFB5B5B5),
                  ),
                ),
                const Gap(AppSpacing.md),
                Text(
                  'KWD $balance',
                  style: GoogleFonts.poppins(
                    fontSize: 30,
                    color: theme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(AppSpacing.lg),
                GradientButton(
                  text: t.withdraw,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PayoutRequestScreen(),
                    ),
                  ),
                  width: 168,
                  height: 44,
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
        ],
      ),
    );
  }

  Widget _shimmerBalanceCard(BuildContext context) {
    return ShimmerContainer(
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _errorBalanceCard(BuildContext context, Translations t) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDC8735), width: 1.4),
      ),
      child: Column(
        children: [
          Text(
            t.vendor_dashboard.wallet.error_loading,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFF9FA1AA),
            ),
            textAlign: TextAlign.center,
          ),
          const Gap(AppSpacing.md),
          TextButton(
            onPressed: () => ref.invalidate(walletBalanceProvider),
            child: Text(
              t.vendor_dashboard.wallet.retry,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFFDC8735),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabs() {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context).vendor_dashboard.wallet;
    final tabs = [t.tabs.daily, t.tabs.weekly, t.tabs.monthly];
    return Row(
      children: List.generate(tabs.length, (index) {
        final isActive = index == _selectedTab;
        return Padding(
          padding: EdgeInsets.only(right: index == tabs.length - 1 ? 0 : 20),
          child: GestureDetector(
            onTap: () => setState(() => _selectedTab = index),
            behavior: HitTestBehavior.opaque,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text(
                    tabs[index],
                    style: GoogleFonts.dmSans(
                      fontSize: 13,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                      color: theme.onSurface,
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 3,
                  width: isActive ? 42 : 0,
                  decoration: BoxDecoration(
                    color: isActive ? AppColors.secondary : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _statsGrid(BuildContext context, VendorDashboardStats stats) {
    return VendorWalletStatsGridWidget(
      totalSales: stats.totalSales,
      totalEarnings: double.tryParse(stats.totalEarnings) ?? 0,
      averageRating: stats.averageRating.toStringAsFixed(1),
      cancellationRate: stats.cancellationRate.toStringAsFixed(1),
    );
  }

  Widget _shimmerStatsGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tileWidth = (constraints.maxWidth - 8) / 2;
        return Wrap(
          spacing: 8,
          runSpacing: 8,
          children: List.generate(
            4,
            (_) => SizedBox(
              width: tileWidth,
              child: ShimmerContainer(
                child: Container(
                  height: 102,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _errorStatsGrid(BuildContext context, Translations t) {
    return Center(
      child: Column(
        children: [
          Text(
            t.vendor_dashboard.wallet.error_loading,
            style: GoogleFonts.poppins(
              color: const Color(0xFF9FA1AA),
              fontSize: 14,
            ),
          ),
          const Gap(AppSpacing.sm),
          TextButton(
            onPressed: () =>
                ref.invalidate(vendorDashboardStatsProvider(_period)),
            child: Text(
              t.vendor_dashboard.wallet.retry,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: const Color(0xFFDC8735),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _completedJobsCard(BuildContext context, VendorDashboardStats stats) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: theme.onSurface.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.check_circle_outline,
              color: AppColors.secondary,
              size: 24,
            ),
          ),
          const Gap(AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stats.completedJobsCount.toString(),
                style: GoogleFonts.mulish(
                  color: AppColors.secondary,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.4,
                ),
              ),
              const Gap(AppSpacing.xs),
              Text(
                Translations.of(context).vendor_dashboard.wallet.completed_jobs,
                style: GoogleFonts.poppins(
                  color: theme.onSurface,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _shimmerCompletedJobsCard(BuildContext context) {
    return ShimmerContainer(
      child: Container(
        width: double.infinity,
        height: 80,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _historySection(
    BuildContext context,
    AsyncValue<WalletTransactionsPaginated> transactionsAsync,
    AsyncValue<PayoutRequestsPaginated> payoutRequestsAsync,
    Translations t,
  ) {
    return transactionsAsync.when(
      data: (paginated) {
        final transactions = paginated.transactions;
        if (transactions.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 32),
            child: Center(
              child: Text(
                t.vendor_dashboard.wallet.no_transactions,
                style: GoogleFonts.poppins(
                  color: const Color(0xFF9FA1AA),
                  fontSize: 14,
                ),
              ),
            ),
          );
        }
        return Column(
          children: [
            ...transactions.map(
              (tx) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: VendorHistoryWidget(transaction: tx),
              ),
            ),
            // Payout requests section
            payoutRequestsAsync.when(
              data: (payoutPaginated) {
                final payouts = payoutPaginated.data;
                if (payouts.isEmpty) return const SizedBox.shrink();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(AppSpacing.md),
                    ...payouts.map(
                      (payout) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _payoutRequestCard(context, payout, t),
                      ),
                    ),
                  ],
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, _) => const SizedBox.shrink(),
            ),
          ],
        );
      },
      loading: () => _shimmerTransactionList(context),
      error: (_, _) => _errorTransactionsWidget(context, t),
    );
  }

  Widget _payoutRequestCard(
    BuildContext context,
    PayoutRequest payout,
    Translations t,
  ) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                t.vendor_dashboard.wallet.payout_request_card_title,
                style: GoogleFonts.poppins(
                  color: theme.onSurface,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              Text(
                '-KWD ${payout.amount}',
                style: GoogleFonts.poppins(
                  color: AppColors.red,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.sm),
          Text(
            _formatDate(payout.createdAt, context),
            style: GoogleFonts.poppins(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
          const Gap(AppSpacing.sm),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Text(
                  t.vendor_dashboard.wallet.id_label.replaceAll(
                    '{id}',
                    payout.id,
                  ),
                  style: GoogleFonts.poppins(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Expanded(
                flex: 1,
                child: PayoutStatusBadge(status: payout.status),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date, BuildContext context) {
    final m = Translations.of(context).vendor_dashboard.wallet.months;
    final months = [
      m.jan,
      m.feb,
      m.mar,
      m.apr,
      m.may,
      m.jun,
      m.jul,
      m.aug,
      m.sep,
      m.oct,
      m.nov,
      m.dec,
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  Widget _shimmerTransactionList(BuildContext context) {
    return Column(
      children: List.generate(
        3,
        (_) => Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: ShimmerContainer(
            child: Container(
              width: double.infinity,
              height: 80,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _errorTransactionsWidget(BuildContext context, Translations t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Column(
          children: [
            Text(
              t.vendor_dashboard.wallet.error_loading,
              style: GoogleFonts.poppins(
                color: const Color(0xFF9FA1AA),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.md),
            TextButton(
              onPressed: () => ref.invalidate(
                walletTransactionsProvider(const WalletTransactionsFilter()),
              ),
              child: Text(
                t.vendor_dashboard.wallet.retry,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  color: const Color(0xFFDC8735),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
