import 'package:app/features/service_order_documents/presentation/providers/service_order_documents_provider.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/core/theme/spacing.dart';

class CompleteOrderDialog extends ConsumerStatefulWidget {
  final String orderId;
  final String baseAmount;
  final bool requiresVendorDocuments;
  final String? serviceCategoryId;
  final Future<void> Function(double finalPrice, List<XFile> documents) onComplete;

  const CompleteOrderDialog({
    super.key,
    required this.orderId,
    required this.baseAmount,
    this.requiresVendorDocuments = false,
    this.serviceCategoryId,
    required this.onComplete,
  });

  @override
  ConsumerState<CompleteOrderDialog> createState() =>
      _CompleteOrderDialogState();
}

class _CompleteOrderDialogState extends ConsumerState<CompleteOrderDialog> {
  final _priceController = TextEditingController();
  bool _isLoading = false;
  final List<XFile> _pickedFiles = [];

  late final double _minPrice;
  late final double _maxPrice;

  @override
  void initState() {
    super.initState();
    final base = double.tryParse(widget.baseAmount) ?? 0.0;
    _minPrice = base * 0.5;
    _maxPrice = base * 2.0;
    _priceController.text = base.toStringAsFixed(2);
  }

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _pickDocument() async {
    final xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (xFile == null) return;
    setState(() => _pickedFiles.add(xFile));
  }

  void _removeFile(int index) {
    setState(() => _pickedFiles.removeAt(index));
  }

  Future<void> _handleComplete() async {
    // Check documents requirement
    if (widget.requiresVendorDocuments) {
      final docsAsync = ref.read(serviceOrderDocumentsProvider(widget.orderId));
      final existingDocs = docsAsync.value ?? [];
      if (existingDocs.isEmpty && _pickedFiles.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please upload at least one completion document'),
          ),
        );
        return;
      }
    }

    // Validate price
    final price = double.tryParse(_priceController.text);
    if (price == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid price')),
      );
      return;
    }

    if (price < _minPrice || price > _maxPrice) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Price must be between ${_minPrice.toStringAsFixed(2)} and ${_maxPrice.toStringAsFixed(2)} KWD',
          ),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await widget.onComplete(price, _pickedFiles);
      if (mounted) {
        Navigator.of(context).pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to complete order: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    return AlertDialog(
      backgroundColor: theme.primaryContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(
        'Complete Order',
        style: TextStyle(color: theme.onSurface, fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.requiresVendorDocuments) ...[
              _buildDocumentsSection(theme),
              const Gap(AppSpacing.md),
              const Divider(height: 1),
              const Gap(AppSpacing.md),
            ],
            Text(
              'Enter the final price for this order.',
              style: TextStyle(color: AppColors.textSecondary),
            ),
            const Gap(AppSpacing.sm),
            Text(
              'Allowed range: ${_minPrice.toStringAsFixed(2)} - ${_maxPrice.toStringAsFixed(2)} KWD',
              style: const TextStyle(color: AppColors.primary, fontSize: 12),
            ),
            const Gap(AppSpacing.md),
            TextField(
              controller: _priceController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: TextStyle(color: theme.onSurface),
              decoration: InputDecoration(
                hintText: 'Final Price (KWD)',
                hintStyle: const TextStyle(color: Color(0xFF757575)),
                filled: true,
                fillColor: theme.primaryContainer,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.only(left: 16, right: 8),
                  child: Text(
                    'KWD',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 0,
                  minHeight: 0,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(false),
          child: Text(
            'Cancel',
            style: TextStyle(color: theme.onSurface.withValues(alpha: 0.7)),
          ),
        ),
        ElevatedButton(
          onPressed: _isLoading ? null : _handleComplete,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: _isLoading
              ? ShimmerSkeletons.buttonSkeleton()
              : Text('Complete', style: TextStyle(color: theme.onSurface)),
        ),
      ],
    );
  }

  Widget _buildDocumentsSection(ColorScheme theme) {
    final docsAsync = ref.watch(serviceOrderDocumentsProvider(widget.orderId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Completion Documents',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: theme.onSurface,
          ),
        ),
        const Gap(AppSpacing.sm),
        // Existing uploaded documents
        docsAsync.when(
          loading: () => const Center(
            child: SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ),
          error: (_, _) => const SizedBox.shrink(),
          data: (docs) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (docs.isEmpty && _pickedFiles.isEmpty)
                Text(
                  'No documents uploaded yet',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ...docs.map((doc) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.description,
                          size: 16,
                          color: AppColors.primary,
                        ),
                        const Gap(AppSpacing.xs),
                        Expanded(
                          child: Text(
                            doc.originalFilename.isNotEmpty
                                ? doc.originalFilename
                                : doc.fileUrl.split('/').last,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: theme.onSurface,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
        // Picked (pending upload) files
        if (_pickedFiles.isNotEmpty) ...[
          const Gap(AppSpacing.xs),
          ..._pickedFiles.asMap().entries.map((entry) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    const Icon(
                      Icons.attach_file,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    const Gap(AppSpacing.xs),
                    Expanded(
                      child: Text(
                        entry.value.name,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: theme.onSurface,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _removeFile(entry.key),
                      child: const Icon(
                        Icons.close,
                        size: 16,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              )),
        ],
        const Gap(AppSpacing.sm),
        SizedBox(
          height: 36,
          child: ElevatedButton.icon(
            onPressed: _pickDocument,
            icon: const Icon(Icons.upload_file, size: 16),
            label: Text(
              'Add Document',
              style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}