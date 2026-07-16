import 'package:app/features/auth/presentation/providers/providers.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  static const Color _accentColor = Color(0xFFDC8735);

  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  String? _currentPasswordError;
  String? _newPasswordError;
  String? _confirmPasswordError;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _currentPasswordController.addListener(_validateCurrentPassword);
    _newPasswordController.addListener(_validateNewPassword);
    _confirmPasswordController.addListener(_validateConfirmPassword);
  }

  @override
  void dispose() {
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateCurrentPassword() {
    final value = _currentPasswordController.text;
    if (value.isEmpty) {
      setState(
        () => _currentPasswordError = Translations.of(
          context,
        ).user_dashboard.settings.change_password.validation.current_required,
      );
    } else {
      setState(() => _currentPasswordError = null);
    }
  }

  void _validateNewPassword() {
    final value = _newPasswordController.text;
    final currentPass = _currentPasswordController.text;
    if (value.isEmpty) {
      setState(() => _newPasswordError = null);
      return;
    }
    if (value == currentPass) {
      setState(
        () => _newPasswordError = "new password can't be the same as the old password",
      );
      return;
    }
    if (value.length < 8) {
      setState(
        () => _newPasswordError = Translations.of(
          context,
        ).user_dashboard.settings.change_password.validation.min_length,
      );
    } else {
      setState(() => _newPasswordError = null);
    }
    _validateConfirmPassword();
  }

  void _validateConfirmPassword() {
    final confirm = _confirmPasswordController.text;
    final newPass = _newPasswordController.text;
    if (confirm.isEmpty) {
      setState(() => _confirmPasswordError = null);
      return;
    }
    if (confirm != newPass) {
      setState(
        () => _confirmPasswordError = Translations.of(
          context,
        ).user_dashboard.settings.change_password.validation.match,
      );
    } else {
      setState(() => _confirmPasswordError = null);
    }
  }

  bool get _isFormValid {
    final current = _currentPasswordController.text;
    final newPass = _newPasswordController.text;
    final confirm = _confirmPasswordController.text;

    return current.isNotEmpty &&
        newPass.length >= 8 &&
        confirm == newPass &&
        _currentPasswordError == null &&
        _newPasswordError == null &&
        _confirmPasswordError == null;
  }

  Future<void> _handleChangePassword() async {
    _validateCurrentPassword();
    _validateNewPassword();
    _validateConfirmPassword();

    if (!_isFormValid) return;

    setState(() => _isLoading = true);

    final success = await ref
        .read(authNotifierProvider.notifier)
        .changePassword(
          currentPassword: _currentPasswordController.text,
          newPassword: _newPasswordController.text,
        );

    setState(() => _isLoading = false);

    if (mounted) {
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              Translations.of(
                context,
              ).user_dashboard.settings.change_password.success,
            ),
          ),
        );
      } else {
        final authState = ref.read(authNotifierProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              authState.error?.toString() ??
                  Translations.of(
                    context,
                  ).user_dashboard.settings.change_password.error,
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    color: _accentColor,
                    onPressed: () => Navigator.pop(context),
                    splashRadius: 18,
                  ),
                  const Gap(AppSpacing.md),
                  Text(
                    Translations.of(
                      context,
                    ).user_dashboard.settings.change_password.screen_title,
                    style: GoogleFonts.poppins(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),
              const Gap(AppSpacing.xl),
              _buildPasswordField(
                Translations.of(context)
                    .user_dashboard
                    .settings
                    .change_password
                    .fields
                    .current_password,
                controller: _currentPasswordController,
                obscureText: _obscureCurrent,
                onToggleObscure: () =>
                    setState(() => _obscureCurrent = !_obscureCurrent),
                errorText: _currentPasswordError,
              ),
              const Gap(AppSpacing.md),
              _buildPasswordField(
                Translations.of(
                  context,
                ).user_dashboard.settings.change_password.fields.new_password,
                controller: _newPasswordController,
                obscureText: _obscureNew,
                onToggleObscure: () =>
                    setState(() => _obscureNew = !_obscureNew),
                errorText: _newPasswordError,
              ),
              const Gap(AppSpacing.md),
              _buildPasswordField(
                Translations.of(context)
                    .user_dashboard
                    .settings
                    .change_password
                    .fields
                    .confirm_password,
                controller: _confirmPasswordController,
                obscureText: _obscureConfirm,
                onToggleObscure: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
                errorText: _confirmPasswordError,
              ),
              const Gap(AppSpacing.xl),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleChangePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _accentColor,
                    disabledBackgroundColor: _accentColor.withValues(
                      alpha: 0.4,
                    ),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _isLoading
                        ? Translations.of(context)
                              .user_dashboard
                              .settings
                              .change_password
                              .button_loading
                        : Translations.of(
                            context,
                          ).user_dashboard.settings.change_password.button,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(
    String hint, {
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback onToggleObscure,
    String? errorText,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 55,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: theme.colorScheme.onSurface,
            ),
            cursorColor: theme.colorScheme.onSurface,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.poppins(
                fontSize: 18,
                color: theme.colorScheme.onSurface.withOpacity(0.5),
              ),
              filled: true,
              fillColor: theme.colorScheme.primaryContainer,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: _accentColor, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(
                  color: Colors.redAccent,
                  width: 1.5,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 15,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  obscureText ? Icons.visibility_off : Icons.visibility,
                  color: theme.colorScheme.onSurface.withOpacity(0.5),
                  size: 22,
                ),
                onPressed: onToggleObscure,
              ),
              suffixIconColor: theme.colorScheme.onSurface,
            ),
          ),
        ),
        if (errorText != null) ...[
          const Gap(AppSpacing.xs),
          Text(
            errorText,
            style: GoogleFonts.poppins(fontSize: 12, color: Colors.redAccent),
          ),
        ],
      ],
    );
  }
}
