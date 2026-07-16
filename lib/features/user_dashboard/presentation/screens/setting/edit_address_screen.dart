import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/cart/data/models/delivery_address_model.dart';
import 'package:app/features/cart/domain/entities/delivery_address.dart';
import 'package:app/features/cart/presentation/providers/checkout_provider.dart';
import 'package:app/features/user_dashboard/presentation/widgets/setting/custom_dialog_widget.dart';
import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:uuid/uuid.dart';

class EditAddressScreen extends ConsumerStatefulWidget {
  final DeliveryAddress? address;

  const EditAddressScreen({super.key, this.address});

  @override
  ConsumerState<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends ConsumerState<EditAddressScreen> {
  static const Color _accentColor = Color(0xFFDC8735);
  static const Color _placeholderColor = Color(0xFF939498);

  late final TextEditingController _labelController;
  late final TextEditingController _buildingController;
  late final TextEditingController _apartmentController;
  late final TextEditingController _streetController;
  late final TextEditingController _blockController;
  late final TextEditingController _avenueController;
  late final TextEditingController _notesController;
  late final TextEditingController _phoneController;
  late final TextEditingController _areaController;
  late final TextEditingController _secondLabelController;

  String _propertyType = 'Apartment';

  bool get _isEditing => widget.address != null;

  @override
  void initState() {
    super.initState();
    final a = widget.address;
    _labelController = TextEditingController(text: a?.label ?? '');
    _buildingController = TextEditingController(text: a?.building ?? '');
    _apartmentController = TextEditingController(text: a?.apartment ?? '');
    _streetController = TextEditingController(text: a?.street ?? '');
    _blockController = TextEditingController(text: a?.block ?? '');
    _avenueController = TextEditingController(text: '');
    _notesController = TextEditingController(text: a?.notes ?? '');
    _phoneController = TextEditingController(text: a?.phone ?? '');
    _areaController = TextEditingController(text: a?.area ?? '');
    _secondLabelController = TextEditingController(text: '');
  }

  @override
  void dispose() {
    _labelController.dispose();
    _buildingController.dispose();
    _apartmentController.dispose();
    _streetController.dispose();
    _blockController.dispose();
    _avenueController.dispose();
    _notesController.dispose();
    _phoneController.dispose();
    _areaController.dispose();
    _secondLabelController.dispose();
    super.dispose();
  }

  Future<void> _saveAddress() async {
    if (_streetController.text.isEmpty ||
        _areaController.text.isEmpty ||
        _blockController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            Translations.of(
              context,
            ).user_dashboard.settings.edit_address.validation.required_fields,
          ),
        ),
      );
      return;
    }

    final address = DeliveryAddress(
      id: widget.address?.id ?? const Uuid().v4(),
      label: _labelController.text.isEmpty
          ? Translations.of(
              context,
            ).user_dashboard.settings.edit_address.default_label
          : _labelController.text,
      street: _streetController.text,
      area: _areaController.text,
      block: _blockController.text,
      building: _buildingController.text.isEmpty
          ? null
          : _buildingController.text,
      apartment: _apartmentController.text.isEmpty
          ? null
          : _apartmentController.text,
      notes: _notesController.text.isEmpty ? null : _notesController.text,
      phone: _phoneController.text.isEmpty ? null : _phoneController.text,
    );

    final localDataSource = ref.read(addressLocalDataSourceProvider);
    await localDataSource.saveAddress(DeliveryAddressModel.fromEntity(address));
    ref.invalidate(savedAddressesProvider);

    if (mounted) Navigator.pop(context);
  }

  Future<void> _deleteAddress() async {
    if (widget.address == null) return;
    final localDataSource = ref.read(addressLocalDataSourceProvider);
    await localDataSource.deleteAddress(widget.address!.id);
    ref.invalidate(savedAddressesProvider);

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const Gap(AppSpacing.lg),
                  _buildMapPreview(),
                  const Gap(AppSpacing.md),
                  _buildAreaCard(context),
                  const Gap(AppSpacing.lg),
                  _buildPropertyTypeChips(),
                  const Gap(AppSpacing.lg),
                  _buildInputField(
                    context: context,
                    controller: _labelController,
                    label: Translations.of(
                      context,
                    ).user_dashboard.settings.edit_address.fields.address_title,
                    width: double.infinity,
                  ),
                  const Gap(AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          context: context,
                          controller: _buildingController,
                          label: Translations.of(context)
                              .user_dashboard
                              .settings
                              .edit_address
                              .fields
                              .building_name,
                        ),
                      ),
                      const Gap(AppSpacing.md),
                      Expanded(
                        child: _buildInputField(
                          context: context,
                          controller: _apartmentController,
                          label: Translations.of(context)
                              .user_dashboard
                              .settings
                              .edit_address
                              .fields
                              .apt_number,
                        ),
                      ),
                    ],
                  ),
                  const Gap(AppSpacing.md),
                  _buildInputField(
                    context: context,
                    controller: _streetController,
                    label: Translations.of(
                      context,
                    ).user_dashboard.settings.edit_address.fields.street,
                    width: double.infinity,
                  ),
                  const Gap(AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: _buildInputField(
                          context: context,
                          controller: _blockController,
                          label: Translations.of(
                            context,
                          ).user_dashboard.settings.edit_address.fields.block,
                        ),
                      ),
                      const Gap(AppSpacing.md),
                      Expanded(
                        child: _buildInputField(
                          context: context,
                          controller: _avenueController,
                          hint: Translations.of(context)
                              .user_dashboard
                              .settings
                              .edit_address
                              .fields
                              .avenue_optional,
                        ),
                      ),
                    ],
                  ),
                  const Gap(AppSpacing.md),
                  _buildInputField(
                    context: context,
                    controller: _notesController,
                    hint: Translations.of(context)
                        .user_dashboard
                        .settings
                        .edit_address
                        .fields
                        .directions_optional,
                    width: double.infinity,
                  ),
                  const Gap(AppSpacing.md),
                  _buildPhoneField(context),
                  const Gap(AppSpacing.md),
                  _buildInputField(
                    context: context,
                    controller: _secondLabelController,
                    label: Translations.of(context)
                        .user_dashboard
                        .settings
                        .edit_address
                        .fields
                        .address_label_optional,
                    width: double.infinity,
                  ),
                  const Gap(AppSpacing.xl),
                  GradientButton(
                    text: Translations.of(
                      context,
                    ).user_dashboard.settings.edit_address.save_button,
                    onTap: _saveAddress,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 22),
          child: CustomDialogWidget(
            title: Translations.of(
              context,
            ).user_dashboard.settings.edit_address.delete_dialog.title,
            description: Translations.of(
              context,
            ).user_dashboard.settings.edit_address.delete_dialog.description,
            labelRightButton: Translations.of(
              context,
            ).user_dashboard.settings.edit_address.delete_dialog.yes,
            labelLeftButton: Translations.of(
              context,
            ).user_dashboard.settings.edit_address.delete_dialog.no,
            onTapRightButton: () {
              Navigator.of(dialogContext).pop();
              _deleteAddress();
            },
            onTapLeftButton: () => Navigator.of(dialogContext).pop(),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        IconButton(
          tooltip: SemanticLabels.backButton,
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: _accentColor,
        ),
        const Gap(AppSpacing.xs),
        Text(
          _isEditing
              ? Translations.of(
                  context,
                ).user_dashboard.settings.edit_address.edit_title
              : Translations.of(
                  context,
                ).user_dashboard.settings.edit_address.add_title,
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const Spacer(),
        if (_isEditing)
          TextButton(
            onPressed: () => _showDeleteDialog(context),
            child: Text(
              Translations.of(
                context,
              ).user_dashboard.settings.edit_address.delete,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: _accentColor,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMapPreview() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: AspectRatio(
        aspectRatio: 383 / 173,
        child: Image.asset('assets/images/location.png', fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildAreaCard(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  Translations.of(
                    context,
                  ).user_dashboard.settings.edit_address.area.label,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    height: 1.4,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                Text(
                  _areaController.text.isEmpty
                      ? Translations.of(
                          context,
                        ).user_dashboard.settings.edit_address.area.hint
                      : _areaController.text,
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    height: 1.4,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  backgroundColor: theme.colorScheme.surface,
                  title: Text(
                    Translations.of(
                      context,
                    ).user_dashboard.settings.edit_address.area.dialog_title,
                    style: GoogleFonts.poppins(
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  content: TextField(
                    controller: _areaController,
                    style: GoogleFonts.poppins(
                      color: theme.colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      hintText: Translations.of(
                        context,
                      ).user_dashboard.settings.edit_address.area.dialog_hint,
                      hintStyle: GoogleFonts.poppins(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: Text(
                        Translations.of(
                          context,
                        ).user_dashboard.settings.edit_address.area.cancel,
                        style: GoogleFonts.poppins(color: _accentColor),
                      ),
                    ),
                    TextButton(
                      onPressed: () => setState(() => Navigator.pop(ctx)),
                      child: Text(
                        Translations.of(
                          context,
                        ).user_dashboard.settings.edit_address.area.ok,
                        style: GoogleFonts.poppins(color: _accentColor),
                      ),
                    ),
                  ],
                ),
              );
            },
            child: Text(
              Translations.of(
                context,
              ).user_dashboard.settings.edit_address.area.change_button,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: _accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertyTypeChips() {
    final t = Translations.of(
      context,
    ).user_dashboard.settings.edit_address.property_types;
    final chipLabels = {
      'Apartment': t.apartment,
      'House': t.house,
      'Office': t.office,
    };
    final chips = chipLabels.keys.toList();
    return Wrap(
      spacing: 12,
      children: chips.map((value) {
        final label = chipLabels[value]!;
        final isSelected = value == _propertyType;
        return GestureDetector(
          onTap: () => setState(() => _propertyType = value),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? _accentColor : Colors.transparent,
              borderRadius: BorderRadius.circular(28),
              border: isSelected
                  ? null
                  : Border.all(color: const Color(0xFF9C9C9C), width: 1),
            ),
            child: Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? Colors.white : const Color(0xFF9C9C9C),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildInputField({
    String? label,
    String? hint,
    required BuildContext context,
    required TextEditingController controller,
    double? width,
  }) {
    final theme = Theme.of(context);

    final labelStyle = GoogleFonts.poppins(
      fontSize: 12,
      color: theme.colorScheme.onSurface,
    );
    final hintStyle = GoogleFonts.poppins(
      fontSize: 14,
      color: _placeholderColor,
    );
    final valueStyle = GoogleFonts.poppins(
      fontSize: 14,
      color: theme.colorScheme.onSurface,
    );

    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: BorderSide.none,
    );

    return SizedBox(
      width: width,
      child: TextFormField(
        controller: controller,
        style: valueStyle,
        cursorColor: _accentColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: theme.colorScheme.primaryContainer,
          labelText: label,
          labelStyle: labelStyle,
          hintText: hint,
          hintStyle: hintStyle,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),
          border: baseBorder,
          enabledBorder: baseBorder,
          focusedBorder: baseBorder.copyWith(
            borderSide: const BorderSide(color: _accentColor, width: 1),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Row(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Image.asset(
                  'assets/images/kuwait_flag.png',
                  width: 26,
                  height: 20,
                  fit: BoxFit.cover,
                ),
              ),
              const Gap(AppSpacing.sm),
              Icon(
                Icons.keyboard_arrow_down_rounded,
                color: theme.colorScheme.onSurface,
              ),
            ],
          ),
          const Gap(AppSpacing.md),
          Container(
            width: 1,
            height: 32,
            color: Colors.white.withValues(alpha: 0.15),
          ),
          const Gap(AppSpacing.md),
          Expanded(
            child: TextFormField(
              controller: _phoneController,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: theme.colorScheme.onSurface,
              ),
              cursorColor: _accentColor,
              decoration: InputDecoration(
                filled: true,
                fillColor: theme.colorScheme.primaryContainer,
                labelText: Translations.of(
                  context,
                ).user_dashboard.settings.edit_address.fields.phone_number,
                labelStyle: GoogleFonts.poppins(
                  fontSize: 12,
                  color: theme.colorScheme.onSurface,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 12,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
