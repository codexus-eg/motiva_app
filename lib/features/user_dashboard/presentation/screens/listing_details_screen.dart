// ignore_for_file: prefer_final_fields

import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/user_dashboard/presentation/screens/edit_specs_screen.dart';
import 'package:app/features/sell_your_car/domain/entities/entities.dart';
import 'package:app/features/user_dashboard/presentation/providers/listing_details_provider.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class ListingDetailsScreen extends ConsumerStatefulWidget {
  final String listingId;

  const ListingDetailsScreen({super.key, required this.listingId});

  @override
  ConsumerState<ListingDetailsScreen> createState() =>
      _ListingDetailsScreenState();
}

class _ListingDetailsScreenState extends ConsumerState<ListingDetailsScreen> {
  int _currentImageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final listingAsync = ref.watch(listingDetailsProvider(widget.listingId));

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: listingAsync.when(
        data: (listing) => _buildContent(listing),
        loading: () => ShimmerSkeletons.cardSkeleton(),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48, color: Colors.red),
              const Gap(AppSpacing.md),
              Text(
                Translations.of(
                  context,
                ).user_dashboard.listings.error.failed_to_load,
                style: TextStyle(color: theme.colorScheme.onSurface),
              ),
              const Gap(AppSpacing.sm),
              ElevatedButton(
                onPressed: () =>
                    ref.refresh(listingDetailsProvider(widget.listingId)),
                child: Text(
                  Translations.of(context).user_dashboard.listings.error.retry,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent(CarListing listing) {
    final images = listing.images;
    final hasImages = images.isNotEmpty;
    final t = Translations.of(context).user_dashboard.listing_details;
    final priceStr = listing.askingPrice != null
        ? 'KD ${listing.askingPrice!.toStringAsFixed(0)}'
        : t.price_on_request;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: _headerSection(hasImages, images, listing)),
          const SliverToBoxAdapter(child: Gap(AppSpacing.md)),
          SliverToBoxAdapter(child: _titleSection(priceStr, listing)),
          const SliverToBoxAdapter(child: Gap(AppSpacing.lg)),
          SliverToBoxAdapter(child: _inspectionCard(listing)),
          const SliverToBoxAdapter(child: Gap(AppSpacing.lg)),
          SliverToBoxAdapter(child: _specificationsSection(listing)),
          const SliverToBoxAdapter(child: Gap(AppSpacing.lg)),
          SliverToBoxAdapter(child: _descriptionSection(listing)),
          const SliverToBoxAdapter(child: Gap(AppSpacing.lg)),
          SliverToBoxAdapter(child: _buttonRow(context)),
          const SliverToBoxAdapter(child: Gap(AppSpacing.lg)),
        ],
      ),
    );
  }

  Widget _headerSection(
    bool hasImages,
    List<String> images,
    CarListing listing,
  ) {
    final theme = Theme.of(context);
    final t = Translations.of(context).user_dashboard.listing_details;
    final imageUrl = hasImages ? images.first : '';
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
              const Spacer(),
              Text(
                t.screen_title,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
            ],
          ),
          const Gap(AppSpacing.xl),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Stack(
              children: [
                _buildImage(hasImages, imageUrl),
                if (listing.isFeatured)
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
                        t.featured,
                        style: const TextStyle(color: Colors.white),
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
                        style: const TextStyle(color: Colors.white),
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

  Widget _buildImage(bool hasImages, String images) {
    final theme = Theme.of(context);
    if (!hasImages) {
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

    final isNetworkImage =
        images.startsWith('http://') || images.startsWith('https://');

    if (isNetworkImage) {
      return Image.network(
        images,
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
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Container(
            height: 240,
            width: double.infinity,
            color: theme.colorScheme.primaryContainer,
            child: const Center(child: CircularProgressIndicator()),
          );
        },
      );
    } else {
      return Image.asset(
        images,
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
  }

  Widget _titleSection(String priceStr, CarListing listing) {
    final t = Translations.of(context).user_dashboard.listing_details;
    final title = listing.title ?? '${listing.make} ${listing.model}';
    final isInspected = listing.inspectionReportUrl != null;
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
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isInspected ? Colors.green : Colors.red,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(
                  children: [
                    Icon(
                      isInspected
                          ? Icons.check_circle_outline
                          : Icons.cancel_outlined,
                      size: 16,
                      color: Colors.white,
                    ),
                    const Gap(AppSpacing.sm),
                    Text(
                      isInspected ? t.inspected : t.not_inspected,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ],
                ),
              ),
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
                    const Icon(
                      Icons.access_time,
                      size: 15,
                      color: Colors.white,
                    ),
                    const Gap(AppSpacing.sm),
                    Text(
                      _formatTimeAgo(context, listing.createdAt),
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.remove_red_eye_outlined,
                      size: 15,
                      color: Colors.white,
                    ),
                    const Gap(AppSpacing.sm),
                    Text(
                      t.view_details,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 15,
                      color: Colors.white,
                    ),
                    const Gap(AppSpacing.sm),
                    Text(
                      listing.locationCity ?? t.unknown_location,
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
          const Gap(AppSpacing.md),
          const Divider(color: Colors.white, thickness: 1),
        ],
      ),
    );
  }

  String _formatTimeAgo(BuildContext context, DateTime dateTime) {
    final t = Translations.of(context).user_dashboard.listing_details.time_ago;
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 30) {
      return t.months_ago.replaceAll(
        '{n}',
        (difference.inDays ~/ 30).toString(),
      );
    } else if (difference.inDays > 0) {
      return t.days_ago.replaceAll('{n}', difference.inDays.toString());
    } else if (difference.inHours > 0) {
      return t.hours_ago.replaceAll('{n}', difference.inHours.toString());
    } else if (difference.inMinutes > 0) {
      return t.minutes_ago.replaceAll('{n}', difference.inMinutes.toString());
    } else {
      return t.just_now;
    }
  }

  Widget _inspectionCard(CarListing listing) {
    final theme = Theme.of(context);
    final t = Translations.of(context).user_dashboard.listing_details;
    final hasInspection = listing.inspectionReportUrl != null;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: hasInspection ? Colors.orange : Colors.grey,
          ),
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
                    t.inspection.title,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Gap(AppSpacing.sm),
                  Text(
                    hasInspection
                        ? t.inspection.has_report_desc
                        : t.inspection.no_report_desc,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const Gap(AppSpacing.md),
                  GestureDetector(
                    onTap: hasInspection ? () {} : null,
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
                            t.inspection.view_report,
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

  Widget _specificationsSection(CarListing listing) {
    final t = Translations.of(
      context,
    ).user_dashboard.listing_details.specifications;
    final labels = t.labels;
    final specs = [
      {'label': labels.make, 'value': listing.make},
      {'label': labels.model, 'value': listing.model},
      {'label': labels.trim, 'value': listing.trim ?? t.na},
      {'label': labels.year, 'value': listing.year.toString()},
      {'label': labels.mileage, 'value': '${listing.mileage} km'},
      {
        'label': labels.transmission,
        'value': listing.transmission?.name ?? t.na,
      },
      {'label': labels.engine, 'value': listing.engineSize ?? t.na},
      {'label': labels.color, 'value': listing.color ?? t.na},
    ];

    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                t.title,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditSpecsScreen(
                        listingId: widget.listingId,
                        listing: listing,
                      ),
                    ),
                  ).then((result) {
                    if (result == true) {
                      ref.invalidate(listingDetailsProvider(widget.listingId));
                    }
                  });
                },
                child: Text(
                  "Edit",
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
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

  void _showEditDescriptionDialog(String currentDescription) {
    final controller = TextEditingController(text: currentDescription);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            Translations.of(
              context,
            ).user_dashboard.listing_details.description.edit_dialog_title,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          content: TextField(
            controller: controller,
            maxLines: 8,
            decoration: InputDecoration(
              hintText: Translations.of(
                context,
              ).user_dashboard.listing_details.description.edit_dialog_hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                Translations.of(
                  context,
                ).user_dashboard.listing_details.description.cancel,
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                Translations.of(
                  context,
                ).user_dashboard.listing_details.description.save,
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _descriptionSection(CarListing listing) {
    final theme = Theme.of(context);
    final description =
        listing.description ??
        Translations.of(
          context,
        ).user_dashboard.listing_details.description.no_description;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Translations.of(
                  context,
                ).user_dashboard.listing_details.description.title,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextButton(
                onPressed: () => _showEditDescriptionDialog(description),
                child: Text(
                  Translations.of(
                    context,
                  ).user_dashboard.listing_details.specifications.edit,
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
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

  Widget _buttonRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: GradientButton(
        text: Translations.of(
          context,
        ).user_dashboard.listing_details.save_button,
        onTap: () {},
      ),
    );
  }
}
