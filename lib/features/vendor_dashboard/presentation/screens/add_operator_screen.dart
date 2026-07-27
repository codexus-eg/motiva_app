import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/core/theme/app_colors.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/vendor/domain/entities/operator.dart';
import 'package:app/features/vendor/presentation/providers/vendor_operators_provider.dart';
import 'package:app/features/vendor/presentation/providers/vendor_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:app/core/theme/spacing.dart';

class AddOperatorScreen extends ConsumerStatefulWidget {
  const AddOperatorScreen({super.key});

  @override
  ConsumerState<AddOperatorScreen> createState() => _AddOperatorScreenState();
}

class _AddOperatorScreenState extends ConsumerState<AddOperatorScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _emailError;
  String? _phoneError;
  String _fullPhoneNumber = '';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _emailError = null;
      _phoneError = null;
    });

    final vendorProfile = ref.read(vendorProfileProvider).valueOrNull;

    final phone = _fullPhoneNumber.isNotEmpty
        ? _fullPhoneNumber
        : (_phoneController.text.trim().startsWith('+')
              ? _phoneController.text.trim()
              : '+965${_phoneController.text.trim()}');

    final params = CreateOperatorParams(
      name: _nameController.text.trim(),
      phone: phone,
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      vendorId: vendorProfile?.id,
    );

    final result = await ref
        .read(vendorOperatorsProvider.notifier)
        .createOperator(params);

    setState(() => _isLoading = false);

    if (result.success && mounted) {
      Navigator.pop(context);
      final t = Translations.of(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.vendor_dashboard.add_operator.success),
          backgroundColor: Colors.green,
        ),
      );
    } else if (mounted) {
      if (result.field == 'email') {
        final t = Translations.of(context);
        setState(
          () => _emailError = t.vendor_dashboard.add_operator.email_exists,
        );
        _formKey.currentState!.validate();
      } else if (result.field == 'phone') {
        final t = Translations.of(context);
        setState(
          () => _phoneError = t.vendor_dashboard.add_operator.phone_exists,
        );
        _formKey.currentState!.validate();
      } else if (result.field == 'both') {
        final t = Translations.of(context);
        setState(() {
          _emailError = t.vendor_dashboard.add_operator.email_exists;
          _phoneError = t.vendor_dashboard.add_operator.phone_exists;
        });
        _formKey.currentState!.validate();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              result.errorMessage ?? t.vendor_dashboard.add_operator.failed,
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);
    return Scaffold(
      backgroundColor: theme.surface,
      appBar: AppBar(
        backgroundColor: theme.surface,
        elevation: 0,
        leading: IconButton(
          tooltip: SemanticLabels.backButton,
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.primary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          t.vendor_dashboard.add_operator.screen_title,
          style: GoogleFonts.poppins(
            color: theme.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle(
                  t.vendor_dashboard.add_operator.section_title,
                ),
                const Gap(AppSpacing.md),
                _buildTextFromField(
                  _nameController,
                  t.vendor_dashboard.add_operator.full_name,
                  Icons.person_outline,
                  (value) {
                    if (value == null || value.trim().isEmpty) {
                      return t.vendor_dashboard.add_operator.name_error;
                    }
                    return null;
                  },
                ),
                const Gap(AppSpacing.md),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IntlPhoneField(
                    controller: _phoneController,
                    initialCountryCode: 'KW',
                    disableLengthCheck: true,
                    textAlign: Directionality.of(context) == TextDirection.rtl
                        ? TextAlign.right
                        : TextAlign.left,
                    dropdownIcon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textSecondary,
                    ),
                    dropdownIconPosition: IconPosition.trailing,
                    flagsButtonPadding: EdgeInsets.zero,
                    flagsButtonMargin: const EdgeInsets.only(left: 12),
                    dropdownTextStyle: GoogleFonts.poppins(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    decoration: InputDecoration(
                      hintText: t.vendor_dashboard.add_operator.phone_number,
                      hintStyle: GoogleFonts.poppins(
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.only(top: 10),
                      isDense: true,
                      errorText: _phoneError,
                    ),
                    keyboardType: TextInputType.phone,
                    onChanged: (phone) {
                      _fullPhoneNumber = phone.completeNumber;
                      if (_phoneError != null) {
                        setState(() => _phoneError = null);
                      }
                    },
                    validator: (value) {
                      if (value == null || value.number.trim().isEmpty) {
                        return t.vendor_dashboard.add_operator.phone_error;
                      }
                      if (_phoneError != null) {
                        return _phoneError;
                      }
                      return null;
                    },
                  ),
                ),
                const Gap(AppSpacing.md),
                _buildTextFromField(
                  _emailController,
                  t.vendor_dashboard.add_operator.email_address,
                  Icons.email_outlined,
                  (value) {
                    if (value == null || value.trim().isEmpty) {
                      return t.vendor_dashboard.add_operator.email_error;
                    }
                    if (_emailError != null) {
                      return _emailError;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    if (_emailError != null && value.isNotEmpty) {
                      setState(() => _emailError = null);
                    }
                  },
                ),
                const Gap(AppSpacing.md),
                _buildTextFromField(
                  _passwordController,
                  t.vendor_dashboard.add_operator.password,
                  Icons.lock_outline,
                  (value) {
                    if (value == null || value.trim().isEmpty) {
                      return t.vendor_dashboard.add_operator.password_error;
                    }
                    if (value.length < 8) {
                      return t.vendor_dashboard.add_operator.password_min_error;
                    }
                    return null;
                  },
                ),
                const Gap(AppSpacing.xl),
                _buildSubmitButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: GoogleFonts.poppins(
        color: AppColors.textSecondary,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildTextFromField(
    TextEditingController? controller,
    String labelText,
    IconData? icon,
    FormFieldValidator<String>? validator, {
    ValueChanged<String>? onChanged,
  }) {
    final theme = Theme.of(context).colorScheme;
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      style: GoogleFonts.poppins(color: theme.onSurface),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: GoogleFonts.poppins(color: theme.onSurface),
        prefixIcon: Icon(icon, color: AppColors.textSecondary),
        filled: true,
        fillColor: theme.primaryContainer,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
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
      validator: validator,
    );
  }

  Widget _buildSubmitButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: GradientButton(
        text: _isLoading
            ? t.vendor_dashboard.add_operator.loading
            : t.vendor_dashboard.add_operator.add_operator_button,
        onTap: () => _isLoading ? null : _submit(),
      ),
      // ElevatedButton(
      //   onPressed: _isLoading ? null : _submit,
      //   style: ElevatedButton.styleFrom(
      //     backgroundColor: AppColors.primary,
      //     foregroundColor: Colors.white,
      //     disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
      //     shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(12),
      //     ),
      //   ),
      //   child: _isLoading
      //       ? const SizedBox(
      //           height: 20,
      //           width: 20,
      //           child: CircularProgressIndicator(
      //             strokeWidth: 2,
      //             valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      //           ),
      //         )
      //       : Text(
      //           'Add Operator',
      //           style: GoogleFonts.poppins(
      //             fontSize: 16,
      //             fontWeight: FontWeight.w600,
      //           ),
      //         ),
      // ),
    );
  }
}
