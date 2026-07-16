import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/reviews/domain/entities/review.dart';
import 'package:app/features/reviews/presentation/widgets/rating_filter_chips.dart';
import 'package:app/features/reviews/presentation/widgets/sort_dropdown.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/cards/review_card.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class ReviewsSection extends StatelessWidget {
  final List<Review> reviews;
  final double averageRating;
  final int totalReviews;
  final int? selectedRating;
  final SortOption selectedSort;
  final bool isLoading;
  final bool hasMore;
  final Function(int?) onRatingFilter;
  final Function(SortOption) onSortChange;
  final Function() onLoadMore;
  final Function() onRefresh;

  const ReviewsSection({
    super.key,
    required this.reviews,
    required this.averageRating,
    required this.totalReviews,
    required this.selectedRating,
    required this.selectedSort,
    required this.onRatingFilter,
    required this.onSortChange,
    required this.onLoadMore,
    required this.onRefresh,
    this.isLoading = false,
    this.hasMore = false,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context).reviews.display;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildAverageRatingHeader(context),
        const Gap(AppSpacing.lg),
        _buildFilters(context),
        const Gap(AppSpacing.md),
        if (isLoading && reviews.isEmpty)
          ShimmerSkeletons.cardSkeleton()
        else if (reviews.isEmpty)
          _buildEmptyState(context)
        else ...[
          _buildReviewsList(context),
          if (hasMore) ...[
            const Gap(AppSpacing.md),
            Center(
              child: isLoading
                  ? ShimmerSkeletons.buttonSkeleton()
                  : TextButton(onPressed: onLoadMore, child: Text(t.load_more)),
            ),
          ],
        ],
      ],
    );
  }

  Widget _buildAverageRatingHeader(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).reviews.display;

    return Row(
      children: [
        Text(
          averageRating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const Gap(AppSpacing.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: List.generate(5, (index) {
                return Icon(
                  index < averageRating.round()
                      ? Icons.star
                      : Icons.star_border,
                  color: const Color(0xFFD4941A),
                  size: 20,
                );
              }),
            ),
            const Gap(AppSpacing.xs),
            Text(
              '$totalReviews ${totalReviews == 1 ? t.review : t.title}',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilters(BuildContext context) {
    final t = Translations.of(context).reviews.display;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RatingFilterChips(
          selectedRating: selectedRating,
          onRatingSelected: onRatingFilter,
        ),
        const Gap(AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
            SortDropdown(
              selectedSort: selectedSort,
              onSortSelected: onSortChange,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildReviewsList(BuildContext context) {
    return Column(
      children: reviews.map((review) {
        return ReviewCard(
          name: review.reviewerName,
          rating: review.rating,
          timeAgo: _formatTimeAgo(review.createdAt),
          comment: review.body,
          avatarColor: _getAvatarColor(review.reviewerInitials),
          initials: review.reviewerInitials,
          verifiedPurchase: review.verifiedPurchase,
        );
      }).toList(),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).reviews.display;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Column(
          children: [
            Icon(
              Icons.rate_review_outlined,
              size: 64,
              color: theme.colorScheme.outline,
            ),
            const Gap(AppSpacing.md),
            Text(
              t.empty_state_title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const Gap(AppSpacing.sm),
            Text(
              t.empty_state_message,
              style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years ${years == 1 ? 'year' : 'years'} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months ${months == 1 ? 'month' : 'months'} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  Color _getAvatarColor(String initials) {
    final colors = [
      const Color(0xFFE57373),
      const Color(0xFFF06292),
      const Color(0xFFBA68C8),
      const Color(0xFF9575CD),
      const Color(0xFF7986CB),
      const Color(0xFF64B5F6),
      const Color(0xFF4FC3F7),
      const Color(0xFF4DD0E1),
      const Color(0xFF4DB6AC),
      const Color(0xFF81C784),
      const Color(0xFFAED581),
      const Color(0xFFFFD54F),
      const Color(0xFFFFB74D),
      const Color(0xFFFF8A65),
    ];

    final index = initials.hashCode.abs() % colors.length;
    return colors[index];
  }
}
