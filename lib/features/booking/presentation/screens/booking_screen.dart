// ignore_for_file: deprecated_member_use

import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils/fallback_images.dart';
import '../../../../core/utils/error_display.dart';
import '../../../public_services/domain/entities/entities.dart';
import '../../../service-categories/domain/entities/service_category.dart';
import '../../../vendor/domain/entities/working_hours.dart';
import '../../../../shared/ui/map/location_picker_widget.dart';
import '../../../../shared/ui/forms/dynamic_form_builder.dart';
import '../../domain/entities/booking_state.dart';
import '../providers/booking_provider.dart';
import '../providers/available_slots_provider.dart';
import 'order_confirmation_screen.dart';
import 'package:app/core/theme/spacing.dart';

class BookingScreen extends ConsumerStatefulWidget {
  final PublicVendorService service;
  final PublicVendor vendor;
  final ServiceCategoryWithSchema category;

  const BookingScreen({
    super.key,
    required this.service,
    required this.vendor,
    required this.category,
  });

  @override
  ConsumerState<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends ConsumerState<BookingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dynamicFormKey = GlobalKey<DynamicFormBuilderState>();
  final _addressController = TextEditingController();
  final _addressAdditionalController = TextEditingController();
  final _pickupAddressController = TextEditingController();
  final _dropOffAddressController = TextEditingController();

  String? _locationError;
  String? _pickupError;
  String? _dropOffError;
  String? _slotError;

  bool get requiresGps => widget.category.behaviorConfig.requiresGps;
  bool get allowsScheduling => widget.category.behaviorConfig.allowsScheduling;
  bool get requiresRoute => widget.category.behaviorConfig.requiresRoute;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeBooking();
    });
  }

  void _initializeBooking() {
    ref
        .read(bookingStateProvider.notifier)
        .initialize(
          vendorServiceId: widget.service.id,
          vendorId: widget.vendor.id,
          categoryId: widget.category.id,
          serviceName: widget.service.name,
          serviceDescription: widget.service.description,
          basePrice: widget.service.basePrice ?? '0',
          vendorName: widget.vendor.businessName,
          vendorLogoUrl: widget.vendor.logoUrl,
          requiresGps: requiresGps,
          allowsScheduling: allowsScheduling,
          requiresRoute: requiresRoute,
          categoryServiceAttributes: widget.service.categoryServiceAttributes,
          requiredCustomerFields: widget.service.requiredCustomerFields,
        );

    // Store vendor working hours for auto-selection
    _vendorWorkingHours = widget.vendor.workingHours;

    // Fetch available slots if scheduling is allowed
    if (allowsScheduling) {
      _selectBestAvailableDate();
    }
  }

  void _selectBestAvailableDate() {
    final nextAvailable = _findNextAvailableDay(_vendorWorkingHours);

    if (nextAvailable != null) {
      final now = DateTime.now().toUtc();
      final isToday = nextAvailable.year == now.year && nextAvailable.month == now.month && nextAvailable.day == now.day;
      setState(() {
        _selectedDate = nextAvailable;
        _nextAvailableDate = nextAvailable;
      });

      // Show snackbar if we're auto-selecting a future date
      if (!isToday) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _showNextAvailableSnackbar(nextAvailable);
        });
      }
    }

    // Fetch available slots for the selected date
    ref
        .read(availableSlotsProvider.notifier)
        .fetchAvailableSlots(
          vendorServiceId: widget.service.id,
          date: _selectedDate,
        );
  }

  void _showNextAvailableSnackbar(DateTime date) {
    final t = Translations.of(context).booking.booking_screen.scheduling;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${t.next_available}: ${_formatDate(date)}',
          style: GoogleFonts.poppins(fontSize: 13),
        ),
        backgroundColor: const Color(0xFFFE8C00),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  DateTime? _findNextAvailableDay(Map<String, dynamic>? workingHoursJson) {
    if (workingHoursJson == null) return null;

    final workingHours = WorkingHours.fromJson(workingHoursJson);
    final now = DateTime.now().toUtc();
    // Start from today to look for the next available day
    final todayIndex = now.weekday - 1; // weekday is 1-7 (Mon-Sun), array is 0-6
    final days = ['monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday', 'sunday'];

    // Look ahead up to 30 days
    for (int i = 0; i < 30; i++) {
      final dayOffset = now.add(Duration(days: i));
      final dayName = days[(todayIndex + i) % 7];
      final schedule = workingHours.getScheduleForDay(dayName);

      if (schedule != null) {
        // This day has working hours, return a UTC date
        return DateTime.utc(dayOffset.year, dayOffset.month, dayOffset.day);
      }
    }

    return null; // No available days found within 30 days
  }

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  void _selectNextAvailableDay() {
    if (_nextAvailableDate != null) {
      setState(() {
        _selectedDate = _nextAvailableDate!;
        _selectedSlotIndex = -1;
      });
      _updateScheduledAt();

      ref
          .read(availableSlotsProvider.notifier)
          .fetchAvailableSlots(
            vendorServiceId: widget.service.id,
            date: _nextAvailableDate!,
          );
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _addressAdditionalController.dispose();
    _pickupAddressController.dispose();
    _dropOffAddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bookingState = ref.watch(bookingStateProvider);
    final submissionState = ref.watch(bookingSubmissionProvider);
    final theme = Theme.of(context);
    final t = Translations.of(context).booking.booking_screen;

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          tooltip: SemanticLabels.backButton,
          icon: Icon(Icons.arrow_back_ios, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          t.title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildServiceSummary(),
            const Divider(color: Color(0xFF383A42), height: 1),
            if (requiresGps) _buildLocationSection(),
            if (requiresRoute) ...[
              _buildRouteSection(isPickup: true),
              _buildRouteSection(isPickup: false),
            ],
            if (allowsScheduling) _buildSchedulingSection(),
            _buildVendorAttributesSection(),
            _buildCustomerFieldsSection(),
            _buildOrderSummary(),
            if (submissionState.hasError)
              _buildErrorCard(submissionState.error.toString()),
            _buildBottomBar(bookingState, submissionState.isLoading),
          ],
        ),
      ),
    ));
  }

  Widget _buildServiceSummary() {
    final serviceImage =
        widget.service.imageUrl ?? FallbackImages.serviceDefault;
    final isNetworkImage =
        widget.service.imageUrl != null && widget.service.imageUrl!.isNotEmpty;

    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: theme.colorScheme.primaryContainer,
            ),
            clipBehavior: Clip.antiAlias,
            child: isNetworkImage
                ? Image.network(
                    serviceImage,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Image.asset(
                      FallbackImages.serviceDefault,
                      fit: BoxFit.cover,
                    ),
                  )
                : Image.asset(serviceImage, fit: BoxFit.cover),
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.service.name,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const Gap(AppSpacing.xs),
                Text(
                  widget.vendor.businessName,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                const Gap(AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFF8BA7F)),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'KD ${widget.service.basePrice ?? '0'}',
                    style: GoogleFonts.montserrat(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF8BA7F),
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

  Widget _buildLocationSection() {
    final bookingState = ref.watch(bookingStateProvider);
    final theme = Theme.of(context);
    final t = Translations.of(context).booking.booking_screen.location;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Color(0xFFFE8C00), size: 20),
              const Gap(AppSpacing.sm),
              Text(
                t.title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              if (bookingState.locationLat != null)
                Text(
                  t.selected,
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.green),
                ),
            ],
          ),
          const Gap(AppSpacing.md),
          _buildMapPicker(),
          const SizedBox(height: 12),
          TextFormField(
            controller: _addressAdditionalController,
            style: TextStyle(color: theme.colorScheme.onSurface),
            decoration: InputDecoration(
              hintText: t.additional_details,
              hintStyle: GoogleFonts.poppins(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
              ),
              filled: true,
              fillColor: theme.colorScheme.primaryContainer,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            onChanged: (value) {
              ref
                  .read(bookingStateProvider.notifier)
                  .setPickupLocation(
                    bookingState.locationLat ?? 0,
                    bookingState.locationLng ?? 0,
                    value,
                  );
              if (_locationError != null) setState(() => _locationError = null);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRouteSection({required bool isPickup}) {
    final t = Translations.of(context).booking.booking_screen.location;
    final bookingState = ref.watch(bookingStateProvider);
    final lat = isPickup ? bookingState.pickupLat : bookingState.dropOffLat;
    final address = isPickup
        ? bookingState.pickupAddress
        : bookingState.dropOffAddress;
    final controller = isPickup
        ? _pickupAddressController
        : _dropOffAddressController;
    final title = isPickup ? t.pickup : t.drop_off;
    final icon = isPickup ? Icons.trip_origin : Icons.location_on;
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFFE8C00), size: 20),
              const Gap(AppSpacing.sm),
              Text(
                title,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const Spacer(),
              if (lat != null)
                Text(
                  t.selected,
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.green),
                ),
            ],
          ),
          const Gap(AppSpacing.md),
          GestureDetector(
            onTap: () => _openRouteMapPicker(isPickup: isPickup),
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: (isPickup ? _pickupError : _dropOffError) != null
                      ? Colors.red.withOpacity(0.5)
                      : Colors.transparent,
                ),
              ),
              child: Stack(
                children: [
                  if (lat != null)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 36,
                          ),
                          const Gap(AppSpacing.sm),
                          Text(
                            '$title ${t.selected}',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          if (address != null)
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: Text(
                                address,
                                style: GoogleFonts.poppins(
                                  fontSize: 11,
                                  color: theme.colorScheme.onSurface.withValues(
                                    alpha: 0.7,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                        ],
                      ),
                    )
                  else
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.map,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.54,
                            ),
                            size: 36,
                          ),
                          const Gap(AppSpacing.sm),
                          Text(
                            '${t.tap_to_select} $title',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.54,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFE8C00),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.edit_location,
                            color: Colors.white,
                            size: 14,
                          ),
                          const Gap(AppSpacing.xs),
                          Text(
                            t.pick,
                            style: GoogleFonts.poppins(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if ((isPickup ? _pickupError : _dropOffError) != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                isPickup ? _pickupError! : _dropOffError!,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.red),
              ),
            ),
          TextFormField(
            controller: controller,
            style: TextStyle(color: theme.colorScheme.onSurface),
            decoration: InputDecoration(
              hintText: t.additional_details,
              hintStyle: GoogleFonts.poppins(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
              ),
              filled: true,
              fillColor: theme.colorScheme.primaryContainer,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
            ),
            onChanged: (value) {
              if (isPickup) {
                ref
                    .read(bookingStateProvider.notifier)
                    .setPickupLocation(
                      bookingState.pickupLat ?? 0,
                      bookingState.pickupLng ?? 0,
                      value,
                    );
                if (_pickupError != null) setState(() => _pickupError = null);
              } else {
                ref
                    .read(bookingStateProvider.notifier)
                    .setDropoffLocation(
                      bookingState.dropOffLat ?? 0,
                      bookingState.dropOffLng ?? 0,
                      value,
                    );
                if (_dropOffError != null) setState(() => _dropOffError = null);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMapPicker() {
    final bookingState = ref.watch(bookingStateProvider);
    final theme = Theme.of(context);
    final t = Translations.of(context).booking.booking_screen.location;

    return GestureDetector(
      onTap: _openMapPicker,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _locationError != null
                ? Colors.red.withOpacity(0.5)
                : Colors.transparent,
          ),
        ),
        child: Stack(
          children: [
            if (bookingState.locationLat != null)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                      size: 48,
                    ),
                    const Gap(AppSpacing.sm),
                    Text(
                      t.location_selected,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    if (bookingState.locationAddress != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          bookingState.locationAddress!,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.7,
                            ),
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                  ],
                ),
              )
            else
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.map,
                      color: theme.colorScheme.onSurface.withValues(
                        alpha: 0.54,
                      ),
                      size: 48,
                    ),
                    const Gap(AppSpacing.sm),
                    Text(
                      t.tap_to_select_location,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFE8C00),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.edit_location,
                      color: Colors.white,
                      size: 16,
                    ),
                    const Gap(AppSpacing.xs),
                    Text(
                      t.pick_location,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
      if (_locationError != null)
        Padding(
          padding: const EdgeInsets.only(top: 6),
          child: Text(
            _locationError!,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.red),
          ),
        ),
          ],
        ),
      ),
    );
  }

  Widget _buildSchedulingSection() {
    final theme = Theme.of(context);
    final t = Translations.of(context).booking.booking_screen.scheduling;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.schedule, color: Color(0xFFFE8C00), size: 20),
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
          _buildChooseDateField(context),
          const Gap(AppSpacing.md),
          _buildAvailableTimeChips(),
        ],
      ),
    );
  }

  DateTime _selectedDate = DateTime.utc(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  int _selectedSlotIndex = -1; // -1 means no selection (ASAP)
  DateTime? _nextAvailableDate; // Auto-detected next available day
  Map<String, dynamic>? _vendorWorkingHours;

  void _updateScheduledAt() {
    // This method is called when slot selection changes
    // For dynamic slots, we use _updateScheduledAtFromDynamicSlot instead
    if (_selectedSlotIndex == -1) {
      ref.read(bookingStateProvider.notifier).clearScheduledAt();
    }
  }

  void _updateScheduledAtFromDynamicSlot(String timeSlot) {
    // Parse time slot format like "9:00 AM" or "14:30" (24-hour from backend)
    final timeParts = timeSlot.split(':');
    final hour = int.parse(timeParts[0]);
    final minuteParts = timeParts[1].split(' ');
    var minute = int.parse(minuteParts[0]);

    var adjustedHour = hour;
    if (minuteParts.length > 1) {
      final period = minuteParts[1];
      if (period == 'PM' && hour != 12) {
        adjustedHour = hour + 12;
      } else if (period == 'AM' && hour == 12) {
        adjustedHour = 0;
      }
    }

    // Construct as UTC — slot times from backend are UTC
    final scheduledDateTime = DateTime.utc(
      _selectedDate.year,
      _selectedDate.month,
      _selectedDate.day,
      adjustedHour,
      minute,
    );
    ref.read(bookingStateProvider.notifier).setScheduledAt(scheduledDateTime);
  }

  void _refreshSlots() {
    ref
        .read(availableSlotsProvider.notifier)
        .fetchAvailableSlots(
          vendorServiceId: widget.service.id,
          date: _selectedDate,
        );
  }

  Widget _buildChooseDateField(BuildContext context) {
    final theme = Theme.of(context);
    final t = Translations.of(context).booking.booking_screen.scheduling;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.date,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const Gap(AppSpacing.md),
        GestureDetector(
          onTap: () => _pickDate(context),
          child: Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 18),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDate(_selectedDate),
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Icon(
                  Icons.calendar_today_outlined,
                  color: theme.colorScheme.onSurface,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickDate(BuildContext context) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: theme.copyWith(
            colorScheme: colorScheme.copyWith(primary: const Color(0xFFE28C37)),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDate = DateTime.utc(picked.year, picked.month, picked.day);
        _selectedSlotIndex = -1; // Reset slot selection when date changes
      });
      _updateScheduledAt();

      // Fetch available slots for the new date
      ref
          .read(availableSlotsProvider.notifier)
          .fetchAvailableSlots(
            vendorServiceId: widget.service.id,
            date: _selectedDate,
          );
    }
  }

  String _formatDate(DateTime date) {
    final t = Translations.of(context).booking.booking_screen.scheduling;
    List<String> monthNames = [
      t.jan,
      t.feb,
      t.mar,
      t.apr,
      t.may,
      t.jun,
      t.jul,
      t.aug,
      t.sep,
      t.oct,
      t.nov,
      t.dec,
    ];
    final day = date.day.toString().padLeft(2, '0');
    final month = monthNames[date.month - 1];
    return '$day-$month-${date.year}';
  }

  int _parseTimeToMinutes(String timeSlot) {
    final parts = timeSlot.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1].split(' ')[0]);
    return hour * 60 + minute;
  }

  String _formatTimeTo12Hour(String timeSlot, {bool isUtc = true}) {
    DateTime dateTime;
    if (isUtc) {
      final parts = timeSlot.split(':');
      final hour = int.parse(parts[0]);
      final minute = int.parse(parts[1].split(' ')[0]);
      dateTime = DateTime.utc(
        _selectedDate.year,
        _selectedDate.month,
        _selectedDate.day,
        hour,
        minute,
      ).toLocal();
    } else {
      final parts = timeSlot.split(':');
      var hour = int.parse(parts[0]);
      final minute = int.parse(parts[1].split(' ')[0]);
      final period = hour >= 12 ? 'PM' : 'AM';
      if (hour == 0) hour = 12;
      else if (hour > 12) hour = hour - 12;
      final minuteStr = minute.toString().padLeft(2, '0');
      final hourStr = hour.toString().padLeft(2, '0');
      return '$hourStr:$minuteStr $period';
    }

    final hour = dateTime.hour;
    final minute = dateTime.minute;
    final period = hour >= 12 ? 'PM' : 'AM';
    var displayHour = hour % 12;
    if (displayHour == 0) displayHour = 12;
    final minuteStr = minute.toString().padLeft(2, '0');
    final hourStr = displayHour.toString().padLeft(2, '0');
    return '$hourStr:$minuteStr $period';
  }

  List<String> _getFilteredSlots(List<String> slots) {
    final now = DateTime.now().toUtc();
    final isToday =
        _selectedDate.year == now.year &&
        _selectedDate.month == now.month &&
        _selectedDate.day == now.day;

    if (!isToday) return slots;

    final currentMinutes = now.hour * 60 + now.minute;
    return slots.where((slot) {
      final slotMinutes = _parseTimeToMinutes(slot);
      return slotMinutes > currentMinutes;
    }).toList();
  }

  Widget _buildAvailableTimeChips() {
    final bookingState = ref.watch(bookingStateProvider);
    final slotsState = ref.watch(availableSlotsProvider);
    final theme = Theme.of(context);
    final t = Translations.of(context).booking.booking_screen.scheduling;

    // Get dynamic slots from backend and filter past times if today
    final availableSlots = _getFilteredSlots(slotsState.availableSlots);
    final isLoading = slotsState.isLoading;
    final error = slotsState.error;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              t.time,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
            if (_selectedSlotIndex != -1 && !isLoading)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSlotIndex = -1;
                    _slotError = null;
                  });
                  ref.read(bookingStateProvider.notifier).clearScheduledAt();
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    t.clear,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFFFE8C00),
                    ),
                  ),
                ),
              ),
          ],
        ),
        const Gap(AppSpacing.md),

        // Loading state
        if (isLoading)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: ShimmerSkeletons.chipRowSkeleton(
              count: 3,
              chipWidth: 80,
              chipHeight: 36,
              spacing: 8,
            ),
          )
        // Error state
        else if (error != null)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 20),
                const Gap(AppSpacing.sm),
                Expanded(
                  child: Text(
                    error,
                    style: GoogleFonts.poppins(fontSize: 12, color: Colors.red),
                  ),
                ),
              ],
            ),
          )
        // No slots available
        else if (availableSlots.isEmpty)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                      size: 20,
                    ),
                    const Gap(AppSpacing.sm),
                    Expanded(
                      child: Text(
                        t.null_time,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: theme.colorScheme.onSurface.withOpacity(0.7),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_nextAvailableDate != null && !_isSameDay(_selectedDate, _nextAvailableDate!))
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${t.next_available}: ${_formatDate(_nextAvailableDate!)}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const Gap(AppSpacing.sm),
                        GestureDetector(
                          onTap: _selectNextAvailableDay,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFE8C00),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              t.select_next_available,
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          )
        // Show available slots
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2.5,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
            ),
            itemCount: availableSlots.length,
            itemBuilder: (context, index) {
              final timeSlot = availableSlots[index];
              final bool isSelected = index == _selectedSlotIndex;
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedSlotIndex = index;
                    _slotError = null;
                  });
                  _updateScheduledAtFromDynamicSlot(timeSlot);
                },
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: isSelected
                        ? const LinearGradient(
                            colors: [Color(0xFFE28C37), Color(0xFF854609)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          )
                        : null,
                    color: isSelected
                        ? null
                        : theme.colorScheme.onSurface.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : theme.colorScheme.onSurface.withOpacity(0.2),
                    ),
                  ),
                  child: Text(
                    _formatTimeTo12Hour(timeSlot),
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              );
            },
          ),

        if (bookingState.scheduledAt != null)
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              children: [
                const Icon(Icons.event, color: Color(0xFFFE8C00), size: 18),
                const Gap(AppSpacing.sm),
                Text(
                  DateFormat(
                    'MMM dd, yyyy - hh:mm a',
                  ).format(bookingState.scheduledAt!.toLocal()),
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildVendorAttributesSection() {
    final attributes = widget.service.categoryServiceAttributes;
    if (attributes.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final t = Translations.of(context).booking.booking_screen;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: Color(0xFFFE8C00),
                size: 20,
              ),
              const Gap(AppSpacing.sm),
              Text(
                t.service_details,
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
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: attributes.entries.map((entry) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          _formatAttributeKey(entry.key),
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.7,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          _formatAttributeValue(entry.value),
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: theme.colorScheme.onSurface,
                            fontWeight: FontWeight.w500,
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

  Widget _buildCustomerFieldsSection() {
    final fields = widget.service.requiredCustomerFields;
    if (fields.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.edit_note,
                color: Color(0xFFFE8C00),
                size: 20,
              ),
              const Gap(AppSpacing.sm),
              Text(
                'Your Details',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.md),
          DynamicFormBuilder(
            key: _dynamicFormKey,
            fields: fields,
            onChanged: (values) {
              ref
                  .read(bookingStateProvider.notifier)
                  .setOrderCustomerAttributes(values);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary() {
    final theme = Theme.of(context);
    final t = Translations.of(context).booking.booking_screen.order;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
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
            const Gap(AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  t.base_amount,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                Text(
                  'KD ${_formatPrice(widget.service.basePrice)}',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            const Gap(AppSpacing.sm),
            Text(
              t.description,
              style: GoogleFonts.poppins(
                fontSize: 11,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.54),
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorCard(String errorMessage) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.red.withOpacity(0.3)),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 20),
            const Gap(AppSpacing.sm),
            Expanded(
              child: Text(
                errorMessage,
                style: GoogleFonts.poppins(fontSize: 12, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBar(BookingState bookingState, bool isLoading) {
    final t = Translations.of(context).booking.booking_screen.button;

    final hasLocationError = _locationError != null ||
        (requiresGps && bookingState.locationLat == null);
    final hasRouteError =
        _pickupError != null ||
        _dropOffError != null ||
        (requiresRoute &&
            (bookingState.pickupLat == null || bookingState.dropOffLat == null));

    String? errorMessage;
    if (_locationError != null) {
      errorMessage = _locationError;
    } else if (_pickupError != null) {
      errorMessage = _pickupError;
    } else if (_dropOffError != null) {
      errorMessage = _dropOffError;
    } else if (hasLocationError) {
      errorMessage = t.error_location;
    } else if (requiresRoute && bookingState.pickupLat == null) {
      errorMessage = t.error_pickup;
    } else if (requiresRoute && bookingState.dropOffLat == null) {
      errorMessage = t.error_drop_off;
    } else if (_slotError != null) {
      errorMessage = _slotError;
    }

    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: theme.colorScheme.surface),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Text(
                  errorMessage,
                  style: GoogleFonts.poppins(fontSize: 12, color: Colors.red),
                ),
              ),
            SizedBox(
              width: double.infinity,
              height: 54,
              child: isLoading
                  ? ShimmerSkeletons.buttonSkeleton(
                      height: 54,
                      borderRadius: 12,
                    )
                  : ElevatedButton(
                      onPressed: (hasLocationError || hasRouteError || _slotError != null)
                          ? () => _submitOrder()
                          : () => _submitOrder(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFE8C00),
                        disabledBackgroundColor:
                            theme.colorScheme.primaryContainer,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        t.title,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  void _openMapPicker() async {
    final t = Translations.of(context).booking.booking_screen.location;
    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerWidget(
          initialLat: ref.read(bookingStateProvider).locationLat,
          initialLng: ref.read(bookingStateProvider).locationLng,
          initialAddress: ref.read(bookingStateProvider).locationAddress,
          onLocationSelected: (lat, lng, address) {
            ref
                .read(bookingStateProvider.notifier)
                .setLocation(lat, lng, address);
            _addressController.text = address ?? '';
            if (mounted) setState(() => _locationError = null);
          },
        ),
      ),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.success_location)));
    }
  }

  void _openRouteMapPicker({required bool isPickup}) async {
    final t = Translations.of(context).booking.booking_screen.location;
    final bookingState = ref.read(bookingStateProvider);
    final initialLat = isPickup
        ? bookingState.pickupLat
        : bookingState.dropOffLat;
    final initialLng = isPickup
        ? bookingState.pickupLng
        : bookingState.dropOffLng;
    final initialAddress = isPickup
        ? bookingState.pickupAddress
        : bookingState.dropOffAddress;
    final title = isPickup ? t.pickup : t.drop_off;

    final result = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => LocationPickerWidget(
          initialLat: initialLat,
          initialLng: initialLng,
          initialAddress: initialAddress,
          onLocationSelected: (lat, lng, address) {
            if (isPickup) {
              ref
                  .read(bookingStateProvider.notifier)
                  .setPickupLocation(lat, lng, address);
              _pickupAddressController.text = address ?? '';
              if (mounted) setState(() => _pickupError = null);
            } else {
              ref
                  .read(bookingStateProvider.notifier)
                  .setDropoffLocation(lat, lng, address);
              _dropOffAddressController.text = address ?? '';
              if (mounted) setState(() => _dropOffError = null);
            }
          },
        ),
      ),
    );

    if (result == true && mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('$title ${t.success}')));
    }
  }

  Future<void> _submitOrder() async {
    final bookingState = ref.read(bookingStateProvider);
    final t = Translations.of(context).booking.booking_screen;

    setState(() {
      _locationError = null;
      _pickupError = null;
      _dropOffError = null;
      _slotError = null;
    });

    if (requiresGps && bookingState.locationLat == null) {
      setState(() => _locationError = t.location.null_location);
      return;
    }

    if (requiresRoute) {
      if (bookingState.pickupLat == null) {
        setState(() => _pickupError = t.location.null_pickup);
        return;
      }
      if (bookingState.dropOffLat == null) {
        setState(() => _dropOffError = t.location.null_drop_off);
        return;
      }
    }

    if (allowsScheduling) {
      final slotsState = ref.read(availableSlotsProvider);

      if (slotsState.availableSlots.isEmpty && !slotsState.isLoading) {
        setState(() => _slotError = t.scheduling.error_time);
        return;
      }

      if (_selectedSlotIndex == -1) {
        setState(() => _slotError = t.scheduling.select_time);
        return;
      }
    }

    if (_dynamicFormKey.currentState != null) {
      if (!_dynamicFormKey.currentState!.validate()) {
        return;
      }
    }

    final files = _dynamicFormKey.currentState?.files ?? {};

    final order = await ref
        .read(bookingSubmissionProvider.notifier)
        .submitOrder(bookingState, files);

    if (order != null && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => OrderConfirmationScreen(order: order),
        ),
      );
    } else if (mounted && ref.read(bookingSubmissionProvider).hasError) {
      final errorMsg = ErrorDisplay.formatErrorMessage(
        ref.read(bookingSubmissionProvider).error!,
      );
      final isSlotError = errorMsg.contains('Slot not available') ||
          errorMsg.contains('Slot already booked') ||
          errorMsg.contains('slot');
      if (isSlotError && allowsScheduling) {
        setState(() {
          _selectedSlotIndex = -1;
          _slotError = errorMsg;
        });
        _refreshSlots();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMsg),
          backgroundColor: Colors.red.shade800,
          duration: const Duration(seconds: 5),
        ),
      );
    }
  }

  String _formatAttributeKey(String key) {
    return key
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (word) => word.isEmpty
              ? ''
              : '${word[0].toUpperCase()}${word.substring(1)}',
        )
        .join(' ');
  }

  String _formatAttributeValue(dynamic value) {
    if (value == null) return 'N/A';
    final stringValue = value.toString();
    return stringValue
        .replaceAll('_', ' ')
        .split(' ')
        .map(
          (word) => word.isEmpty
              ? ''
              : '${word[0].toUpperCase()}${word.substring(1)}',
        )
        .join(' ');
  }

  String _formatPrice(dynamic value) {
    if (value == null) return '0';
    final numValue = value is num ? value : num.tryParse(value.toString());
    if (numValue == null) return '0';
    return numValue.toInt().toString();
  }
}
