import 'dart:typed_data';

import 'package:app/core/providers/upload_provider.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/vendor-products/domain/entities/vendor_product.dart';
import 'package:app/features/vendor-products/domain/repositories/vendor_product_repository.dart';
import 'package:app/features/vendor-products/presentation/providers/vendor_products_provider.dart';
import 'package:app/shared/ui/buttons/gradient_elevated_button.dart';
import 'package:app/shared/ui/images/platform_image.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/core/theme/spacing.dart';

class CreateProductScreen extends ConsumerStatefulWidget {
  final VendorProduct? existingProduct;

  const CreateProductScreen({super.key, this.existingProduct});

  @override
  ConsumerState<CreateProductScreen> createState() =>
      _CreateProductScreenState();
}

class _CreateProductScreenState extends ConsumerState<CreateProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _stockController = TextEditingController();
  final _partNumberController = TextEditingController();
  final _brandController = TextEditingController();
  final _warrantyMonthsController = TextEditingController();
  final _newEntryMake = TextEditingController();
  final _newEntryModel = TextEditingController();
  final _newEntryYearStart = TextEditingController();
  final _newEntryYearEnd = TextEditingController();

  String _productType = 'accessory';
  final List<String> _imageUrls = [];
  final List<XFile> _selectedImages = [];
  final List<CompatibilityEntry> _compatibilityEntries = [];
  bool _isUploadingImage = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.existingProduct != null) {
      _nameController.text = widget.existingProduct!.name;
      _descriptionController.text = widget.existingProduct!.description ?? '';
      final priceValue = double.tryParse(widget.existingProduct!.price);
      if (priceValue != null) {
        final intValue = priceValue.toInt();
        _priceController.text = priceValue == intValue
            ? intValue.toString()
            : priceValue.toString();
      } else {
        _priceController.text = widget.existingProduct!.price;
      }
      _stockController.text = widget.existingProduct!.stockQuantity
          .toString();
      _productType = widget.existingProduct!.productType;
      _imageUrls.addAll(widget.existingProduct!.images);
      _partNumberController.text = widget.existingProduct!.partNumber ?? '';
      _brandController.text = widget.existingProduct!.brand ?? '';
      _warrantyMonthsController.text =
          widget.existingProduct!.warrantyMonths != null
              ? widget.existingProduct!.warrantyMonths!.toString()
              : '';
      _compatibilityEntries.clear();
      _compatibilityEntries.addAll(
        widget.existingProduct!.compatibility ?? const <CompatibilityEntry>[],
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _partNumberController.dispose();
    _brandController.dispose();
    _warrantyMonthsController.dispose();
    _newEntryMake.dispose();
    _newEntryModel.dispose();
    _newEntryYearStart.dispose();
    _newEntryYearEnd.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadImage() async {
    final uploadService = ref.read(uploadServiceProvider);

    final file = await uploadService.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    setState(() {
      _isUploadingImage = true;
      _selectedImages.add(file);
    });

    final result = await uploadService.uploadFile(file, folder: 'listings');

    setState(() {
      _isUploadingImage = false;
      _selectedImages.remove(file);
      if (result != null) {
        _imageUrls.add(result.url);
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    bool success;

    if (widget.existingProduct != null) {
      final params = UpdateProductParams(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        price: double.tryParse(_priceController.text.trim()),
        stockQuantity: double.tryParse(_stockController.text.trim()),
        productType: _productType,
        partNumber: _productType == 'spare_part' &&
                _partNumberController.text.trim().isNotEmpty
            ? _partNumberController.text.trim()
            : null,
        brand: _productType == 'spare_part' &&
                _brandController.text.trim().isNotEmpty
            ? _brandController.text.trim()
            : null,
        warrantyMonths: _productType == 'spare_part' &&
                _warrantyMonthsController.text.trim().isNotEmpty
            ? int.tryParse(_warrantyMonthsController.text.trim())
            : null,
        compatibility: _productType == 'spare_part'
            ? List<CompatibilityEntry>.from(_compatibilityEntries)
            : null,
        images: _imageUrls.isNotEmpty ? _imageUrls : null,
      );
      success = await ref
          .read(vendorProductsNotifierProvider.notifier)
          .updateProduct(widget.existingProduct!.id, params);
    } else {
      final params = CreateProductParams(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isNotEmpty
            ? _descriptionController.text.trim()
            : null,
        price: double.parse(_priceController.text.trim()),
        stockQuantity: double.parse(_stockController.text.trim()),
        productType: _productType,
        partNumber: _productType == 'spare_part' &&
                _partNumberController.text.trim().isNotEmpty
            ? _partNumberController.text.trim()
            : null,
        brand: _productType == 'spare_part' &&
                _brandController.text.trim().isNotEmpty
            ? _brandController.text.trim()
            : null,
        warrantyMonths: _productType == 'spare_part' &&
                _warrantyMonthsController.text.trim().isNotEmpty
            ? int.tryParse(_warrantyMonthsController.text.trim())
            : null,
        compatibility: _productType == 'spare_part' &&
                _compatibilityEntries.isNotEmpty
            ? List<CompatibilityEntry>.from(_compatibilityEntries)
            : null,
        images: _imageUrls,
      );
      success = await ref
          .read(vendorProductsNotifierProvider.notifier)
          .createProduct(params);
    }

    setState(() => _isLoading = false);

    if (success && mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.existingProduct != null
                ? Translations.of(
                    context,
                  ).vendor_products.create_product.snackbar_updated
                : Translations.of(
                    context,
                  ).vendor_products.create_product.snackbar_created,
          ),
          backgroundColor: AppColors.green,
        ),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.existingProduct != null
                ? Translations.of(
                    context,
                  ).vendor_products.create_product.snackbar_update_failed
                : Translations.of(
                    context,
                  ).vendor_products.create_product.snackbar_create_failed,
          ),
          backgroundColor: AppColors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        backgroundColor: theme.surface,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: AppColors.primary,
            size: 20,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.existingProduct != null
              ? Translations.of(
                  context,
                ).vendor_products.create_product.app_bar_edit
              : Translations.of(
                  context,
                ).vendor_products.create_product.app_bar_new,
          style: GoogleFonts.poppins(
            color: theme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: ListView(
                padding: const EdgeInsets.all(25),
                children: [
                  _buildTextField(
                    controller: _nameController,
                    label: Translations.of(
                      context,
                    ).vendor_products.create_product.field_name_label,
                    hint: Translations.of(
                      context,
                    ).vendor_products.create_product.field_name_hint,
                    isRequired: true,
                  ),
                  const Gap(AppSpacing.md),
                  _buildTextField(
                    controller: _descriptionController,
                    label: Translations.of(
                      context,
                    ).vendor_products.create_product.field_description_label,
                    hint: Translations.of(
                      context,
                    ).vendor_products.create_product.field_description_hint,
                    maxLines: 3,
                  ),
                  const Gap(AppSpacing.md),
                  _buildTextField(
                    controller: _priceController,
                    label: Translations.of(
                      context,
                    ).vendor_products.create_product.field_price_label,
                    hint: Translations.of(
                      context,
                    ).vendor_products.create_product.field_price_hint,
                    isRequired: true,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  const Gap(AppSpacing.md),
                  _buildTextField(
                    controller: _stockController,
                    label: Translations.of(
                      context,
                    ).vendor_products.create_product.field_stock_label,
                    hint: Translations.of(
                      context,
                    ).vendor_products.create_product.field_stock_hint,
                    isRequired: true,
                    keyboardType: TextInputType.number,
                  ),
                  const Gap(AppSpacing.md),
                  _buildProductTypeSelector(),
                  if (_productType == 'spare_part') ...[
                    const Gap(AppSpacing.lg),
                    _buildSparePartSection(),
                  ],
                  const Gap(AppSpacing.lg),
                  _buildImageUploadSection(),
                  const Gap(AppSpacing.lg),
                  GradientElevatedButton(
                    text: widget.existingProduct != null
                        ? Translations.of(
                            context,
                          ).vendor_products.create_product.button_save
                        : Translations.of(
                            context,
                          ).vendor_products.create_product.button_create,
                    onPressed: _isLoading ? null : _submit,
                    isLoading: _isLoading,
                  ),
                ],
              ),
            ),
            if (_isLoading)
              ShimmerSkeletons.cardSkeleton(height: double.infinity),
          ],
        ),
      ),
    );
  }

  Widget _buildSparePartSection() {
    final theme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translations.of(context)
                .vendor_products
                .create_product
                .spare_part_section_title,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: theme.onSurface,
            ),
          ),
          const Gap(AppSpacing.sm),
          _buildTextField(
            controller: _partNumberController,
            label: Translations.of(context)
                .vendor_products
                .create_product
                .part_number_label,
            hint: 'e.g. BP-TYC-F-1819',
          ),
          const Gap(AppSpacing.sm),
          _buildTextField(
            controller: _brandController,
            label: Translations.of(context)
                .vendor_products
                .create_product
                .brand_label,
            hint: 'e.g. Bosch',
          ),
          const Gap(AppSpacing.sm),
          _buildTextField(
            controller: _warrantyMonthsController,
            label: Translations.of(context)
                .vendor_products
                .create_product
                .warranty_label,
            hint: '0–120',
            keyboardType: TextInputType.number,
          ),
          const Gap(AppSpacing.md),
          Text(
            Translations.of(context)
                .vendor_products
                .create_product
                .compatibility_label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: theme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const Gap(AppSpacing.xs),
          if (_compatibilityEntries.isEmpty)
            Text(
              Translations.of(context)
                  .vendor_products
                  .create_product
                  .compatibility_empty,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: theme.onSurface.withValues(alpha: 0.5),
              ),
            )
          else
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _compatibilityEntries
                  .map(
                    (e) => Chip(
                      label: Text(
                        '${e.make} ${e.model} ${e.yearStart}-${e.yearEnd}',
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11,
                        ),
                      ),
                      onDeleted: () =>
                          setState(() => _compatibilityEntries.remove(e)),
                    ),
                  )
                  .toList(),
            ),
          const Gap(AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _newEntryMake,
                  label: Translations.of(context)
                      .vendor_products
                      .create_product
                      .compatibility_make,
                  hint: 'Toyota',
                ),
              ),
              const Gap(AppSpacing.sm),
              Expanded(
                child: _buildTextField(
                  controller: _newEntryModel,
                  label: Translations.of(context)
                      .vendor_products
                      .create_product
                      .compatibility_model,
                  hint: 'Camry',
                ),
              ),
            ],
          ),
          const Gap(AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: _buildTextField(
                  controller: _newEntryYearStart,
                  label: Translations.of(context)
                      .vendor_products
                      .create_product
                      .compatibility_year_from,
                  hint: '2018',
                  keyboardType: TextInputType.number,
                ),
              ),
              const Gap(AppSpacing.sm),
              Expanded(
                child: _buildTextField(
                  controller: _newEntryYearEnd,
                  label: Translations.of(context)
                      .vendor_products
                      .create_product
                      .compatibility_year_to,
                  hint: '2023',
                  keyboardType: TextInputType.number,
                ),
              ),
              const Gap(AppSpacing.sm),
              IconButton(
                onPressed: () {
                  final make = _newEntryMake.text.trim();
                  final model = _newEntryModel.text.trim();
                  final ys = int.tryParse(_newEntryYearStart.text.trim());
                  final ye = int.tryParse(_newEntryYearEnd.text.trim());
                  if (make.isEmpty ||
                      model.isEmpty ||
                      ys == null ||
                      ye == null ||
                      ys > ye) {
                    return;
                  }
                  setState(() {
                    _compatibilityEntries.add(
                      CompatibilityEntry(
                        make: make,
                        model: model,
                        yearStart: ys,
                        yearEnd: ye,
                      ),
                    );
                    _newEntryMake.clear();
                    _newEntryModel.clear();
                    _newEntryYearStart.clear();
                    _newEntryYearEnd.clear();
                  });
                },
                icon: const Icon(Icons.add),
                tooltip: Translations.of(context)
                    .vendor_products
                    .create_product
                    .compatibility_add,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductTypeSelector() {
    final theme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: Translations.of(
              context,
            ).vendor_products.create_product.product_type_label,
            style: GoogleFonts.poppins(
              color: theme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: ' *',
                style: GoogleFonts.poppins(color: AppColors.red),
              ),
            ],
          ),
        ),
        const Gap(AppSpacing.sm),
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _productType = 'accessory'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: _productType == 'accessory'
                        ? AppColors.primary
                        : theme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                    border: _productType != 'accessory'
                        ? Border.all(
                            color: AppColors.textSecondary.withValues(
                              alpha: 0.2,
                            ),
                          )
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      Translations.of(
                        context,
                      ).vendor_products.create_product.product_type_accessory,
                      style: GoogleFonts.poppins(
                        color: _productType == 'accessory'
                            ? AppColors.white
                            : theme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(AppSpacing.md),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _productType = 'spare_part'),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  decoration: BoxDecoration(
                    color: _productType == 'spare_part'
                        ? AppColors.primary
                        : theme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                    border: _productType != 'spare_part'
                        ? Border.all(
                            color: AppColors.textSecondary.withValues(
                              alpha: 0.2,
                            ),
                          )
                        : null,
                  ),
                  child: Center(
                    child: Text(
                      Translations.of(
                        context,
                      ).vendor_products.create_product.product_type_spare_part,
                      style: GoogleFonts.poppins(
                        color: _productType == 'spare_part'
                            ? AppColors.white
                            : theme.onSurface,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? hint,
    bool isRequired = false,
    int maxLines = 1,
    TextInputType? keyboardType,
  }) {
    final theme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: GoogleFonts.poppins(
              color: theme.onSurface,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            children: [
              if (isRequired)
                TextSpan(
                  text: ' *',
                  style: GoogleFonts.poppins(color: AppColors.red),
                ),
            ],
          ),
        ),
        const Gap(AppSpacing.sm),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: GoogleFonts.poppins(color: theme.onSurface),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(color: AppColors.textSecondary),
            filled: true,
            fillColor: theme.primaryContainer,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primary),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.red),
            ),
          ),
          validator: isRequired
              ? (value) {
                  if (value == null || value.trim().isEmpty) {
                    return Translations.of(context)
                        .vendor_products
                        .create_product
                        .validation_required
                        .replaceAll('{field}', label);
                  }
                  if (keyboardType ==
                      const TextInputType.numberWithOptions(decimal: true)) {
                    final numValue = double.tryParse(value.trim());
                    if (numValue == null || numValue <= 0) {
                      return Translations.of(context)
                          .vendor_products
                          .create_product
                          .validation_valid_number
                          .replaceAll('{field}', label);
                    }
                  }
                  if (keyboardType == TextInputType.number) {
                    final numValue = int.tryParse(value.trim());
                    if (numValue == null || numValue < 0) {
                      return Translations.of(context)
                          .vendor_products
                          .create_product
                          .validation_valid_number
                          .replaceAll('{field}', label);
                    }
                  }
                  return null;
                }
              : null,
        ),
      ],
    );
  }

  Widget _buildImageUploadSection() {
    final theme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              Translations.of(
                context,
              ).vendor_products.create_product.images_title,
              style: GoogleFonts.poppins(
                color: theme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const Gap(AppSpacing.xs),
        Text(
          Translations.of(
            context,
          ).vendor_products.create_product.images_subtitle,
          style: GoogleFonts.poppins(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        const Gap(AppSpacing.md),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            ..._imageUrls.asMap().entries.map((entry) {
              return _buildImagePreview(entry.value, entry.key);
            }),
            if (_selectedImages.isNotEmpty)
              ..._selectedImages.map((file) => _buildFilePreview(file)),
            if (_isUploadingImage)
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: theme.primaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                ),
              ),
            _buildAddImageButton(theme),
          ],
        ),
      ],
    );
  }

  Widget _buildImagePreview(String url, int index) {
    return Stack(
      children: [
        buildPlatformImage(
          url: url,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
          placeholder: Container(
            width: 80,
            height: 80,
            color: AppColors.primary.withValues(alpha: 0.15),
            child: const Icon(Icons.image, color: AppColors.primary),
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        Positioned(
          top: 4,
          right: 4,
          child: GestureDetector(
            onTap: () => setState(() => _imageUrls.removeAt(index)),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: AppColors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: AppColors.white, size: 12),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilePreview(XFile xFile) {
    return FutureBuilder<Uint8List>(
      future: xFile.readAsBytes(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.memory(
              snapshot.data!,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          );
        }
        return Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          ),
        );
      },
    );
  }

  Widget _buildAddImageButton(ColorScheme theme) {
    return GestureDetector(
      onTap: _isUploadingImage ? null : _pickAndUploadImage,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          color: theme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade700),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.add_photo_alternate_outlined,
                color: AppColors.primary,
                size: 24,
              ),
              const Gap(AppSpacing.xs),
              Text(
                Translations.of(
                  context,
                ).vendor_products.create_product.add_image_button,
                style: GoogleFonts.poppins(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
