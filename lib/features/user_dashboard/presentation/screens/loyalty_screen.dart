import 'package:app/core/theme/spacing.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/cart/presentation/screens/cart_screen.dart';
import 'package:app/features/user_dashboard/presentation/providers/loyalty_provider.dart';
import 'package:app/features/user_dashboard/presentation/widgets/loyalty/loyalty_balance_card.dart';
import 'package:app/features/user_dashboard/presentation/widgets/loyalty/loyalty_progress_bar.dart';
import 'package:app/features/user_dashboard/presentation/widgets/loyalty/loyalty_transaction_card.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/empty_states/empty_state_widget.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class LoyaltyScreen extends ConsumerStatefulWidget {
  const LoyaltyScreen({super.key});

  @override
  ConsumerState<LoyaltyScreen> createState() => _LoyaltyScreenState();
}

class _LoyaltyScreenState extends ConsumerState<LoyaltyScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.invalidate(loyaltyTransactionsProvider(null));
      ref.invalidate(loyaltyConfigProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).user_dashboard.loyalty;
    final transactionsAsync = ref.watch(loyaltyTransactionsProvider(null));
    final configAsync = ref.watch(loyaltyConfigProvider);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(loyaltyTransactionsProvider(null));
            ref.invalidate(loyaltyConfigProvider);
          },
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _headerSection(context, t.screen_title),
                      const Gap(AppSpacing.xl),
                      configAsync.when(
                        loading: () => ShimmerSkeletons.listItemSkeleton(
                          height: 120,
                          showLeadingCircle: false,
                        ),
                        error: (error, _) => const SizedBox.shrink(),
                        data: (config) => Column(
                          children: [
                            LoyaltyBalanceCard(points: config.balance),
                            const Gap(AppSpacing.lg),
                            LoyaltyProgressBar(
                              currentPoints: config.balance,
                              minRedeemPoints: config.minRedeemPoints,
                            ),
                          ],
                        ),
                      ),
                      const Gap(AppSpacing.xl),
                      GradientButton(
                        text: t.redeem_points,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const CartScreen(),
                            ),
                          );
                        },
                      ),
                      const Gap(AppSpacing.xl),
                      Text(
                        t.transactions,
                        style: GoogleFonts.poppins(
                          color: theme.colorScheme.onSurface,
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Gap(AppSpacing.md),
                    ],
                  ),
                ),
              ),
              transactionsAsync.when(
                data: (transactions) {
                  if (transactions.isEmpty) {
                    return SliverFillRemaining(
                      hasScrollBody: false,
                      child: EmptyStateWidget(
                        icon: Icons.card_giftcard,
                        title: t.empty_title,
                        subtitle: t.empty_subtitle,
                      ),
                    );
                  }
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverList.separated(
                      itemCount: transactions.length,
                      separatorBuilder: (_, _) => const Gap(AppSpacing.md),
                      itemBuilder: (context, index) {
                        return LoyaltyTransactionCard(
                          transaction: transactions[index],
                        );
                      },
                    ),
                  );
                },
                loading: () => SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverList.separated(
                    itemCount: 5,
                    separatorBuilder: (_, _) => const Gap(AppSpacing.md),
                    itemBuilder: (_, _) => ShimmerSkeletons.listItemSkeleton(
                      height: 80,
                      showLeadingCircle: true,
                    ),
                  ),
                ),
                error: (error, _) => SliverFillRemaining(
                  hasScrollBody: false,
                  child: EmptyStateWidget(
                    icon: Icons.error_outline,
                    title: t.error_title,
                    subtitle: error.toString(),
                    actionText: t.retry,
                    onAction: () =>
                        ref.invalidate(loyaltyTransactionsProvider(null)),
                  ),
                ),
              ),
              const SliverToBoxAdapter(child: Gap(AppSpacing.xl)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerSection(BuildContext context, String title) {
    final theme = Theme.of(context);
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
        Text(
          title,
          style: GoogleFonts.poppins(
            color: theme.colorScheme.onSurface,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
        const Gap(AppSpacing.lg),
      ],
    );
  }
}
