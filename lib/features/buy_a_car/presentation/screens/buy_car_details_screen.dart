// ignore_for_file: prefer_final_fields

import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/buy_a_car/presentation/providers/car_listings_notifier.dart';
import 'package:app/features/buy_a_car/presentation/screens/car_chat_screen.dart';
import 'package:app/features/sell_your_car/domain/entities/entities.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:app/core/theme/spacing.dart';

class BuyCarDetailsScreen extends ConsumerStatefulWidget {
  final String? listingId;
  final bool isGood;
  final bool isInspected;

  const BuyCarDetailsScreen({
    super.key,
    this.listingId,
    this.isGood = true,
    this.isInspected = false,
  });

  @override
  ConsumerState<BuyCarDetailsScreen> createState() =>
      _BuyCarDetailsScreenState();
}

class _BuyCarDetailsScreenState extends ConsumerState<BuyCarDetailsScreen> {
  int _currentImageIndex = 0;

  @override
  void initState() {
    super.initState();
    debugPrint(
      'BuyCarDetailsScreen: initState called with listingId: ${widget.listingId}',
    );
    if (widget.listingId != null) {
      Future.microtask(() {
        debugPrint('BuyCarDetailsScreen: calling fetchListing');
        ref
            .read(carDetailNotifierProvider.notifier)
            .fetchListing(widget.listingId!);
      });
    } else {
      debugPrint('BuyCarDetailsScreen: listingId is null, skipping fetch');
    }
  }

  @override
  Widget build(BuildContext context) {
    final detailState = ref.watch(carDetailNotifierProvider);
    final listing = detailState.listing;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: detailState.isLoading
          ? ShimmerSkeletons.cardSkeleton()
          : detailState.error != null
          ? _buildErrorState(detailState.error!)
          : listing != null
          ? _buildContent(listing)
          : _buildContent(null),
    );
  }

  Widget _buildErrorState(String error) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: Colors.red[400]),
            Gap(AppSpacing.md),
            Text(
              t.buy_a_car.details_screen.failed_to_load_listing,
              style: GoogleFonts.poppins(
                color: theme.colorScheme.onSurface,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(AppSpacing.sm),
            Text(
              error,
              style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 14),
              textAlign: TextAlign.center,
            ),
            Gap(AppSpacing.lg),
            ElevatedButton(
              onPressed: () {
                if (widget.listingId != null) {
                  ref
                      .read(carDetailNotifierProvider.notifier)
                      .fetchListing(widget.listingId!);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFDC8735),
              ),
              child: Text(
                t.buy_a_car.details_screen.retry,
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(CarListing? listing) {
    final images = listing?.images ?? [];
    final hasImages = images.isNotEmpty;
    final priceStr = listing?.askingPrice != null
        ? 'KD ${listing!.askingPrice!.toInt()}'
        : t.buy_a_car.details_screen.price_on_request;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: _headerSection(listing, hasImages, images),
            ),
            const SliverToBoxAdapter(child: Gap(AppSpacing.md)),
            SliverToBoxAdapter(child: _titleSection(listing, priceStr)),
            const SliverToBoxAdapter(child: Gap(AppSpacing.lg)),
            SliverToBoxAdapter(
              child: (listing?.inspectionReportUrl != null)
                  ? _inspectionCard(listing!)
                  : null,
            ),
            SliverToBoxAdapter(
              child: (listing?.inspectionReportUrl != null)
                  ? Gap(AppSpacing.lg)
                  : null,
            ),
            SliverToBoxAdapter(child: _specificationsSection(listing)),
            const SliverToBoxAdapter(child: Gap(AppSpacing.lg)),
            SliverToBoxAdapter(child: _descriptionSection(listing)),
            const SliverToBoxAdapter(child: Gap(AppSpacing.lg)),
            SliverToBoxAdapter(child: _locationSection(listing)),
            const SliverToBoxAdapter(child: Gap(AppSpacing.lg)),
            SliverToBoxAdapter(child: _promoBanner()),
            const SliverToBoxAdapter(child: Gap(AppSpacing.lg)),
            SliverToBoxAdapter(child: _buttonRow(context)),
            const SliverToBoxAdapter(child: Gap(AppSpacing.lg)),
          ],
        ),
      ),
    );
  }

  Widget _headerSection(
    CarListing? listing,
    bool hasImages,
    List<String> images,
  ) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              Spacer(),
              Text(
                t.buy_a_car.details_screen.about_this_car,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(),
              Icon(Icons.favorite_border, color: theme.colorScheme.onSurface),
              Gap(AppSpacing.md),
              Icon(Icons.share, color: theme.colorScheme.onSurface),
            ],
          ),
          const Gap(AppSpacing.xl),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                _buildImage(hasImages, images),
                if (listing?.isFeatured == true)
                  Positioned(
                    top: 12,
                    left: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        t.buy_a_car.details_screen.featured,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                if (hasImages && images.length > 1)
                  Positioned(
                    bottom: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "${_currentImageIndex + 1}/${images.length}",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(bool hasImages, List<String> images) {
    final theme = Theme.of(context);
    if (hasImages) {
      return Image.network(
        images[_currentImageIndex],
        height: 240,
        width: double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 240,
            width: double.infinity,
            color: theme.colorScheme.primaryContainer,
            child: Icon(
              Icons.directions_car,
              size: 64,
              color: theme.colorScheme.onSurface,
            ),
          );
        },
      );
    }
    return Container(
      height: 240,
      width: double.infinity,
      color: theme.colorScheme.primaryContainer,
      child: Icon(
        Icons.directions_car,
        size: 64,
        color: theme.colorScheme.onSurface,
      ),
    );
  }

  Widget _titleSection(CarListing? listing, String priceStr) {
    final title = listing != null
        ? '${listing.make} ${listing.model} ${listing.year}'
        : t.buy_a_car.details_screen.car_details;
    final location =
        listing?.locationCity ??
        t.buy_a_car.details_screen.location_not_specified;
    final conditionBadge = listing?.conditionStatus != null
        ? _getConditionBadge(listing!.conditionStatus)
        : null;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 24,
              fontFamily: 'Pepsi',
            ),
          ),
          const Gap(AppSpacing.md),
          Row(
            children: [
              Text(
                priceStr,
                style: const TextStyle(
                  color: Colors.orange,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              if (listing?.inspectionReportUrl != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: Colors.white,
                      ),
                      const Gap(AppSpacing.sm),
                      Text(
                        t.buy_a_car.details_screen.inspected,
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ],
                  ),
                ),
              if (conditionBadge != null) ...[
                Gap(AppSpacing.sm),
                conditionBadge,
              ],
            ],
          ),
          const Gap(AppSpacing.md),
          Container(
            height: 30,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFFE8C00).withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(5),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.access_time, size: 15, color: Colors.white),
                    Gap(AppSpacing.sm),
                    Text(
                      _formatTimeAgo(listing?.createdAt),
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.remove_red_eye_outlined,
                      size: 15,
                      color: Colors.white,
                    ),
                    Gap(AppSpacing.sm),
                    Text(
                      t.buy_a_car.details_screen.view_details,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 15,
                      color: Colors.white,
                    ),
                    Gap(AppSpacing.sm),
                    Text(
                      location,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Gap(AppSpacing.md),
          Divider(color: Colors.white, thickness: 1),
        ],
      ),
    );
  }

  Widget? _getConditionBadge(VehicleCondition condition) {
    Color color;
    String text;

    switch (condition) {
      case VehicleCondition.excellent:
        color = Colors.green;
        text = t.buy_a_car.details_screen.condition.excellent;
        break;
      case VehicleCondition.good:
        color = Colors.lightGreen;
        text = t.buy_a_car.details_screen.condition.good;
        break;
      case VehicleCondition.fair:
        color = Colors.orange;
        text = t.buy_a_car.details_screen.condition.fair;
        break;
      case VehicleCondition.poor:
        color = Colors.red[700]!;
        text = t.buy_a_car.details_screen.condition.poor;
        break;
      case VehicleCondition.damaged:
        color = Colors.red;
        text = t.buy_a_car.details_screen.condition.damaged;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(text, style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  Widget _inspectionCard(CarListing listing) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.orange),
          color: const Color(0xFF1A1D24),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.buy_a_car.details_screen.inspection_report.title,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(AppSpacing.sm),
                  Text(
                    t.buy_a_car.details_screen.inspection_report.description,
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const Gap(AppSpacing.md),
                  GestureDetector(
                    onTap: listing.inspectionReportUrl != null
                        ? () => _openInspectionReport(
                            listing.inspectionReportUrl!,
                          )
                        : null,
                    child: Container(
                      height: 50,
                      width: 200,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: theme.colorScheme.primary),
                      ),
                      child: Row(
                        children: [
                          Text(
                            t
                                .buy_a_car
                                .details_screen
                                .inspection_report
                                .view_report,
                            style: GoogleFonts.poppins(
                              color: theme.colorScheme.primary,
                              fontSize: 12,
                            ),
                          ),
                          Gap(AppSpacing.sm),
                          const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.orange,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.md),
            Expanded(
              flex: 1,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  "assets/images/inspection_report.png",
                  height: 130,
                  width: 130,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _specificationsSection(CarListing? listing) {
    final specs = [
      {
        'label': t.buy_a_car.details_screen.spec_labels.make,
        'value': listing?.make ?? t.buy_a_car.details_screen.na,
      },
      {
        'label': t.buy_a_car.details_screen.spec_labels.model,
        'value': listing?.model ?? t.buy_a_car.details_screen.na,
      },
      {
        'label': t.buy_a_car.details_screen.spec_labels.trim,
        'value': listing?.trim ?? t.buy_a_car.details_screen.na,
      },
      {
        'label': t.buy_a_car.details_screen.spec_labels.year,
        'value': listing?.year.toString() ?? t.buy_a_car.details_screen.na,
      },
      {
        'label': t.buy_a_car.details_screen.spec_labels.mileage,
        'value': listing != null
            ? '${_formatNumber(listing.mileage)} km'
            : t.buy_a_car.details_screen.na,
      },
      {
        'label': t.buy_a_car.details_screen.spec_labels.transmission,
        'value':
            listing?.transmission?.name.toUpperCase() ??
            t.buy_a_car.details_screen.na,
      },
      {
        'label': t.buy_a_car.details_screen.spec_labels.engine,
        'value': listing?.engineSize ?? t.buy_a_car.details_screen.na,
      },
      {
        'label': t.buy_a_car.details_screen.spec_labels.color,
        'value': listing?.color ?? t.buy_a_car.details_screen.na,
      },
    ];

    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.buy_a_car.details_screen.specifications,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(AppSpacing.md),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: specs.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 50,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemBuilder: (_, index) {
              return Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      specs[index]['label'] as String,
                      style: TextStyle(color: Colors.grey[600], fontSize: 11),
                    ),
                    Gap(AppSpacing.xs),
                    Text(
                      specs[index]['value'] as String,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 13,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _descriptionSection(CarListing? listing) {
    final description =
        listing?.description ?? t.buy_a_car.details_screen.no_description;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.buy_a_car.details_screen.description,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Gap(AppSpacing.md),
          Text(
            description,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationSection(CarListing? listing) {
    final location =
        listing?.locationCity ??
        t.buy_a_car.details_screen.location_not_specified;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.buy_a_car.details_screen.location,
                    style: GoogleFonts.poppins(
                      color: theme.colorScheme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(AppSpacing.md),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 16,
                        color: Colors.grey,
                      ),
                      Gap(AppSpacing.sm),
                      Expanded(
                        child: Text(
                          location,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.md),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 90,
                width: 110,
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/map_preview.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    Container(color: Colors.black.withValues(alpha: 0.2)),
                    const Center(
                      child: Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 28,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _promoBanner() {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: 347,
        height: 142,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.white),
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              top: 0,
              left: 84,
              child: SvgPicture.asset(
                'assets/images/ad_bg_1.svg',
                width: 262.5,
                height: 86.6,
              ),
            ),
            Positioned(
              left: 264,
              top: 80,
              child: Transform.rotate(
                angle: 3.14159,
                child: SvgPicture.asset(
                  'assets/images/ad_bg_2.svg',
                  width: 263,
                  height: 60,
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 22,
              child: SizedBox(
                width: 156,
                child: Text(
                  'Road Assistance\n at 10% Off - Book Now!',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: theme.onSurface,
                    height: 1.3,
                  ),
                ),
              ),
            ),
            Positioned(
              right: -50,
              top: 30,
              child: SizedBox(
                width: 260,
                child: Image.asset(
                  'assets/images/ad_car.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GradientButton(
            text: t.buy_a_car.details_screen.call_now,
            onTap: () {},
            width: 160,
          ),
          GradientButton(
            text: t.buy_a_car.details_screen.chat,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CarChatScreen()),
              );
            },
            width: 160,
            isPrimary: false,
          ),
        ],
      ),
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(0)}k';
    }
    return number.toString();
  }

  String _formatTimeAgo(DateTime? createdAt) {
    if (createdAt == null) return 'Unknown';

    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}mo ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    }
    return 'Just now';
  }

  Future<void> _openInspectionReport(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.buy_a_car.details_screen.error_open_report)),
        );
      }
    }
  }
}
