import 'package:app/core/theme/app_colors.dart';

import 'package:app/features/auth/presentation/providers/providers.dart';

import 'package:app/features/user_dashboard/presentation/screens/setting/verify_email_otp_screen.dart';

import 'package:app/i18n/strings.g.dart';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gap/gap.dart';

import 'package:google_fonts/google_fonts.dart';

import 'package:app/core/theme/spacing.dart';

class ChangeEmailScreen extends ConsumerStatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  ConsumerState<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends ConsumerState<ChangeEmailScreen> {
  static const Color _accentColor = AppColors.primary;

  final _emailController = TextEditingController();

  String? _emailError;

  bool _isLoading = false;

  String? _currentEmail;

  @override
  void initState() {
    super.initState();

    _emailController.addListener(_validateEmail);

    final authAsync = ref.read(authNotifierProvider);

    final authState = authAsync.valueOrNull;

    if (authState is AuthAuthenticated) {
      final currentEmail = authState.user.email;

      if (currentEmail != null && currentEmail.isNotEmpty) {
        _currentEmail = currentEmail;

        _emailController.text = currentEmail;
      }
    }
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  void _validateEmail() {
    final email = _emailController.text.trim();

    if (email.isEmpty) {
      setState(() => _emailError = null);

      return;
    }

    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

    if (!emailRegex.hasMatch(email)) {
      setState(
        () => _emailError = Translations.of(
          context,
        ).user_dashboard.settings.change_email.validation_error,
      );
    } else {
      setState(() => _emailError = null);
    }
  }

  bool get _isEmailValid {
    final email = _emailController.text.trim();

    if (email.isEmpty) return false;

    final emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

    return emailRegex.hasMatch(email);
  }

  Future<void> _handleConfirm() async {
    if (!_isEmailValid) {
      _validateEmail();

      return;
    }

    final enteredEmail = _emailController.text.trim();

    // Check if the entered email is the same as current email

    if (_currentEmail != null &&
        enteredEmail.toLowerCase() == _currentEmail!.toLowerCase()) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Email already in use')));

      return;
    }

    setState(() => _isLoading = true);

    try {
      final success = await ref
          .read(authNotifierProvider.notifier)
          .updateEmail(email: enteredEmail);

      if (mounted) {
        if (success) {
          Navigator.push(
            context,

            MaterialPageRoute(
              builder: (context) =>
                  VerifyEmailOtpScreen(email: _emailController.text.trim()),
            ),
          );
        } else {
          final authState = ref.read(authNotifierProvider);

          final errorMessage = authState.error?.toString() ?? '';

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                errorMessage.toLowerCase().contains('email') &&
                        (errorMessage.toLowerCase().contains('already') ||
                            errorMessage.toLowerCase().contains('exist'))
                    ? 'Email already in use'
                    : Translations.of(
                        context,
                      ).user_dashboard.settings.change_email.error,
              ),
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              e.toString().toLowerCase().contains('email') &&
                      (e.toString().toLowerCase().contains('already') ||
                          e.toString().toLowerCase().contains('exist'))
                  ? 'Email already in use'
                  : Translations.of(
                      context,
                    ).user_dashboard.settings.change_email.error,
            ),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
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
                    ).user_dashboard.settings.change_email.screen_title,

                    style: GoogleFonts.poppins(
                      fontSize: 26,

                      fontWeight: FontWeight.w600,

                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ],
              ),

              const Gap(AppSpacing.xl),

              _buildTextField(
                Translations.of(
                  context,
                ).user_dashboard.settings.change_email.field_hint,

                controller: _emailController,

                keyboardType: TextInputType.emailAddress,
              ),

              if (_emailError != null) ...[
                const Gap(AppSpacing.xs),

                Text(
                  _emailError!,

                  style: GoogleFonts.poppins(
                    fontSize: 12,

                    color: Colors.redAccent,
                  ),
                ),
              ],

              const Gap(AppSpacing.xl),

              SizedBox(
                width: double.infinity,

                height: 56,

                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleConfirm,

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
                              .change_email
                              .confirm_button_loading
                        : Translations.of(
                            context,
                          ).user_dashboard.settings.change_email.confirm_button,

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

  Widget _buildTextField(
    String hint, {

    TextEditingController? controller,

    TextInputType? keyboardType,

    bool obscureText = false,

    Widget? suffix,
  }) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 55,

      child: TextField(
        controller: controller,

        keyboardType: keyboardType,

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

            borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
          ),

          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,

            vertical: 15,
          ),

          suffixIcon: suffix,

          suffixIconColor: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}
