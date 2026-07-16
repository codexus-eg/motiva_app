import 'dart:typed_data';

import 'package:app/core/providers/upload_provider.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/features/service-categories/domain/entities/service_category.dart';
import 'package:app/features/service-categories/presentation/providers/category_with_schema_provider.dart';
import 'package:app/features/vendor-services/domain/entities/vendor_service.dart';
import 'package:app/features/vendor-services/domain/repositories/vendor_service_repository.dart';
import 'package:app/features/vendor-services/presentation/providers/vendor_services_provider.dart';
import 'package:app/shared/ui/buttons/gradient_elevated_button.dart';
import 'package:app/shared/ui/dialogs/confirmation_dialog.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app/core/theme/spacing.dart';

class CreateServiceScreen extends ConsumerStatefulWidget {
  final String? categoryId;
  final VendorService? existingService;

  const CreateServiceScreen({super.key, this.categoryId, this.existingService});

  @override
  ConsumerState<CreateServiceScreen> createState() =>
      _CreateServiceScreenState();
}

class _CreateServiceScreenState extends ConsumerState<CreateServiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _radiusController = TextEditingController(text: '20');

  late String _categoryId;
  Map<String, dynamic> _categoryServiceAttributes = {};
  List<AttributeField> _requiredCustomerFields = [];
  bool _isLoading = false;

  String? _imageUrl;
  XFile? _selectedServiceImage;
  bool _isUploadingImage = false;

  @override
  void initState() {
    super.initState();
    _categoryId = widget.existingService?.categoryId ?? widget.categoryId ?? '';
    _nameController.text = widget.existingService?.name ?? '';
    _descriptionController.text = widget.existingService?.description ?? '';
    _priceController.text = widget.existingService?.basePrice ?? '';
    _radiusController.text =
        widget.existingService?.availabilityRadiusKm?.toString() ?? '20';
    if (widget.existingService != null) {
      _categoryServiceAttributes = Map.from(
        widget.existingService!.categoryServiceAttributes,
      );
      _requiredCustomerFields = List.from(
        widget.existingService!.requiredCustomerFields,
      );
      _imageUrl = widget.existingService?.imageUrl;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _radiusController.dispose();
    super.dispose();
  }

  Future<void> _pickAndUploadImage() async {
    final uploadService = ref.read(uploadServiceProvider);

    final file = await uploadService.pickImage(source: ImageSource.gallery);
    if (file == null) return;

    setState(() {
      _isUploadingImage = true;
      _selectedServiceImage = file;
    });

    final result = await uploadService.uploadFile(file, folder: 'services');

    setState(() {
      _isUploadingImage = false;
      if (result != null) {
        _imageUrl = result.url;
      }
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (_categoryId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text(t.vendor_services.create_screen.error.no_category),
          backgroundColor: AppColors.red,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    bool success;
    if (widget.existingService != null) {
      final params = UpdateServiceParams(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isNotEmpty
            ? _descriptionController.text.trim()
            : null,
        basePrice: double.tryParse(_priceController.text.trim()),
        imageUrl: _imageUrl,
        categoryServiceAttributes: _categoryServiceAttributes,
        requiredCustomerFields: _requiredCustomerFields,
        availabilityRadiusKm: double.tryParse(_radiusController.text.trim()),
      );
      success = await ref
          .read(vendorServicesNotifierProvider.notifier)
          .updateService(widget.existingService!.id, params);
    } else {
      final params = CreateServiceParams(
        categoryId: _categoryId,
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim().isNotEmpty
            ? _descriptionController.text.trim()
            : null,
        basePrice: double.tryParse(_priceController.text.trim()),
        imageUrl: _imageUrl,
        categoryServiceAttributes: _categoryServiceAttributes,
        requiredCustomerFields: _requiredCustomerFields,
        availabilityRadiusKm: double.tryParse(_radiusController.text.trim()),
      );
      success = await ref
          .read(vendorServicesNotifierProvider.notifier)
          .createService(params);
    }

    setState(() => _isLoading = false);

    if (success && mounted) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.existingService != null
                ? t.vendor_services.create_screen.snackbar.update_success
                : t.vendor_services.create_screen.snackbar.create_success,
          ),
          backgroundColor: AppColors.green,
        ),
      );
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            widget.existingService != null
                ? t.vendor_services.create_screen.snackbar.update_failed
                : t.vendor_services.create_screen.snackbar.create_failed,
          ),
          backgroundColor: AppColors.red,
        ),
      );
    }
  }

  Future<void> _confirmDelete() async {
    if (widget.existingService == null) return;

    final confirmed = await ConfirmationDialog.show(
      context: context,
      title: t.vendor_services.create_screen.dialog.archive_title,
      message: t.vendor_services.create_screen.dialog.archive_message.replaceAll(
        '{name}', widget.existingService!.name,
      ),
      confirmText: t.vendor_services.create_screen.dialog.archive_confirm,
      confirmColor: AppColors.red,
      icon: Icons.archive,
    );

    if (confirmed == true && mounted) {
      setState(() => _isLoading = true);
      final success = await ref
          .read(vendorServicesNotifierProvider.notifier)
          .archiveService(widget.existingService!.id);
      setState(() => _isLoading = false);

      if (success && mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              t.vendor_services.create_screen.snackbar.archive_success,
            ),
            backgroundColor: AppColors.green,
          ),
        );
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              t.vendor_services.create_screen.snackbar.archive_failed,
            ),
            backgroundColor: AppColors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoryAsync = ref.watch(categoryWithSchemaProvider(_categoryId));
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
          widget.existingService != null
              ? t.vendor_services.create_screen.app_bar.edit
              : t.vendor_services.create_screen.app_bar.new_title,
          style: GoogleFonts.poppins(
            color: theme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          if (widget.existingService != null &&
              !widget.existingService!.isArchived)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: GestureDetector(
                onTap: _confirmDelete,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.red.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.archive_outlined,
                    color: AppColors.red,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
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
                  if (categoryAsync.isLoading)
                    ShimmerSkeletons.cardSkeleton()
                  else if (categoryAsync.hasError)
                    _buildErrorCard(
                      t.vendor_services.create_screen.error.load_category,
                    )
                  else if (categoryAsync.value != null)
                    _buildCategoryHeader(categoryAsync.value!),
                  const Gap(AppSpacing.lg),
                  _buildTextField(
                    controller: _nameController,
                    label:
                        t.vendor_services.create_screen.form.service_name.label,
                    hint:
                        t.vendor_services.create_screen.form.service_name.hint,
                    isRequired: true,
                  ),
                  const Gap(AppSpacing.md),
                  _buildTextField(
                    controller: _descriptionController,
                    label:
                        t.vendor_services.create_screen.form.description.label,
                    hint: t.vendor_services.create_screen.form.description.hint,
                    maxLines: 3,
                  ),
                  const Gap(AppSpacing.md),
                  _buildTextField(
                    controller: _priceController,
                    label:
                        t.vendor_services.create_screen.form.base_price.label,
                    hint: t.vendor_services.create_screen.form.base_price.hint,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  const Gap(AppSpacing.md),
                  _buildTextField(
                    controller: _radiusController,
                    label: t.vendor_services.create_screen.form.radius.label,
                    hint: t.vendor_services.create_screen.form.radius.hint,
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  const Gap(AppSpacing.lg),
                  _buildImageUploadSection(),
                  const Gap(AppSpacing.lg),
                  if (categoryAsync.value != null) ...[
                    _buildAttributeFields(categoryAsync.value!.attributeSchema),
                    const Gap(AppSpacing.lg),
                    _buildCustomerFieldsDefinition(),
                    const Gap(AppSpacing.lg),
                  ],
                  GradientElevatedButton(
                    text: widget.existingService != null
                        ? t.vendor_services.create_screen.button.save
                        : t.vendor_services.create_screen.button.create,
                    onPressed: _isLoading ? null : _submit,
                    isLoading: _isLoading,
                  ),
                  if (widget.existingService != null) ...[
                    const Gap(AppSpacing.md),
                    _buildArchiveButton(),
                  ],
                ],
              ),
            ),
            if (_isLoading) ShimmerSkeletons.cardSkeleton(),
          ],
        ),
      ),
    );
  }

  Widget _buildArchiveButton() {
    if (widget.existingService!.isArchived) {
      return Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.green.withValues(alpha: 0.5),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: TextButton.icon(
          onPressed: () async {
            final success = await ref
                .read(vendorServicesNotifierProvider.notifier)
                .restoreService(widget.existingService!.id);
            if (success && mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    t.vendor_services.create_screen.snackbar.restore_success,
                  ),
                  backgroundColor: AppColors.green,
                ),
              );
            }
          },
          icon: const Icon(Icons.restore, color: AppColors.green),
          label: Text(
            t.vendor_services.create_screen.button.restore,
            style: GoogleFonts.poppins(
              color: AppColors.green,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  Widget _buildCategoryHeader(ServiceCategoryWithSchema category) {
    final theme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.primaryContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.category, color: AppColors.primary),
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: GoogleFonts.poppins(
                    color: theme.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (category.description != null &&
                    category.description!.isNotEmpty)
                  Text(
                    category.description!,
                    style: GoogleFonts.poppins(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
          ),
        ],
      ),
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
                    return t.vendor_services.create_screen.form.service_name
                        .required.replaceAll('{field}', label);
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
              t.vendor_services.create_screen.image_upload.title,
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
          t.vendor_services.create_screen.image_upload.subtitle,
          style: GoogleFonts.poppins(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        const Gap(AppSpacing.md),
        GestureDetector(
          onTap: _isUploadingImage ? null : _pickAndUploadImage,
          child: Container(
            height: 180,
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.primaryContainer,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _hasImage()
                    ? AppColors.primary.withValues(alpha: 0.5)
                    : Colors.grey.shade700,
                width: _hasImage() ? 2 : 1,
              ),
            ),
            child: _isUploadingImage
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ShimmerSkeletons.circleSkeleton(),
                        const Gap(AppSpacing.sm),
                        Text(
                          t
                              .vendor_services
                              .create_screen
                              .image_upload
                              .uploading,
                          style: GoogleFonts.poppins(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  )
                : _hasImage()
                ? Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(11),
                        child: _selectedServiceImage != null
                            ? FutureBuilder<Uint8List>(
                                future: _selectedServiceImage!.readAsBytes(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Image.memory(
                                      snapshot.data!,
                                      fit: BoxFit.cover,
                                      width: double.infinity,
                                      height: double.infinity,
                                    );
                                  }
                                  return Container(
                                    color: theme.primaryContainer,
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Image.network(
                                _imageUrl!,
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                                errorBuilder: (_, _, _) => _buildPlaceholder(),
                              ),
                      ),
                      Positioned(
                        bottom: 12,
                        right: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: theme.primaryContainer.withValues(
                              alpha: 0.7,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.edit,
                                color: theme.onSurface,
                                size: 16,
                              ),
                              const Gap(AppSpacing.sm),
                              Text(
                                t
                                    .vendor_services
                                    .create_screen
                                    .image_upload
                                    .change,
                                style: GoogleFonts.poppins(
                                  color: theme.onSurface,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : _buildPlaceholder(),
          ),
        ),
      ],
    );
  }

  bool _hasImage() {
    return _imageUrl != null && _imageUrl!.isNotEmpty ||
        _selectedServiceImage != null;
  }

  Widget _buildPlaceholder() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.add_photo_alternate_outlined,
              color: AppColors.primary,
              size: 32,
            ),
          ),
          const Gap(AppSpacing.md),
          Text(
            t.vendor_services.create_screen.image_upload.placeholder_title,
            style: GoogleFonts.poppins(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
          const Gap(AppSpacing.xs),
          Text(
            t.vendor_services.create_screen.image_upload.placeholder_subtitle,
            style: GoogleFonts.poppins(
              color: AppColors.textSecondary.withValues(alpha: 0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttributeFields(List<AttributeField> fields) {
    if (fields.isEmpty) return const SizedBox.shrink();
    final theme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              t.vendor_services.create_screen.attributes.title,
              style: GoogleFonts.poppins(
                color: theme.onSurface,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Gap(AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                t.vendor_services.create_screen.attributes.required_badge,
                style: GoogleFonts.poppins(
                  color: AppColors.primary,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const Gap(AppSpacing.xs),
        Text(
          t.vendor_services.create_screen.attributes.subtitle,
          style: GoogleFonts.poppins(
            color: AppColors.textSecondary,
            fontSize: 12,
          ),
        ),
        const Gap(AppSpacing.md),
        ...fields.map((field) => _buildAttributeField(field)),
      ],
    );
  }

  Widget _buildAttributeField(AttributeField field) {
    Widget fieldWidget;
    final theme = Theme.of(context).colorScheme;
    final label = RichText(
      text: TextSpan(
        text: field.label,
        style: GoogleFonts.poppins(
          color: theme.onSurface,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        children: [
          if (field.required)
            TextSpan(
              text: ' *',
              style: GoogleFonts.poppins(color: AppColors.red),
            ),
        ],
      ),
    );

    switch (field.type) {
      case 'select':
        String? selectedValue =
            _categoryServiceAttributes[field.key] as String?;
        fieldWidget = DropdownButtonFormField<String>(
          initialValue: selectedValue,
          items: (field.options ?? []).map((opt) {
            return DropdownMenuItem(
              value: opt,
              child: Text(
                opt,
                style: GoogleFonts.poppins(color: theme.onSurface),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              if (value != null) {
                _categoryServiceAttributes[field.key] = value;
              }
            });
          },
          dropdownColor: theme.primaryContainer,
          decoration: InputDecoration(
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
          ),
        );
        break;
      case 'number':
        final numValue = _categoryServiceAttributes[field.key];
        fieldWidget = TextFormField(
          //numValue != null ? numValue.toString() : null
          initialValue: numValue?.toString(),
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          style: GoogleFonts.poppins(color: theme.onSurface),
          decoration: InputDecoration(
            hintText: t.vendor_services.create_screen.attributes.hint.replaceAll(
              '{field}', field.label.toLowerCase(),
            ),
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
          ),
          onChanged: (value) {
            final parsed = num.tryParse(value);
            setState(() {
              if (value.isEmpty) {
                _categoryServiceAttributes.remove(field.key);
              } else if (parsed != null) {
                _categoryServiceAttributes[field.key] = parsed.toDouble();
              }
            });
          },
        );
        break;
      case 'boolean':
        fieldWidget = Switch(
          value: _categoryServiceAttributes[field.key] == true,
          activeTrackColor: AppColors.primary.withValues(alpha: 0.5),
          activeThumbColor: AppColors.primary,
          onChanged: (value) {
            setState(() {
              _categoryServiceAttributes[field.key] = value;
            });
          },
        );
        break;
      default:
        fieldWidget = TextFormField(
          initialValue: _categoryServiceAttributes[field.key]?.toString(),
          style: GoogleFonts.poppins(color: theme.onSurface),
          decoration: InputDecoration(
            hintText: t.vendor_services.create_screen.attributes.hint.replaceAll(
              '{field}', field.label.toLowerCase(),
            ),
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
          ),
          onChanged: (value) {
            _categoryServiceAttributes[field.key] = value;
          },
        );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [label, const Gap(AppSpacing.sm), fieldWidget],
      ),
    );
  }

  Widget _buildErrorCard(String message) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.error_outline, color: AppColors.red),
          const Gap(AppSpacing.md),
          Expanded(
            child: Text(
              message,
              style: GoogleFonts.poppins(color: AppColors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerFieldsDefinition() {
    final theme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              t.vendor_services.create_screen.customer_questions.title,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: theme.onSurface,
              ),
            ),
          ],
        ),
        const Gap(AppSpacing.sm),
        Text(
          t.vendor_services.create_screen.customer_questions.subtitle,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const Gap(AppSpacing.md),
        if (_requiredCustomerFields.isNotEmpty) ...[
          ..._requiredCustomerFields.asMap().entries.map((entry) {
            final idx = entry.key;
            final field = entry.value;
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          field.label,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: theme.onSurface,
                          ),
                        ),
                        const Gap(2),
                        Text(
                          '${field.type}${field.required ? t.vendor_services.create_screen.customer_questions.required_suffix : ''}',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    color: AppColors.red,
                    onPressed: () {
                      setState(() {
                        _requiredCustomerFields = List.from(
                          _requiredCustomerFields,
                        )..removeAt(idx);
                      });
                    },
                  ),
                ],
              ),
            );
          }),
          const Gap(AppSpacing.md),
        ],
        OutlinedButton.icon(
          onPressed: _showAddCustomerFieldDialog,
          icon: const Icon(Icons.add, size: 18),
          label: Text(
            t.vendor_services.create_screen.customer_questions.add_button,
            style: GoogleFonts.poppins(fontSize: 13),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: AppColors.primary,
            side: const BorderSide(color: AppColors.primary),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _showAddCustomerFieldDialog() async {
    final labelController = TextEditingController();
    final optionsController = TextEditingController();
    final minController = TextEditingController();
    final maxController = TextEditingController();
    String selectedType = 'text';
    bool isRequired = false;

    final result = await showDialog<bool>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: Theme.of(ctx).colorScheme.primaryContainer,
          title: Text(
            t.vendor_services.create_screen.dialog.add_question_title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: Theme.of(ctx).colorScheme.onSurface,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.vendor_services.create_screen.dialog.label,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Gap(4),
                TextField(
                  controller: labelController,
                  style: GoogleFonts.poppins(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: t.vendor_services.create_screen.dialog.label_hint,
                    filled: true,
                    fillColor: Theme.of(ctx).colorScheme.primaryContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const Gap(AppSpacing.md),
                Text(
                  t.vendor_services.create_screen.dialog.type,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Gap(4),
                DropdownButtonFormField<String>(
                  initialValue: selectedType,
                  items: ['text', 'number', 'select', 'boolean', 'file']
                      .map(
                        (t) => DropdownMenuItem(
                          value: t,
                          child: Text(
                            t[0].toUpperCase() + t.substring(1),
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (v) =>
                      setDialogState(() => selectedType = v ?? 'text'),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(ctx).colorScheme.primaryContainer,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const Gap(AppSpacing.md),
                SwitchListTile(
                  title: Text(
                    t.vendor_services.create_screen.dialog.required,
                    style: GoogleFonts.poppins(fontSize: 14),
                  ),
                  value: isRequired,
                  onChanged: (v) => setDialogState(() => isRequired = v),
                ),
                if (selectedType == 'select') ...[
                  const Gap(AppSpacing.sm),
                  Text(
                    t.vendor_services.create_screen.dialog.options_label,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Gap(4),
                  TextField(
                    controller: optionsController,
                    style: GoogleFonts.poppins(fontSize: 14),
                    decoration: InputDecoration(
                      hintText: t.vendor_services.create_screen.dialog.options_hint,
                      filled: true,
                      fillColor: Theme.of(ctx).colorScheme.primaryContainer,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
                if (selectedType == 'number') ...[
                  const Gap(AppSpacing.sm),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.vendor_services.create_screen.dialog.min,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const Gap(4),
                            SizedBox(
                              height: 44,
                              child: TextField(
                                controller: minController,
                                keyboardType: TextInputType.number,
                                style: GoogleFonts.poppins(fontSize: 14),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(
                                    ctx,
                                  ).colorScheme.primaryContainer,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Gap(AppSpacing.md),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.vendor_services.create_screen.dialog.max,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const Gap(4),
                            SizedBox(
                              height: 44,
                              child: TextField(
                                controller: maxController,
                                keyboardType: TextInputType.number,
                                style: GoogleFonts.poppins(fontSize: 14),
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Theme.of(
                                    ctx,
                                  ).colorScheme.primaryContainer,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: Text(t.vendor_services.create_screen.dialog.cancel, style: GoogleFonts.poppins(fontSize: 14)),
            ),
            ElevatedButton(
              onPressed: () {
                final label = labelController.text.trim();
                if (label.isEmpty) return;
                final key = label
                    .toLowerCase()
                    .replaceAll(' ', '_')
                    .replaceAll(RegExp(r'[^a-z0-9_]'), '');
                final field = AttributeField(
                  key: key,
                  label: label,
                  type: selectedType,
                  required: isRequired,
                  options: selectedType == 'select'
                      ? optionsController.text
                            .split(',')
                            .map((s) => s.trim())
                            .where((s) => s.isNotEmpty)
                            .toList()
                      : null,
                  min: selectedType == 'number'
                      ? num.tryParse(minController.text.trim())
                      : null,
                  max: selectedType == 'number'
                      ? num.tryParse(maxController.text.trim())
                      : null,
                );
                Navigator.of(ctx).pop(true);
                setState(() {
                  _requiredCustomerFields = List.from(_requiredCustomerFields)
                    ..add(field);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: Text(
                t.vendor_services.create_screen.dialog.add,
                style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );

    labelController.dispose();
    optionsController.dispose();
    minController.dispose();
    maxController.dispose();

    if (result == true) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.vendor_services.create_screen.snackbar.question_added)));
    }
  }
}
