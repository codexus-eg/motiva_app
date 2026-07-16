import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/core/utils/time_utils.dart';
import 'package:app/features/vendor-products/domain/entities/inventory_transaction.dart';
import 'package:app/features/vendor-products/presentation/providers/inventory_transactions_provider.dart';
import 'package:app/features/vendor-products/presentation/providers/inventory_transactions_state.dart';
import 'package:app/shared/ui/empty_states/empty_state_widget.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class InventoryTransactionsScreen extends ConsumerStatefulWidget {
  const InventoryTransactionsScreen({super.key});

  @override
  ConsumerState<InventoryTransactionsScreen> createState() =>
      _InventoryTransactionsScreenState();
}

class _InventoryTransactionsScreenState
    extends ConsumerState<InventoryTransactionsScreen> {
  TransactionType? _selectedType;
  DateTime? _fromDate;
  DateTime? _toDate;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref
          .read(inventoryTransactionsNotifierProvider.notifier)
          .fetchNextPage(
            transactionType: _selectedType,
            fromDate: _fromDate,
            toDate: _toDate,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final transactionsState = ref.watch(inventoryTransactionsNotifierProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(theme),
            const Gap(AppSpacing.md),
            _buildFilterChips(theme),
            const Gap(AppSpacing.md),
            if (_fromDate != null || _toDate != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: _buildDateRangeChip(theme),
              ),
            if (_fromDate != null || _toDate != null) const Gap(AppSpacing.md),
            Expanded(
              child: transactionsState.when(
                data: (state) => _buildBody(state),
                loading: () => ShimmerSkeletons.cardSkeleton(),
                error: (error, stack) => _buildErrorState(theme, error),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(ColorScheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.orange),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          Text(
            Translations.of(context).inventory.screen_title,
            style: GoogleFonts.poppins(
              color: theme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          IconButton(
            icon: Icon(Icons.calendar_today_outlined, color: AppColors.orange),
            onPressed: _showDateRangePicker,
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips(ColorScheme theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _buildFilterChip(
              label: Translations.of(context).inventory.filter_all,
              isSelected: _selectedType == null,
              onTap: () => _applyTypeFilter(null),
            ),
            const Gap(AppSpacing.sm),
            _buildFilterChip(
              label: Translations.of(context).inventory.filter_stock_in,
              isSelected: _selectedType == TransactionType.restock,
              onTap: () => _applyTypeFilter(TransactionType.restock),
            ),
            const Gap(AppSpacing.sm),
            _buildFilterChip(
              label: Translations.of(context).inventory.filter_stock_out,
              isSelected: _selectedType == TransactionType.sale,
              onTap: () => _applyTypeFilter(TransactionType.sale),
            ),
            const Gap(AppSpacing.sm),
            _buildFilterChip(
              label: Translations.of(context).inventory.filter_adjustment,
              isSelected: _selectedType == TransactionType.adjustment,
              onTap: () => _applyTypeFilter(TransactionType.adjustment),
            ),
            const Gap(AppSpacing.sm),
            _buildFilterChip(
              label: Translations.of(context).inventory.filter_refund,
              isSelected: _selectedType == TransactionType.refund,
              onTap: () => _applyTypeFilter(TransactionType.refund),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : theme.primaryContainer,
          borderRadius: BorderRadius.circular(20),
          border: isSelected
              ? null
              : Border.all(
                  color: AppColors.textSecondary.withValues(alpha: 0.2),
                ),
        ),
        child: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isSelected ? AppColors.white : theme.onSurface,
          ),
        ),
      ),
    );
  }

  Widget _buildDateRangeChip(ColorScheme theme) {
    final dateText = _buildDateRangeText(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.date_range, size: 16, color: AppColors.primary),
              const Gap(AppSpacing.sm),
              Text(
                dateText,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
              ),
              const Gap(AppSpacing.sm),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _fromDate = null;
                    _toDate = null;
                  });
                  _refreshWithFilters();
                },
                child: Icon(Icons.close, size: 16, color: AppColors.primary),
              ),
            ],
          ),
        ),
      ],
    );
  }

  String _buildDateRangeText(BuildContext context) {
    if (_fromDate != null && _toDate != null) {
      return '${DateFormat('MMM d').format(_fromDate!)} - ${DateFormat('MMM d').format(_toDate!)}';
    } else if (_fromDate != null) {
      return Translations.of(context).inventory.from_date.replaceAll(
        '{date}',
        DateFormat('MMM d').format(_fromDate!),
      );
    } else if (_toDate != null) {
      return Translations.of(context).inventory.until_date.replaceAll(
        '{date}',
        DateFormat('MMM d').format(_toDate!),
      );
    }
    return '';
  }

  Widget _buildBody(InventoryTransactionsState state) {
    if (state.transactions.isEmpty) {
      return _buildEmptyState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        await ref
            .read(inventoryTransactionsNotifierProvider.notifier)
            .refresh(
              transactionType: _selectedType,
              fromDate: _fromDate,
              toDate: _toDate,
            );
      },
      color: AppColors.primary,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(left: 25, right: 25, bottom: 100),
        itemCount: state.transactions.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= state.transactions.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              ),
            );
          }
          final transaction = state.transactions[index];
          return _buildTransactionCard(transaction);
        },
      ),
    );
  }

  Widget _buildTransactionCard(InventoryTransaction transaction) {
    final theme = Theme.of(context).colorScheme;
    final badgeColor = _getBadgeColor(transaction.transactionType);
    final icon = _getTypeIcon(transaction.transactionType);

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: AppColors.textSecondary.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(icon, size: 14, color: badgeColor),
                    const Gap(AppSpacing.sm),
                    Text(
                      _transactionTypeLabel(
                        context,
                        transaction.transactionType,
                      ),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: badgeColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Text(
                TimeUtils.formatDateTime(transaction.createdAt),
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.md),
          Text(
            transaction.productName,
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: theme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const Gap(AppSpacing.sm),
          Row(
            children: [
              _buildQuantityBadge(transaction),
              const Spacer(),
              Text(
                '${Translations.of(context).inventory.card.before} ${transaction.quantityBefore.toStringAsFixed(0)}  →  ${Translations.of(context).inventory.card.after} ${transaction.quantityAfter.toStringAsFixed(0)}',
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          if (transaction.notes != null && transaction.notes!.isNotEmpty) ...[
            const Gap(AppSpacing.sm),
            Text(
              '${Translations.of(context).inventory.card.reason} ${transaction.notes}',
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildQuantityBadge(InventoryTransaction transaction) {
    final isPositive = transaction.isPositiveChange;
    final color = isPositive ? AppColors.green : AppColors.red;
    final sign = isPositive ? '+' : '';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        '$sign${transaction.quantityChange.toStringAsFixed(0)}',
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: color,
        ),
      ),
    );
  }

  Color _getBadgeColor(TransactionType type) {
    switch (type) {
      case TransactionType.sale:
        return AppColors.red;
      case TransactionType.restock:
        return AppColors.green;
      case TransactionType.adjustment:
        return AppColors.orange;
      case TransactionType.refund:
        return AppColors.primary;
    }
  }

  String _transactionTypeLabel(BuildContext context, TransactionType type) {
    final t = Translations.of(context).inventory.transaction_type;
    switch (type) {
      case TransactionType.sale:
        return t.sale;
      case TransactionType.restock:
        return t.restock;
      case TransactionType.adjustment:
        return t.adjustment;
      case TransactionType.refund:
        return t.refund;
    }
  }

  IconData _getTypeIcon(TransactionType type) {
    switch (type) {
      case TransactionType.sale:
        return Icons.arrow_downward;
      case TransactionType.restock:
        return Icons.arrow_upward;
      case TransactionType.adjustment:
        return Icons.tune;
      case TransactionType.refund:
        return Icons.reply;
    }
  }

  Widget _buildEmptyState() {
    return EmptyStateWidget(
      icon: Icons.inventory_2_outlined,
      title: Translations.of(context).inventory.empty.title,
      subtitle: _selectedType != null || _fromDate != null || _toDate != null
          ? Translations.of(context).inventory.empty.filtered_subtitle
          : Translations.of(context).inventory.empty.subtitle,
    );
  }

  Widget _buildErrorState(ColorScheme theme, Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.red.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.error_outline,
                size: 40,
                color: AppColors.red,
              ),
            ),
            const Gap(AppSpacing.lg),
            Text(
              Translations.of(context).inventory.error.title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.onSurface,
              ),
            ),
            const Gap(AppSpacing.sm),
            Text(
              Translations.of(context).inventory.error.message,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
            const Gap(AppSpacing.lg),
            ElevatedButton(
              onPressed: () {
                ref
                    .read(inventoryTransactionsNotifierProvider.notifier)
                    .refresh(
                      transactionType: _selectedType,
                      fromDate: _fromDate,
                      toDate: _toDate,
                    );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: theme.onSurface,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                Translations.of(context).inventory.error.retry,
                style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _applyTypeFilter(TransactionType? type) {
    setState(() {
      _selectedType = type;
    });
    _refreshWithFilters();
  }

  void _refreshWithFilters() {
    ref
        .read(inventoryTransactionsNotifierProvider.notifier)
        .refresh(
          transactionType: _selectedType,
          fromDate: _fromDate,
          toDate: _toDate,
        );
  }

  Future<void> _showDateRangePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 2);
    final lastDate = DateTime(now.year + 1);

    final picked = await showDateRangePicker(
      context: context,
      firstDate: firstDate,
      lastDate: lastDate,
      initialDateRange: _fromDate != null && _toDate != null
          ? DateTimeRange(start: _fromDate!, end: _toDate!)
          : null,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            appBarTheme: Theme.of(
              context,
            ).appBarTheme.copyWith(backgroundColor: AppColors.primary),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _fromDate = picked.start;
        _toDate = picked.end;
      });
      _refreshWithFilters();
    }
  }
}
