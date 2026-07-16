import 'dart:io';

import 'package:app/core/utils/app_logger.dart';
import 'package:app/core/utils/error_display.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/upload/presentation/providers/upload_provider.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class InspectionReportTab extends ConsumerStatefulWidget {
  final VoidCallback onContinue;
  final void Function(String? inspectionReport)? onInspectionReportUploaded;
  final void Function(bool wantsInspection) onWantsInspectionChanged;

  const InspectionReportTab({
    super.key,
    required this.onContinue,
    this.onInspectionReportUploaded,
    required this.onWantsInspectionChanged,
  });

  @override
  ConsumerState<InspectionReportTab> createState() =>
      _InspectionReportTabState();
}

class _InspectionReportTabState extends ConsumerState<InspectionReportTab> {
  bool checked = true;
  File? _selectedFile;
  String? _uploadedFileName;
  String? _uploadedUrl;
  bool _isUploading = false;
  String? _errorMessage;

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (file.size > 10 * 1024 * 1024) {
          setState(() {
            _errorMessage = Translations.of(
              context,
            ).sell_your_car.inspection_report.file_size_error;
          });
          return;
        }

        setState(() {
          _selectedFile = File(file.path!);
          _uploadedFileName = file.name;
          _errorMessage = null;
        });
      }
    } catch (e, stackTrace) {
      AppLogger.error('_pickFile failed', error: e, stackTrace: stackTrace);
      setState(() {
        _errorMessage = Translations.of(context)
            .sell_your_car
            .inspection_report
            .pick_error
            .replaceAll('{error}', e.toString());
      });
      if (mounted) {
        ErrorDisplay.showSnackBar(context, e, stackTrace: stackTrace);
      }
    }
  }

  Future<void> _uploadFile() async {
    if (_selectedFile == null) return;

    setState(() {
      _isUploading = true;
      _errorMessage = null;
    });

    try {
      final uploadNotifier = ref.read(uploadNotifierProvider.notifier);
      final bytes = await _selectedFile!.readAsBytes();

      final extension = _uploadedFileName!.split('.').last.toLowerCase();
      final mimeType = extension == 'pdf'
          ? 'application/pdf'
          : 'image/$extension';

      final url = await uploadNotifier.uploadImage(
        bytes,
        'inspection_${DateTime.now().millisecondsSinceEpoch}.$extension',
        mimeType,
        folder: 'documents',
      );

      if (url != null) {
        setState(() {
          _uploadedUrl = url;
          _isUploading = false;
        });
        widget.onInspectionReportUploaded?.call(url);
      } else {
        setState(() {
          _isUploading = false;
          _errorMessage = Translations.of(
            context,
          ).sell_your_car.inspection_report.upload_error;
        });
      }
    } catch (e, stackTrace) {
      AppLogger.error('_uploadFile failed', error: e, stackTrace: stackTrace);
      setState(() {
        _isUploading = false;
        _errorMessage = Translations.of(context)
            .sell_your_car
            .inspection_report
            .upload_error_generic
            .replaceAll('{error}', e.toString());
      });
      if (mounted) {
        ErrorDisplay.showSnackBar(context, e, stackTrace: stackTrace);
      }
    }
  }

  void _removeFile() {
    setState(() {
      _selectedFile = null;
      _uploadedFileName = null;
      _uploadedUrl = null;
    });
    widget.onInspectionReportUploaded?.call(null);
  }

  void _skipUpload() {
    widget.onInspectionReportUploaded?.call(null);
    widget.onContinue();
  }

  @override
  Widget build(BuildContext context) {
    final uploadState = ref.watch(uploadNotifierProvider);
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Translations.of(context).sell_your_car.inspection_report.title,
              style: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
            const Gap(AppSpacing.lg),

            if (_selectedFile == null) ...[
              GestureDetector(
                onTap: _pickFile,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 40),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xffF7B305),
                      style: BorderStyle.solid,
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.cloud_upload_outlined,
                        color: theme.colorScheme.onSurface,
                        size: 36,
                      ),
                      const Gap(AppSpacing.md),
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: Translations.of(
                                context,
                              ).sell_your_car.inspection_report.browse,
                              style: TextStyle(
                                color: Color(0xffF7B305),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            TextSpan(
                              text: Translations.of(
                                context,
                              ).sell_your_car.inspection_report.your_file,
                              style: TextStyle(
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(AppSpacing.sm),
                      Text(
                        Translations.of(
                          context,
                        ).sell_your_car.inspection_report.max_size,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),
                      const Gap(AppSpacing.xs),
                      Text(
                        Translations.of(
                          context,
                        ).sell_your_car.inspection_report.file_types,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.7,
                          ),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ] else ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xffF7B305)),
                ),
                child: Row(
                  children: [
                    Icon(
                      _uploadedUrl != null
                          ? Icons.check_circle
                          : Icons.description,
                      color: _uploadedUrl != null
                          ? Colors.green
                          : const Color(0xffF7B305),
                      size: 32,
                    ),
                    const Gap(AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _uploadedFileName ?? '',
                            style: TextStyle(
                              color: theme.colorScheme.onSurface,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          if (_uploadedUrl != null)
                            Text(
                              Translations.of(context)
                                  .sell_your_car
                                  .inspection_report
                                  .uploaded_success,
                              style: TextStyle(
                                color: Colors.green[400],
                                fontSize: 12,
                              ),
                            ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: _isUploading ? null : _removeFile,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Icon(
                          Icons.close,
                          color: theme.colorScheme.onSurface,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],

            if (_errorMessage != null) ...[
              const Gap(AppSpacing.sm),
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red[400], fontSize: 12),
              ),
            ],

            const Gap(AppSpacing.lg),

            if (!_isUploading && _selectedFile != null && _uploadedUrl == null)
              GradientButton(
                text: Translations.of(
                  context,
                ).sell_your_car.inspection_report.upload,
                onTap: _uploadFile,
              ),

            if (_uploadedUrl != null) ...[
              const Gap(AppSpacing.md),
              GradientButton(
                text: Translations.of(
                  context,
                ).sell_your_car.inspection_report.kContinue,
                onTap: widget.onContinue,
              ),
            ],

            if (_isUploading || uploadState.isLoading) ...[
              const Gap(AppSpacing.md),
              Center(
                child: Column(
                  children: [
                    ShimmerSkeletons.cardSkeleton(),
                    const Gap(AppSpacing.md),
                    Text(
                      Translations.of(
                        context,
                      ).sell_your_car.inspection_report.uploading,
                      style: TextStyle(color: theme.colorScheme.onSurface),
                    ),
                  ],
                ),
              ),
            ],

            if (_selectedFile == null && !_isUploading) ...[
              GestureDetector(
                onTap: _skipUpload,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    Translations.of(
                      context,
                    ).sell_your_car.inspection_report.no_report,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],

            const Gap(AppSpacing.xl),
            Row(
              children: [
                Checkbox(
                  value: checked,
                  activeColor: theme.colorScheme.onSurface,
                  onChanged: (v) {
                    setState(() => checked = v!);
                    widget.onWantsInspectionChanged(v!);
                  },
                ),
                Expanded(
                  child: Text(
                    Translations.of(
                      context,
                    ).sell_your_car.inspection_report.inspect_question,
                    style: TextStyle(
                      color: theme.colorScheme.onSurface,
                      fontSize: 16,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ],
            ),
            const Gap(AppSpacing.md),
            Container(
              decoration: BoxDecoration(
                color: theme.colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Translations.of(context)
                                .sell_your_car
                                .inspection_report
                                .inspect_description,
                            style: TextStyle(
                              color: theme.colorScheme.onPrimaryContainer,
                              fontSize: 10,
                            ),
                          ),
                          const Gap(AppSpacing.md),
                          Text(
                            Translations.of(
                              context,
                            ).sell_your_car.inspection_report.inspect_price,
                            style: TextStyle(
                              color: Color(0xffF7B305),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    child: Image.asset(
                      "assets/images/inspect_car.png",
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: 140,
                          height: 140,
                          color: Color(0xffF7B305).withAlpha(77),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.xl),
            if (_selectedFile == null && !_isUploading)
              GradientButton(
                text: Translations.of(
                  context,
                ).sell_your_car.inspection_report.kContinue,
                onTap: widget.onContinue,
              ),
            const Gap(AppSpacing.lg),
          ],
        ),
      ),
    );
  }
}
