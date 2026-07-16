import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/vendor/domain/entities/working_hours.dart';
import 'package:app/features/vendor/presentation/providers/vendor_provider.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/setting/Vendor_schedule_exceptions.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorWorkingHourScreen extends ConsumerStatefulWidget {
  const VendorWorkingHourScreen({super.key});

  @override
  ConsumerState<VendorWorkingHourScreen> createState() =>
      _VendorWorkingHourScreenState();
}

class _VendorWorkingHourScreenState
    extends ConsumerState<VendorWorkingHourScreen> {
  String startingHour = '09:00';
  String closingHour = '18:00';
  List<String> selectedOffDays = ['Saturday', 'Sunday'];
  bool _isSaving = false;

  final List<String> allDays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  void initState() {
    super.initState();
    _loadWorkingHours();
  }

  void _loadWorkingHours() {
    final profileAsync = ref.read(vendorProfileProvider);
    profileAsync.whenData((profile) {
      if (profile?.workingHours != null) {
        final workingHours = profile!.workingHours!;
        final firstDay =
            workingHours.monday ??
            workingHours.tuesday ??
            workingHours.wednesday ??
            workingHours.thursday ??
            workingHours.friday;

        if (firstDay != null) {
          setState(() {
            startingHour = firstDay.open;
            closingHour = firstDay.close;
          });
        }

        setState(() {
          selectedOffDays = workingHours.offDays;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(AppSpacing.xl),
              _headerSection(),
              const Gap(AppSpacing.xl),
              _buildWorkingHoursForm(),
              const Gap(AppSpacing.lg),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: GradientButton(
                  text: t.vendor_dashboard.working_hours.schedule_exceptions,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const VendorScheduleExceptionsScreen(),
                    ),
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //   },
                //   style: ElevatedButton.styleFrom(
                //     backgroundColor: AppColors.primary,
                //     foregroundColor: Colors.white,
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(12),
                //     ),
                //     disabledBackgroundColor: AppColors.primary.withValues(
                //       alpha: 0.5,
                //     ),
                //   ),
                //   child: Text(
                //     style: GoogleFonts.poppins(
                //       fontSize: 16,
                //       fontWeight: FontWeight.w600,
                //     ),
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _headerSection() {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.secondary,
            size: 24,
          ),
        ),
        const Gap(AppSpacing.md),
        Text(
          t.vendor_dashboard.working_hours.screen_title,
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: theme.onSurface,
            height: 1.34,
          ),
        ),
      ],
    );
  }

  Widget _buildWorkingHoursForm() {
    return Column(
      children: [
        _buildTextField(
          label: t.vendor_dashboard.working_hours.starting_hour,
          value: startingHour,
          onTap: _showStartingTimePicker,
        ),
        const Gap(AppSpacing.md),
        _buildTextField(
          label: t.vendor_dashboard.working_hours.closing_hour,
          value: closingHour,
          onTap: _showClosingTimePicker,
        ),
        const Gap(AppSpacing.md),
        _buildOffDaysField(),
        const Gap(AppSpacing.xl),
        _buildSaveButton(),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 85,
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                height: 2.0,
              ),
            ),
            const Gap(AppSpacing.xs),
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: theme.onSurface,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOffDaysField() {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return GestureDetector(
      onTap: _showOffDaysPicker,
      child: Container(
        width: double.infinity,
        height: 85,
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              t.vendor_dashboard.working_hours.off_days,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textSecondary,
                height: 2.0,
              ),
            ),
            const Gap(AppSpacing.xs),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedOffDays.join(', '),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: theme.onSurface,
                    height: 1.5,
                  ),
                ),
                Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: theme.onSurface,
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showStartingTimePicker() {
    final initialTime = _parseTimeString(startingHour);
    showTimePicker(context: context, initialTime: initialTime).then((time) {
      if (time != null) {
        final formattedTime = _formatTimeOfDay(time);
        setState(() {
          startingHour = formattedTime;
        });
      }
    });
  }

  void _showClosingTimePicker() {
    final initialTime = _parseTimeString(closingHour);
    showTimePicker(context: context, initialTime: initialTime).then((time) {
      if (time != null) {
        final formattedTime = _formatTimeOfDay(time);
        setState(() {
          closingHour = formattedTime;
        });
      }
    });
  }

  TimeOfDay _parseTimeString(String timeStr) {
    final parts = timeStr.split(':');
    if (parts.length == 2) {
      final hour = int.tryParse(parts[0]) ?? 9;
      final minute = int.tryParse(parts[1]) ?? 0;
      return TimeOfDay(hour: hour, minute: minute);
    }
    return const TimeOfDay(hour: 9, minute: 0);
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: GradientButton(
        text: _isSaving
            ? t.vendor_dashboard.working_hours.saving
            : t.vendor_dashboard.working_hours.save,
        onTap: _isSaving ? null : _saveWorkingHours,
      ),
    );
  }

  Future<void> _saveWorkingHours() async {
    setState(() {
      _isSaving = true;
    });

    try {
      final workingDays = allDays
          .where((day) => !selectedOffDays.contains(day))
          .toList();

      final workingHours = WorkingHours(
        monday: workingDays.contains('Monday')
            ? DaySchedule(open: startingHour, close: closingHour)
            : null,
        tuesday: workingDays.contains('Tuesday')
            ? DaySchedule(open: startingHour, close: closingHour)
            : null,
        wednesday: workingDays.contains('Wednesday')
            ? DaySchedule(open: startingHour, close: closingHour)
            : null,
        thursday: workingDays.contains('Thursday')
            ? DaySchedule(open: startingHour, close: closingHour)
            : null,
        friday: workingDays.contains('Friday')
            ? DaySchedule(open: startingHour, close: closingHour)
            : null,
        saturday: workingDays.contains('Saturday')
            ? DaySchedule(open: startingHour, close: closingHour)
            : null,
        sunday: workingDays.contains('Sunday')
            ? DaySchedule(open: startingHour, close: closingHour)
            : null,
      );

      final notifier = ref.read(vendorProfileProvider.notifier);
      final success = await notifier.updateWorkingHours(workingHours);

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.vendor_dashboard.working_hours.update_success),
          ),
        );
        Navigator.pop(context);
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.vendor_dashboard.working_hours.update_failed),
          ),
        );
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        'Error saving working hours',
        error: e,
        stackTrace: stackTrace,
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              t.vendor_dashboard.working_hours.error.replaceAll(
                '{error}',
                e.toString(),
              ),
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSaving = false;
        });
      }
    }
  }

  void _showOffDaysPicker() {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.surface,
        title: Text(
          t.vendor_dashboard.working_hours.select_off_days,
          style: GoogleFonts.poppins(
            color: theme.onSurface,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: SizedBox(
          width: 300,
          height: 300,
          child: ListView(
            children: allDays.map((day) {
              final isSelected = selectedOffDays.contains(day);
              return CheckboxListTile(
                title: Text(
                  day,
                  style: GoogleFonts.poppins(color: theme.onSurface),
                ),
                value: isSelected,
                activeColor: AppColors.primary,
                checkColor: theme.onSurface,
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedOffDays.add(day);
                    } else {
                      selectedOffDays.remove(day);
                    }
                  });
                  Navigator.pop(context);
                  _showOffDaysPicker();
                },
              );
            }).toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              t.vendor_dashboard.working_hours.done,
              style: GoogleFonts.poppins(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
