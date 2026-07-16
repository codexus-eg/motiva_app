import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

import 'package:app/core/theme/spacing.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/public_marketplace/presentation/screens/marketplace_category_screen.dart';
import 'package:app/features/user_dashboard/presentation/widgets/wallet_screen/history_card_widget.dart';
import 'package:app/features/user_dashboard/presentation/widgets/wallet_screen/reward_card_widget.dart';
import 'package:app/features/wallet/presentation/providers/wallet_provider.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/shimmer/shimmer_container.dart';

class WalletScreen extends ConsumerStatefulWidget {
  const WalletScreen({super.key});

  @override
  ConsumerState<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends ConsumerState<WalletScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(walletBalanceProvider);
      ref.invalidate(walletTransactionsProvider);
    });
  }

  List<RewardCardWidget> _rewardCards(BuildContext context) {
    final t = Translations.of(context).user_dashboard.wallet;
    final rewardT = t.reward_cards;
    final comingSoon = t.coming_soon;
    return [
      RewardCardWidget(
        imageUrl:
            'https://www.figma.com/api/mcp/asset/f227e474-e12b-4572-a25a-26b195f1a22b',
        title: rewardT.buy_a_car,
        comingSoonLabel: comingSoon,
      ),
      RewardCardWidget(
        imageUrl:
            'https://www.figma.com/api/mcp/asset/cf30dbb7-0376-458b-b516-1658749c9562',
        title: rewardT.car_accessories,
        comingSoonLabel: comingSoon,
      ),
      RewardCardWidget(
        imageUrl:
            'https://www.figma.com/api/mcp/asset/388c92af-a8d5-4fb2-bad9-652fbfc6ba1e',
        title: rewardT.spare_parts,
        hideComingSoon: true,
        onTap: () => _openSpareParts(context),
      ),
    ];
  }

  void _openSpareParts(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            const MarketplaceCategoryScreen(productType: 'spare_part'),
      ),
    );
  }

  void _onUseNow(BuildContext context) {
    final t = Translations.of(context).user_dashboard.wallet;
    toastification.show(
      context: context,
      title: Text(t.coming_soon),
      description: Text(t.coming_soon_message),
      type: ToastificationType.info,
      style: ToastificationStyle.flat,
      autoCloseDuration: const Duration(seconds: 3),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).user_dashboard.wallet;
    final rewardCards = _rewardCards(context);

    final balanceAsync = ref.watch(walletBalanceProvider);
    final transactionsAsync = ref.watch(
      walletTransactionsProvider(const WalletTransactionsFilter()),
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _headerSection(context),
              const Gap(AppSpacing.xl),
              balanceAsync.when(
                data: (balance) => _walletSummaryCard(context, balance.balance),
                loading: () => _shimmerBalanceCard(context),
                error: (error, _) => _errorBalanceCard(context, t),
              ),
              const Gap(AppSpacing.xl),
              Text(
                t.history,
                style: GoogleFonts.poppins(
                  color: theme.colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(AppSpacing.md),
              transactionsAsync.when(
                data: (paginated) {
                  if (paginated.transactions.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Center(
                        child: Text(
                          t.no_transactions,
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF9FA1AA),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }
                  return Column(
                    children: paginated.transactions.map((transaction) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: HistoryCardWidget(transaction: transaction),
                      );
                    }).toList(),
                  );
                },
                loading: () => _shimmerTransactionList(context),
                error: (error, _) => _errorTransactionsWidget(context, t),
              ),
              const Gap(AppSpacing.sm),
              Text(
                t.use_reward_balance,
                style: GoogleFonts.poppins(
                  color: theme.colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Gap(AppSpacing.md),
              SizedBox(
                height: 220,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: rewardCards.length,
                  separatorBuilder: (_, _) => const Gap(AppSpacing.md),
                  itemBuilder: (context, index) => rewardCards[index],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).user_dashboard.wallet;
    return Row(
      children: [
        InkWell(
          onTap: () => Navigator.pop(context),
          borderRadius: BorderRadius.circular(32),
          child: Icon(
            Icons.arrow_back_ios_new,
            color: theme.colorScheme.onSurface,
            size: 18,
          ),
        ),
        const Spacer(),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.screen_title,
              style: GoogleFonts.poppins(
                color: theme.colorScheme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              t.encrypted,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFFDC8735),
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
    final theme = Theme.of(context);
    final t = Translations.of(context).user_dashboard.wallet;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
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
                  t.total,
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
                    color: theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Gap(AppSpacing.lg),
                GradientButton(
                  text: t.use_now,
                  onTap: () => _onUseNow(context),
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
    final theme = Theme.of(context);
    return ShimmerContainer(
      child: Container(
        width: double.infinity,
        height: 200,
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  Widget _errorBalanceCard(BuildContext context, dynamic t) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFDC8735), width: 1.4),
      ),
      child: Column(
        children: [
          Text(
            t.error_loading,
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
              t.retry,
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
                borderRadius: BorderRadius.circular(18),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _errorTransactionsWidget(BuildContext context, dynamic t) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: Center(
        child: Column(
          children: [
            Text(
              t.error_loading,
              style: GoogleFonts.poppins(
                color: const Color(0xFF9FA1AA),
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.md),
            TextButton(
              onPressed: () => ref.invalidate(walletTransactionsProvider),
              child: Text(
                t.retry,
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
