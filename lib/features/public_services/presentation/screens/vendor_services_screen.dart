import 'package:app/core/utils/fallback_images.dart';
import 'package:app/features/public_services/domain/entities/entities.dart';
import 'package:app/features/public_services/presentation/providers/public_services_provider.dart';
import 'package:app/features/public_services/presentation/screens/vendor_service_detail_screen.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/images/cover_image_widget.dart';
import 'package:app/shared/ui/images/network_image_widget.dart';
import 'package:app/shared/ui/inputs/custom_search_bar.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class VendorServicesScreen extends ConsumerStatefulWidget {
  final PublicVendor vendor;
  final ServiceCategory category;

  const VendorServicesScreen({
    super.key,
    required this.vendor,
    required this.category,
  });

  @override
  ConsumerState<VendorServicesScreen> createState() =>
      _VendorServicesScreenState();
}

class _VendorServicesScreenState extends ConsumerState<VendorServicesScreen> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final servicesAsync = ref.watch(
      vendorServicesByParamsProvider(
        VendorServicesParams(
          vendorId: widget.vendor.id,
          categoryId: widget.category.id,
        ),
      ),
    );

    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: 350,
            child: _buildBackgroundImage(),
          ),
          SingleChildScrollView(
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(AppSpacing.xl),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const Gap(AppSpacing.lg),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildVendorHeader(),
              ),
              const Gap(AppSpacing.xl),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(AppSpacing.md),
                    _buildDragHandle(),
                    const Gap(AppSpacing.lg),
                    _buildPopularServices(context, servicesAsync),
                    const Gap(AppSpacing.lg),
                    _buildSearchBar(),
                    const Gap(AppSpacing.lg),
                    _buildAllServices(servicesAsync),
                    const Gap(AppSpacing.xl),
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

  Widget _buildBackgroundImage() {
    return CoverImageWidget(
      imageUrl: widget.vendor.coverImageUrl,
      fallbackAsset: FallbackImages.vendorCoverDefault,
      height: 350,
      gradientOpacity: 0.3,
    );
  }

  Widget _buildVendorHeader() {
    final t = Translations.of(context).public_services.vendor_services;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: NetworkImageWidget(
            imageUrl: widget.vendor.logoUrl,
            fallbackAsset: FallbackImages.vendorLogo,
            fit: BoxFit.contain,
          ),
        ),
        const Gap(AppSpacing.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.vendor.businessName.toUpperCase(),
                style: const TextStyle(
                  fontFamily: 'Pepsi',
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                  letterSpacing: 1.0,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Text(
                  widget.vendor.rating ?? '0.0',
                  style: GoogleFonts.montserrat(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                const Gap(AppSpacing.xs),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      Icons.star,
                      size: 12,
                      color:
                          index <
                              (double.tryParse(
                                    widget.vendor.rating ?? '0',
                                  )?.round() ??
                                  0)
                          ? const Color(0xFFFFC107)
                          : Colors.grey,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        const Gap(AppSpacing.xs),
        Text(
          '${widget.vendor.totalServices} ${t.services} • ${widget.vendor.totalReviews} ${t.reviews}',
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white70),
        ),
      ],
    );
  }

  Widget _buildDragHandle() {
    final theme = Theme.of(context);
    return Center(
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: theme.colorScheme.onSurface,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildPopularServices(
    BuildContext context,
    AsyncValue<List<PublicVendorService>> servicesAsync,
  ) {
    final theme = Theme.of(context);
    final t = Translations.of(context).public_services.vendor_services;

    return servicesAsync.maybeWhen(
      data: (services) {
        final popular = services.take(3).toList();
        if (popular.isEmpty) return const SizedBox.shrink();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                t.most_popular,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            const Gap(AppSpacing.md),
            SizedBox(
              height: 175,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                scrollDirection: Axis.horizontal,
                itemCount: popular.length,
                separatorBuilder: (_, _) => const Gap(AppSpacing.md),
                itemBuilder: (context, index) {
                  final service = popular[index];
                  return GestureDetector(
                    onTap: () => _navigateToServiceDetail(context, service),
                    child: SizedBox(
                      width: 142,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            width: 142,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: theme.colorScheme.primaryContainer,
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: NetworkImageWidget(
                              imageUrl: service.imageUrl,
                              fallbackAsset: FallbackImages.serviceDefault,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Gap(AppSpacing.sm),
                          Text(
                            service.name,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: theme.colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
      orElse: () => const SizedBox.shrink(),
    );
  }

  Widget _buildSearchBar() {
    final t = Translations.of(context).public_services.vendor_services;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: CustomSearchBar(
        controller: _searchController,
        onChanged: (value) {
          setState(() {
            _searchQuery = value.toLowerCase();
          });
        },
        hintText: t.search,
        isBuyCar: false,
      ),
    );
  }

  Widget _buildAllServices(
    AsyncValue<List<PublicVendorService>> servicesAsync,
  ) {
    final theme = Theme.of(context);
    final t = Translations.of(context).public_services.vendor_services;

    return servicesAsync.when(
      loading: () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            for (int i = 0; i < 4; i++) ...[
              ShimmerSkeletons.listItemSkeleton(
                height: 80,
                showLeadingCircle: true,
              ),
              const Gap(AppSpacing.md),
            ],
          ],
        ),
      ),
      error: (error, _) => Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Text(
            t.error_service,
            style: GoogleFonts.poppins(color: Colors.red),
          ),
        ),
      ),
      data: (services) {
        final filtered = services.where((s) {
          if (_searchQuery.isEmpty) return true;
          return s.name.toLowerCase().contains(_searchQuery);
        }).toList();

        if (filtered.isEmpty) {
          return Padding(
            padding: const EdgeInsets.all(32),
            child: Center(
              child: Text(
                t.null_service,
                style: GoogleFonts.poppins(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ),
          );
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    t.all_services,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        Text(
                          t.reviews,
                          style: GoogleFonts.roboto(
                            fontSize: 12,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const Gap(AppSpacing.xs),
                        Icon(
                          Icons.chat_bubble_outline,
                          color: theme.colorScheme.onSurface,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.md),
            ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filtered.length,
              separatorBuilder: (_, _) => const Gap(AppSpacing.md),
              itemBuilder: (context, index) {
                final service = filtered[index];
                return GestureDetector(
                  onTap: () => _navigateToServiceDetail(context, service),
                  child: _buildServiceCard(service),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildServiceCard(PublicVendorService service) {
    final theme = Theme.of(context);
    final t = Translations.of(
      context,
    ).public_services.vendor_services.service_card;
    return Container(
      height: 161,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 12, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    service.name,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface,
                      height: 1.4,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Gap(AppSpacing.xs),
                  Text(
                    service.description ?? t.description,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      fontWeight: FontWeight.w300,
                      color: theme.colorScheme.onPrimaryContainer,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Row(
                    children: [
                      if (service.basePrice != null) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: const Color(0xFFF8BA7F)),
                          ),
                          child: Text(
                            'KD ${service.basePrice}',
                            style: GoogleFonts.montserrat(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFFF8BA7F),
                            ),
                          ),
                        ),
                        const Gap(AppSpacing.md),
                      ],
                    ],
                  ),
                  const Gap(AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFDC8735), Color(0xFFDC8735)],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/shopping_bag.svg',
                          height: 11,
                          width: 11,
                          colorFilter: const ColorFilter.mode(
                            Colors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        const Gap(AppSpacing.xs),
                        Text(
                          t.button,
                          style: GoogleFonts.montserrat(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 160,
            height: double.infinity,
            child: NetworkImageWidget(
              imageUrl: service.imageUrl,
              fallbackAsset: FallbackImages.serviceDefault,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToServiceDetail(
    BuildContext context,
    PublicVendorService service,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            VendorServiceDetailScreen(service: service, vendor: widget.vendor),
      ),
    );
  }
}
