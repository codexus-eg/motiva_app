import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/vendor/domain/entities/schedule_exception.dart';
import 'package:app/features/vendor/presentation/providers/vendor_provider.dart';
import 'package:app/core/theme/spacing.dart';

class VendorScheduleExceptionsScreen extends ConsumerStatefulWidget {
  const VendorScheduleExceptionsScreen({super.key});

  @override
  ConsumerState<VendorScheduleExceptionsScreen> createState() =>
      _VendorScheduleExceptionsScreenState();
}

class _VendorScheduleExceptionsScreenState
    extends ConsumerState<VendorScheduleExceptionsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    final scheduleExceptionsAsync = ref.watch(scheduleExceptionsProvider);

    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(AppSpacing.lg),
              _buildHeader(),
              const Gap(AppSpacing.xl),
              Expanded(
                child: scheduleExceptionsAsync.when(
                  data: (exceptions) => _buildExceptionsList(exceptions),
                  loading: () => const Center(
                    child: CircularProgressIndicator(color: AppColors.primary),
                  ),
                  error: (error, stackTrace) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: AppColors.red,
                          size: 48,
                        ),
                        const Gap(AppSpacing.md),
                        Text(
                          t.vendor_dashboard.schedule_exceptions.load_failed,
                          style: GoogleFonts.poppins(
                            color: theme.onSurface,
                            fontSize: 16,
                          ),
                        ),
                        const Gap(AppSpacing.sm),
                        ElevatedButton(
                          onPressed: () {
                            ref
                                .read(scheduleExceptionsProvider.notifier)
                                .refresh();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                          ),
                          child: Text(
                            t.vendor_dashboard.schedule_exceptions.retry,
                            style: GoogleFonts.poppins(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Gap(AppSpacing.md),
              _buildAddButton(),
              const Gap(AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
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
        Expanded(
          child: Text(
            t.vendor_dashboard.schedule_exceptions.screen_title,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: theme.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildExceptionsList(List<ScheduleException> exceptions) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    if (exceptions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.event_busy, color: AppColors.textSecondary, size: 64),
            const Gap(AppSpacing.md),
            Text(
              t.vendor_dashboard.schedule_exceptions.empty_title,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: theme.onSurface,
              ),
            ),
            const Gap(AppSpacing.sm),
            Text(
              t.vendor_dashboard.schedule_exceptions.empty_subtitle,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    final sortedExceptions = exceptions.toList()
      ..sort((a, b) => a.date.compareTo(b.date));

    return ListView.separated(
      itemCount: sortedExceptions.length,
      separatorBuilder: (_, __) => const Gap(AppSpacing.md),
      itemBuilder: (context, index) {
        final exception = sortedExceptions[index];
        return _buildExceptionCard(exception);
      },
    );
  }

  Widget _buildExceptionCard(ScheduleException exception) {
    final theme = Theme.of(context).colorScheme;
    final dateFormat = DateFormat('EEEE, MMMM d, yyyy');

    return Container(
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  dateFormat.format(exception.date),
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: theme.onSurface,
                  ),
                ),
              ),
              IconButton(
                tooltip: t.vendor_dashboard.schedule_exceptions.delete_tooltip,
                onPressed: () => _showDeleteConfirmation(exception),
                icon: const Icon(Icons.delete_outline, color: AppColors.red),
              ),
            ],
          ),
          const Gap(AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: exception.isClosed
                  ? AppColors.red.withValues(alpha: 0.2)
                  : AppColors.green.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              exception.isClosed
                  ? t.vendor_dashboard.schedule_exceptions.fully_closed
                  : t.vendor_dashboard.schedule_exceptions.modified_hours,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: exception.isClosed ? AppColors.red : AppColors.green,
              ),
            ),
          ),
          if (!exception.isClosed &&
              exception.startTime != null &&
              exception.endTime != null) ...[
            const Gap(AppSpacing.sm),
            Text(
              t.vendor_dashboard.schedule_exceptions.hours_label
                  .replaceAll('{start}', exception.startTime!)
                  .replaceAll('{end}', exception.endTime!),
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
          if (exception.reason != null && exception.reason!.isNotEmpty) ...[
            const Gap(AppSpacing.sm),
            Text(
              t.vendor_dashboard.schedule_exceptions.reason_label.replaceAll(
                '{reason}',
                exception.reason!,
              ),
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildAddButton() {
    final t = Translations.of(context);
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: GradientButton(
        text: t.vendor_dashboard.schedule_exceptions.add_button,
        onTap: _showAddExceptionDialog,
      ),
    );
  }

  void _showDeleteConfirmation(ScheduleException exception) {
    final theme = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (context) {
        final t = Translations.of(context);
        return AlertDialog(
          backgroundColor: theme.surface,
          title: Text(
            t.vendor_dashboard.schedule_exceptions.delete_dialog_title,
            style: GoogleFonts.poppins(
              color: theme.onSurface,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: Text(
            t.vendor_dashboard.schedule_exceptions.delete_dialog_message,
            style: GoogleFonts.poppins(color: theme.onSurface),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                t.vendor_dashboard.schedule_exceptions.cancel,
                style: GoogleFonts.poppins(color: AppColors.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                final success = await ref
                    .read(scheduleExceptionsProvider.notifier)
                    .deleteScheduleException(exception.id);

                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        success
                            ? t
                                  .vendor_dashboard
                                  .schedule_exceptions
                                  .delete_success
                            : t
                                  .vendor_dashboard
                                  .schedule_exceptions
                                  .delete_failed,
                      ),
                    ),
                  );
                }
              },
              child: Text(
                t.vendor_dashboard.schedule_exceptions.delete,
                style: GoogleFonts.poppins(color: AppColors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showAddExceptionDialog() {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    DateTime selectedDate = DateTime.now();
    bool isClosed = true;
    TimeOfDay? startTime;
    TimeOfDay? endTime;
    String reason = '';
    bool isSaving = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return AlertDialog(
            backgroundColor: theme.surface,
            title: Text(
              t.vendor_dashboard.schedule_exceptions.add_dialog_title,
              style: GoogleFonts.poppins(
                color: theme.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        builder: (context, child) {
                          return Theme(data: Theme.of(context), child: child!);
                        },
                      );
                      if (picked != null) {
                        setDialogState(() {
                          selectedDate = picked;
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: theme.primaryContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.vendor_dashboard.schedule_exceptions.date_label,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            DateFormat('MMMM d, yyyy').format(selectedDate),
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: theme.onSurface,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Gap(AppSpacing.md),
                  SwitchListTile(
                    title: Text(
                      t
                          .vendor_dashboard
                          .schedule_exceptions
                          .fully_closed_switch,
                      style: GoogleFonts.poppins(color: theme.onSurface),
                    ),
                    value: isClosed,
                    activeThumbColor: AppColors.primary,
                    onChanged: (value) {
                      setDialogState(() {
                        isClosed = value;
                      });
                    },
                  ),
                  if (!isClosed) ...[
                    const Gap(AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime:
                                    startTime ??
                                    const TimeOfDay(hour: 9, minute: 0),
                              );
                              if (picked != null) {
                                setDialogState(() {
                                  startTime = picked;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.primaryContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    t
                                        .vendor_dashboard
                                        .schedule_exceptions
                                        .start_time,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    startTime?.format(context) ??
                                        t
                                            .vendor_dashboard
                                            .schedule_exceptions
                                            .select_time,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: theme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const Gap(AppSpacing.md),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              final picked = await showTimePicker(
                                context: context,
                                initialTime:
                                    endTime ??
                                    const TimeOfDay(hour: 17, minute: 0),
                              );
                              if (picked != null) {
                                setDialogState(() {
                                  endTime = picked;
                                });
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: theme.primaryContainer,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    t
                                        .vendor_dashboard
                                        .schedule_exceptions
                                        .end_time,
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    endTime?.format(context) ??
                                        t
                                            .vendor_dashboard
                                            .schedule_exceptions
                                            .select_time,
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: theme.onSurface,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const Gap(AppSpacing.md),
                  TextField(
                    style: GoogleFonts.poppins(color: theme.onSurface),
                    decoration: InputDecoration(
                      labelText: t
                          .vendor_dashboard
                          .schedule_exceptions
                          .reason_optional,
                      labelStyle: GoogleFonts.poppins(
                        color: AppColors.textSecondary,
                      ),
                      filled: true,
                      fillColor: theme.primaryContainer,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (value) {
                      reason = value;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isSaving ? null : () => Navigator.pop(context),
                child: Text(
                  t.vendor_dashboard.schedule_exceptions.cancel,
                  style: GoogleFonts.poppins(color: AppColors.textSecondary),
                ),
              ),
              ElevatedButton(
                onPressed: isSaving
                    ? null
                    : () async {
                        if (!isClosed &&
                            (startTime == null || endTime == null)) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                t
                                    .vendor_dashboard
                                    .schedule_exceptions
                                    .select_times_error,
                              ),
                            ),
                          );
                          return;
                        }

                        setDialogState(() {
                          isSaving = true;
                        });

                        try {
                          final params = CreateScheduleExceptionParams(
                            date: selectedDate,
                            isClosed: isClosed,
                            startTime: !isClosed && startTime != null
                                ? _formatTimeOfDay(startTime!)
                                : null,
                            endTime: !isClosed && endTime != null
                                ? _formatTimeOfDay(endTime!)
                                : null,
                            reason: reason.isNotEmpty ? reason : null,
                          );

                          final success = await ref
                              .read(scheduleExceptionsProvider.notifier)
                              .createScheduleException(params);

                          if (context.mounted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  success
                                      ? t
                                            .vendor_dashboard
                                            .schedule_exceptions
                                            .add_success
                                      : t
                                            .vendor_dashboard
                                            .schedule_exceptions
                                            .add_failed,
                                ),
                              ),
                            );
                          }
                        } catch (e, stackTrace) {
                          AppLogger.error(
                            'Error creating schedule exception',
                            error: e,
                            stackTrace: stackTrace,
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  t.vendor_dashboard.schedule_exceptions.error
                                      .replaceAll('{error}', e.toString()),
                                ),
                              ),
                            );
                          }
                        } finally {
                          if (context.mounted) {
                            setDialogState(() {
                              isSaving = false;
                            });
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                ),
                child: isSaving
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        t
                            .vendor_dashboard
                            .schedule_exceptions
                            .add_button_dialog,
                        style: GoogleFonts.poppins(color: Colors.white),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  String _formatTimeOfDay(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }
}
