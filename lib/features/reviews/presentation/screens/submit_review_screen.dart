import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/features/reviews/presentation/providers/reviews_provider.dart';
import 'package:app/features/reviews/presentation/widgets/star_rating_widget.dart';
import 'package:app/features/reviews/domain/failures/reviews_failure.dart';
import 'package:app/i18n/strings.g.dart';

class SubmitReviewScreen extends ConsumerStatefulWidget {
  final String orderId;
  final String vendorId;
  final String orderName;
  final String vendorName;
  final bool isServiceOrder;

  const SubmitReviewScreen({
    super.key,
    required this.orderId,
    required this.vendorId,
    required this.orderName,
    required this.vendorName,
    required this.isServiceOrder,
  });

  @override
  ConsumerState<SubmitReviewScreen> createState() => _SubmitReviewScreenState();
}

class _SubmitReviewScreenState extends ConsumerState<SubmitReviewScreen> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();
  final FocusNode _reviewFocusNode = FocusNode();

  @override
  void dispose() {
    _reviewController.dispose();
    _reviewFocusNode.dispose();
    super.dispose();
  }

  bool get _canSubmit =>
      _rating > 0 && _reviewController.text.trim().isNotEmpty;

  void _handleSubmit() async {
    if (!_canSubmit) return;

    final notifier = ref.read(submitReviewNotifierProvider.notifier);
    final reviewsT = Translations.of(context).reviews;

    await notifier.submitReview(
      serviceOrderId: widget.isServiceOrder ? widget.orderId : null,
      productOrderId: widget.isServiceOrder ? null : widget.orderId,
      vendorId: widget.vendorId,
      rating: _rating,
      body: _reviewController.text.trim(),
    );

    if (mounted) {
      final state = ref.read(submitReviewNotifierProvider);
      if (state.hasError) {
        final error = state.error;
        if (error is AlreadyReviewedFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(reviewsT.error_already_reviewed)),
          );
        } else if (error is ValidationFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(reviewsT.error_validation)));
        } else {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(reviewsT.error_network)));
        }
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(reviewsT.success_message)));
        Navigator.of(context).pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final submitState = ref.watch(submitReviewNotifierProvider);
    final reviewsT = Translations.of(context).reviews;

    return Scaffold(
      appBar: AppBar(title: Text(reviewsT.screen_title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Info Card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.isServiceOrder
                          ? reviewsT.rate_service
                          : 'Rate Product',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.orderName,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.vendorName,
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Order #${widget.orderId}',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Star Rating
            Center(
              child: StarRatingWidget(
                rating: _rating,
                onRatingChanged: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
                starSize: 48,
              ),
            ),
            const SizedBox(height: 24),

            // Review Input
            Text(
              reviewsT.your_review,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _reviewController,
              focusNode: _reviewFocusNode,
              maxLines: 5,
              maxLength: 5000,
              decoration: InputDecoration(
                hintText: reviewsT.review_placeholder,
                border: const OutlineInputBorder(),
                counterText: '${_reviewController.text.length}/5000',
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
            const SizedBox(height: 24),

            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: submitState.isLoading || !_canSubmit
                    ? null
                    : _handleSubmit,
                child: submitState.isLoading
                    ? Text(reviewsT.submitting)
                    : Text(reviewsT.submit_review),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
