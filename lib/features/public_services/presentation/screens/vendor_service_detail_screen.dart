import 'package:app/core/utils/fallback_images.dart';
import 'package:app/features/public_services/domain/entities/entities.dart';
import 'package:app/features/booking/presentation/screens/booking_screen.dart';
import 'package:app/features/reviews/presentation/providers/reviews_provider.dart';
import 'package:app/features/reviews/presentation/widgets/reviews_section.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:app/features/vendor/domain/entities/working_hours.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/images/network_image_widget.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

import '../providers/public_services_provider.dart';
import 'package:app/core/theme/spacing.dart';

class VendorServiceDetailScreen extends ConsumerStatefulWidget {
  final PublicVendorService service;
  final PublicVendor vendor;

  const VendorServiceDetailScreen({
    super.key,
    required this.service,
    required this.vendor,
  });

  @override
  ConsumerState<VendorServiceDetailScreen> createState() =>
      _VendorServiceDetailScreenState();
}

class _VendorServiceDetailScreenState
    extends ConsumerState<VendorServiceDetailScreen> {
  ServiceCategoryWithSchema? _category;
  bool _isLoadingCategory = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadCategory();
      _loadReviews();
    });
  }

  Future<void> _loadCategory() async {
    setState(() => _isLoadingCategory = true);
    try {
      final category = await ref
          .read(publicServicesRepositoryProvider)
          .getCategoryDetails(widget.service.categoryId);
      if (mounted) {
        setState(() {
          _category = category;
          _isLoadingCategory = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingCategory = false);
      }
    }
  }

  void _loadReviews() {
    final reviewsNotifier = ref.read(
      reviewsListNotifierProvider(widget.service.vendorId).notifier,
    );
    reviewsNotifier.setContext(
      vendorServiceId: widget.service.vendorId,
      vendorId: widget.vendor.id,
    );
    reviewsNotifier.loadReviews(
      vendorServiceId: widget.service.vendorId,
      vendorId: widget.vendor.id,
    );
  }

  Map<String, dynamic>? get _effectiveWorkingHours {
    final profileAsync = ref.watch(vendorProfileProvider(widget.vendor.id));
    return profileAsync.whenOrNull(data: (vendor) => vendor?.workingHours) ??
        widget.vendor.workingHours;
  }

  void _navigateToBooking() {
    final t = Translations.of(context).public_services.services_details.button;
    if (_category == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.null_service)));
      return;
    }

    if (_category!.behaviorConfig.requiresQuotation) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.error_service)));
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingScreen(
          service: widget.service,
          vendor: widget.vendor,
          category: _category!,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBar(context),
              _buildServiceImage(),
              _buildServiceInfo(),
              _buildDescription(),
              if (widget.service.categoryServiceAttributes.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Divider(color: Color(0xFF383A42)),
                ),
                _buildAttributes(),
              ],
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Divider(color: Color(0xFF383A42)),
              ),
              _buildVendorInfo(),
              if (_effectiveWorkingHours != null) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Divider(color: Color(0xFF383A42)),
                ),
                _buildWorkingHours(),
              ],
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Divider(color: Color(0xFF383A42)),
              ),
              _buildReviewsSection(),
              _buildActionButtons(),
              const Gap(AppSpacing.xl),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).public_services.services_details;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          IconButton(
            tooltip: SemanticLabels.backButton,
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios,
              color: theme.colorScheme.onSurface,
              size: 20,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          const Gap(AppSpacing.xl),
          Text(
            t.title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          // const Icon(Icons.share, color: Colors.white, size: 24),
        ],
      ),
    );
  }

  Widget _buildServiceImage() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: theme.colorScheme.primaryContainer,
        ),
        clipBehavior: Clip.antiAlias,
        child: NetworkImageWidget(
          imageUrl: widget.service.imageUrl,
          fallbackAsset: FallbackImages.serviceDefault,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildServiceInfo() {
    final theme = Theme.of(context);
    final t = Translations.of(context).public_services.services_details.min;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.service.name,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const Gap(AppSpacing.sm),
          if (widget.service.basePrice != null)
            Text(
              'KD ${widget.service.basePrice}',
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFFE8C00),
              ),
            ),
          const Gap(AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFFE8C00).withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.business,
                  color: theme.colorScheme.onSurface,
                  size: 16,
                ),
                const Gap(AppSpacing.sm),
                Expanded(
                  child: Text(
                    widget.vendor.businessName,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                const Gap(AppSpacing.md),
                Icon(
                  Icons.access_time,
                  color: theme.colorScheme.onSurface,
                  size: 16,
                ),
                const Gap(AppSpacing.xs),
                Text(
                  '50 $t',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Gap(AppSpacing.md),
                const Icon(Icons.star, color: Color(0xFFFE8C00), size: 16),
                const Gap(AppSpacing.xs),
                Text(
                  widget.vendor.rating ?? '0.0',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const Gap(AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildDescription() {
    final theme = Theme.of(context);
    final t = Translations.of(
      context,
    ).public_services.services_details.description;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.title,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            widget.service.description ??
                '${t.dec} ${widget.vendor.businessName}',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: const Color(0xFFA8A8A8),
              height: 1.5,
            ),
          ),
          const Gap(AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildAttributes() {
    final theme = Theme.of(context);
    final t = Translations.of(context).public_services.services_details;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(AppSpacing.md),
          Text(
            t.service_details,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const Gap(AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widget.service.categoryServiceAttributes.entries.map((
                entry,
              ) {
                final isLast =
                    entry ==
                    widget.service.categoryServiceAttributes.entries.last;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatKey(entry.key),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFFB9B9B9),
                      ),
                    ),
                    const Gap(AppSpacing.xs),
                    Text(
                      _formatValue(entry.value),
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    if (!isLast) ...[
                      const Gap(AppSpacing.md),
                      const Divider(color: Color(0xFF383A42), height: 1),
                      const Gap(AppSpacing.md),
                    ],
                  ],
                );
              }).toList(),
            ),
          ),
          const Gap(AppSpacing.md),
        ],
      ),
    );
  }

  String _formatKey(String key) {
    return key
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  String _formatValue(dynamic value) {
    if (value == null) return 'N/A';
    if (value is bool) return value ? 'Yes' : 'No';
    if (value is List) return value.join(', ');
    if (value is num) return value.toString();
    if (value is! String) return value.toString();
    return value
        .split('_')
        .map((word) => word[0].toUpperCase() + word.substring(1))
        .join(' ');
  }

  Widget _buildVendorInfo() {
    final theme = Theme.of(context);
    final t = Translations.of(context).public_services.services_details;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.provider,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const Gap(AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: NetworkImageWidget(
                    imageUrl: widget.vendor.logoUrl,
                    fallbackAsset: FallbackImages.vendorLogo,
                    fit: BoxFit.cover,
                  ),
                ),
                const Gap(AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.vendor.businessName,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const Gap(AppSpacing.xs),
                      Text(
                        '${widget.vendor.totalServices} ${t.services} • ${widget.vendor.totalReviews} ${t.reviews}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkingHours() {
    final theme = Theme.of(context);
    final t = Translations.of(
      context,
    ).public_services.services_details.working_hours;
    final d = Translations.of(context).public_services.services_details.days;
    final workingHours = WorkingHours.fromJson(_effectiveWorkingHours!);

    final days = [
      (d.Monday, workingHours.monday),
      (d.Tuesday, workingHours.tuesday),
      (d.Wednesday, workingHours.wednesday),
      (d.Thursday, workingHours.thursday),
      (d.Friday, workingHours.friday),
      (d.Saturday, workingHours.saturday),
      (d.Sunday, workingHours.sunday),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(AppSpacing.sm),
          Row(
            children: [
              Icon(Icons.schedule, color: const Color(0xFFFE8C00), size: 18),
              const Gap(AppSpacing.sm),
              Text(
                t.title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: days.map((entry) {
                final dayName = entry.$1;
                final schedule = entry.$2;
                final isClosed = schedule == null;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 90,
                        child: Text(
                          dayName,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: isClosed
                                ? theme.colorScheme.onSurface.withOpacity(0.5)
                                : theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          isClosed
                              ? t.closed
                              : _formatTimeRange(schedule.open, schedule.close),
                          textAlign: TextAlign.right,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: isClosed
                                ? theme.colorScheme.onSurface.withOpacity(0.5)
                                : theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimeRange(String open, String close) {
    final now = DateTime.now();
    final openLocal = _utcTimeToLocal(now, open);
    final closeLocal = _utcTimeToLocal(now, close);
    return '${_formatTime12h(openLocal)} - ${_formatTime12h(closeLocal)}';
  }

  DateTime _utcTimeToLocal(DateTime referenceDate, String time24) {
    final parts = time24.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1].split(' ')[0]);
    return DateTime.utc(
      referenceDate.year,
      referenceDate.month,
      referenceDate.day,
      hour,
      minute,
    ).toLocal();
  }

  String _formatTime12h(DateTime dateTime) {
    var hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    if (hour == 0) {
      hour = 12;
    } else if (hour > 12) {
      hour = hour - 12;
    }
    return '$hour:$minute $period';
  }

  Widget _buildActionButtons() {
    final t = Translations.of(context).public_services.services_details.button;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // Expanded(
          //   child: GestureDetector(
          //     onTap: () {
          //       ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text('Cart feature coming soon')),
          //       );
          //     },
          //     child: Container(
          //       height: 56,
          //       decoration: BoxDecoration(
          //         border: Border.all(color: Colors.white),
          //         borderRadius: BorderRadius.circular(12),
          //       ),
          //       child: Center(
          //         child: Text(
          //           'ADD TO CART',
          //           style: GoogleFonts.poppins(
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold,
          //             color: Colors.white,
          //             letterSpacing: 1.0,
          //           ),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          // const Gap(AppSpacing.md),
          Expanded(
            child: GestureDetector(
              onTap: _isLoadingCategory ? null : _navigateToBooking,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE28C37), Color(0xFF854609)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: _isLoadingCategory
                      ? ShimmerSkeletons.buttonSkeleton(height: 56)
                      : Text(
                          t.title,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.0,
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewsSection() {
    final reviewsState = ref.watch(
      reviewsListNotifierProvider(widget.service.vendorId),
    );
    final reviewsNotifier = ref.read(
      reviewsListNotifierProvider(widget.service.vendorId).notifier,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: ReviewsSection(
        reviews: reviewsState.reviews,
        averageRating: reviewsState.averageRating,
        totalReviews: reviewsState.totalReviews,
        selectedRating: reviewsState.selectedRating,
        selectedSort: reviewsState.selectedSort,
        isLoading: reviewsState.isLoading,
        hasMore: reviewsState.hasMore,
        onRatingFilter: (rating) => reviewsNotifier.applyFilter(rating),
        onSortChange: (sort) => reviewsNotifier.applySort(sort),
        onLoadMore: () => reviewsNotifier.loadMore(),
        onRefresh: () => reviewsNotifier.loadReviews(
          vendorServiceId: widget.service.vendorId,
          vendorId: widget.vendor.id,
        ),
      ),
    );
  }
}
