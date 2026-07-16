import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class FtInspectionReportDCTab extends StatefulWidget {
  final VoidCallback onContinue;
  final void Function(String?) onInspectionReportUploaded;

  const FtInspectionReportDCTab({
    super.key,
    required this.onContinue,
    required this.onInspectionReportUploaded,
  });

  @override
  State<FtInspectionReportDCTab> createState() =>
      _FtInspectionReportDCTabState();
}

class _FtInspectionReportDCTabState extends State<FtInspectionReportDCTab> {
  bool checked = true;
  String? _uploadedUrl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              Translations.of(context).sell_your_car.inspection_report.title,
              style: TextStyle(
                color: theme.onSurface,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
            ),
            Gap(AppSpacing.lg),
            //browse your file
            GestureDetector(
              onTap: () {
                // Simple text input for inspection report URL
                // In production, this would be a file picker
                _showUrlInputDialog();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: BoxDecoration(
                  color: theme.primaryContainer,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.orange,
                    style: BorderStyle.solid,
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.cloud_upload_outlined,
                      color: theme.onSurface,
                      size: 36,
                    ),
                    Gap(AppSpacing.md),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: Translations.of(
                              context,
                            ).sell_your_car.inspection_report.browse,
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextSpan(
                            text: Translations.of(
                              context,
                            ).sell_your_car.inspection_report.your_file,
                            style: TextStyle(
                              color: theme.onSurface.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Gap(AppSpacing.sm),
                    Text(
                      Translations.of(
                        context,
                      ).sell_your_car.inspection_report.max_size,
                      style: TextStyle(
                        color: theme.onSurface.withValues(alpha: 0.38),
                      ),
                    ),
                    if (_uploadedUrl != null) ...[
                      Gap(AppSpacing.sm),
                      Text(
                        Translations.of(
                          context,
                        ).sell_your_car.inspection_report.uploaded_success,
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Gap(AppSpacing.lg),
            GestureDetector(
              onTap: () {
                widget.onInspectionReportUploaded(null);
                widget.onContinue();
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: theme.primaryContainer,
                  borderRadius: BorderRadius.circular(14),
                ),
                alignment: Alignment.center,
                child: Text(
                  Translations.of(
                    context,
                  ).sell_your_car.inspection_report.no_report,
                  style: TextStyle(color: theme.onSurface, fontSize: 16),
                ),
              ),
            ),
            Gap(AppSpacing.xl),
            Row(
              children: [
                Checkbox(
                  value: checked,
                  activeColor: theme.onSurface,
                  onChanged: (v) {
                    setState(() => checked = v!);
                  },
                ),
                Expanded(
                  child: Text(
                    Translations.of(
                      context,
                    ).sell_your_car.inspection_report.inspect_question,
                    style: TextStyle(
                      color: theme.onSurface,
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
                color: theme.primaryContainer,
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
                              color: theme.onPrimaryContainer,
                              fontSize: 10,
                            ),
                          ),
                          Gap(AppSpacing.md),
                          Text(
                            Translations.of(
                              context,
                            ).sell_your_car.inspection_report.inspect_price,
                            style: TextStyle(
                              color: Colors.orange,
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
                    ),
                  ),
                ],
              ),
            ),
            Gap(AppSpacing.xl),
            GradientButton(
              text: Translations.of(
                context,
              ).sell_your_car.inspection_report.kContinue,
              onTap: () {
                widget.onInspectionReportUploaded(_uploadedUrl);
                widget.onContinue();
              },
            ),
            Gap(AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  void _showUrlInputDialog() {
    final controller = TextEditingController();
    final theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.colorScheme.primaryContainer,
        title: Text(
          Translations.of(context).sell_your_car.inspection_report.dialog_title,
          style: TextStyle(color: theme.colorScheme.onSurface),
        ),
        content: TextField(
          controller: controller,
          style: TextStyle(color: theme.colorScheme.onSurface),
          decoration: InputDecoration(
            hintText: 'https://...',
            hintStyle: TextStyle(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              Translations.of(context).sell_your_car.inspection_report.cancel,
              style: TextStyle(color: theme.colorScheme.onSurface),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                _uploadedUrl = controller.text;
              });
              widget.onInspectionReportUploaded(controller.text);
              Navigator.pop(context);
            },
            child: Text(
              Translations.of(context).sell_your_car.inspection_report.upload,
              style: TextStyle(color: Color(0xFFDC8735)),
            ),
          ),
        ],
      ),
    );
  }
}
