import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class EndTab extends StatefulWidget {
  final void Function(String description) onDescriptionChanged;
  final void Function(String feature, bool isSelected) onFeatureToggled;
  final void Function(List<String> imageUrls) onImagesUploaded;
  final void Function(List<String> damageImageUrls) onDamageImagesUploaded;
  final VoidCallback onSubmit;
  final bool? isSellCar;

  const EndTab({
    super.key,
    required this.onDescriptionChanged,
    required this.onFeatureToggled,
    required this.onImagesUploaded,
    required this.onDamageImagesUploaded,
    required this.onSubmit,
    this.isSellCar = true,
  });

  @override
  State<EndTab> createState() => _EndTabState();
}

class _EndTabState extends State<EndTab> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDescriptionSection(),
          Gap(AppSpacing.xl),
          if (widget.isSellCar!) ...[
            GradientButton(
              text: Translations.of(
                context,
              ).sell_your_car.end_tab.proceed_payment,
              onTap: widget.onSubmit,
            ),
            Gap(AppSpacing.lg),
          ],
        ],
      ),
    );
  }

  Widget _buildDescriptionSection() {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Translations.of(context).sell_your_car.description.title,
          style: TextStyle(
            color: theme.colorScheme.onSurface,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Gap(AppSpacing.md),
        Container(
          height: 120,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            controller: _descriptionController,
            maxLines: null,
            expands: true,
            style: TextStyle(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              fontSize: 14,
            ),
            decoration: InputDecoration(
              hintText: Translations.of(context).sell_your_car.description.hint,
              hintStyle: TextStyle(
                color: theme.colorScheme.onSurface,
                fontSize: 16,
                fontFamily: 'Poppins',
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(14),
            ),
            onChanged: (_) =>
                widget.onDescriptionChanged(_descriptionController.text),
          ),
        ),
      ],
    );
  }
}
