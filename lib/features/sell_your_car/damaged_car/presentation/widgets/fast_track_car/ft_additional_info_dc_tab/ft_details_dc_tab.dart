// import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class FtDetailsDCTab extends StatefulWidget {
  final void Function(String description) onDescriptionChanged;

  const FtDetailsDCTab({
    super.key,
    required this.onDescriptionChanged,
  });

  @override
  State<FtDetailsDCTab> createState() => _FtDetailsDCTabState();
}

class _FtDetailsDCTabState extends State<FtDetailsDCTab> {
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
          'Description',
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
              hintText: 'Write any extra details about your\n Car.',
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
