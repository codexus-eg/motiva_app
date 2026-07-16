import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/features/auth/presentation/providers/providers.dart';
import 'package:app/features/auth/presentation/screens/register_customer/verify_phone_number_screen.dart';
import 'package:app/features/auth/presentation/screens/login/login_screen.dart';
import 'package:app/features/auth/presentation/widgets/auth_background.dart';
import 'package:app/features/auth/presentation/widgets/auth_card.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/inputs/custom_dropdown.dart';
import 'package:app/shared/ui/inputs/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:app/core/theme/spacing.dart';

class CustomerInfoScreen extends ConsumerStatefulWidget {
  const CustomerInfoScreen({super.key});

  @override
  ConsumerState<CustomerInfoScreen> createState() => _CustomerInfoScreenState();
}

class _CustomerInfoScreenState extends ConsumerState<CustomerInfoScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  String? _selectedCountry;
  String? _selectedCity;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _fullPhoneNumber = '';

  @override
  void initState() {
    super.initState();
    for (final c in [
      _nameController,
      _emailController,
      _phoneController,
      _passwordController,
      _confirmPasswordController,
    ]) {
      c.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final phone = _phoneController.text.trim();
    final password = _passwordController.text;
    final confirmPassword = _confirmPasswordController.text;

    if (name.isEmpty ||
        phone.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    // Validate phone contains only digits (no letters)
    final phoneDigitsOnly = phone.replaceAll(RegExp(r'[^\d]'), '');
    if (phoneDigitsOnly.length != phone.length) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Phone number must contain only digits')),
      );
      return;
    }

    if (_fullPhoneNumber.isEmpty && phone.isNotEmpty) {
      if (!phone.startsWith('+')) {
        _fullPhoneNumber = '+965$phone';
      } else {
        _fullPhoneNumber = phone;
      }
    }

    if (_fullPhoneNumber.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid phone number')),
      );
      return;
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }

    if (password.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password must be at least 8 characters')),
      );
      return;
    }

    final success = await ref
        .read(authNotifierProvider.notifier)
        .sendOtp(phone: _fullPhoneNumber, userType: 'customer');

    if (success && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyPhoneNumberScreen(
            phone: _fullPhoneNumber,
            password: password,
            fullName: name,
            email: email.isEmpty ? null : email,
          ),
        ),
      );
    } else if (mounted) {
      final authState = ref.read(authNotifierProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authState.error?.toString() ??
                'Failed to send OTP. Please try again.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;
    final t = Translations.of(context);

    return PopScope(
      canPop: true,
      child: AuthBackground(
        child: AuthCard(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  t.auth.get_started,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                    letterSpacing: 1.0,
                  ),
                  textAlign: TextAlign.center,
                ),
                Gap(AppSpacing.xl),
                CustomTextField(
                  hintText: t.auth.register_customer.name,
                  controller: _nameController,
                ),
                Gap(AppSpacing.md),
                CustomTextField(
                  hintText: t.auth.register_customer.email,
                  controller: _emailController,
                ),
                Gap(AppSpacing.md),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Semantics(
                      hint: SemanticLabels.phoneField,
                      textField: true,
                      child: IntlPhoneField(
                        controller: _phoneController,
                        initialCountryCode: 'KW',
                        disableLengthCheck: true,
                        dropdownIcon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.white,
                        ),
                        dropdownIconPosition: IconPosition.trailing,
                        flagsButtonPadding: EdgeInsets.zero,
                        flagsButtonMargin: EdgeInsets.zero,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: t.auth.phone_number,
                          hintStyle: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            color: Colors.white,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 10),
                          isDense: true,
                        ),
                        keyboardType: TextInputType.phone,
                        onChanged: (phone) {
                          _fullPhoneNumber = phone.completeNumber;
                        },
                        onCountryChanged: (country) {
                          final phoneText = _phoneController.text.trim();
                          if (phoneText.isNotEmpty) {
                            _fullPhoneNumber = '+${country.dialCode}$phoneText';
                          }
                        },
                      ),
                    ),
                  ),
                ),
                Gap(AppSpacing.md),
                CustomDropdown<String>(
                  hintText: t.auth.register_customer.country,
                  value: _selectedCountry,
                  items:
                      [
                            t.auth.register_customer.kuwait,
                            t.auth.register_customer.saudi_arabia,
                            t.auth.register_customer.uae,
                          ]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (val) => setState(() => _selectedCountry = val),
                ),
                Gap(AppSpacing.md),
                CustomDropdown<String>(
                  hintText: t.auth.register_customer.city,
                  value: _selectedCity,
                  items:
                      [
                            t.auth.register_customer.kuwait_city,
                            t.auth.register_customer.al_jahra,
                            t.auth.register_customer.hawalli,
                          ]
                          .map(
                            (e) => DropdownMenuItem(value: e, child: Text(e)),
                          )
                          .toList(),
                  onChanged: (val) => setState(() => _selectedCity = val),
                ),
                Gap(12),
                Semantics(
                  hint: SemanticLabels.passwordField,
                  textField: true,
                  child: CustomTextField(
                    hintText: t.auth.password,
                    controller: _passwordController,
                    isPassword: _obscurePassword,
                    suffixIcon: IconButton(
                      tooltip: SemanticLabels.togglePasswordVisibility,
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
                Gap(12),
                Semantics(
                  hint: SemanticLabels.passwordField,
                  textField: true,
                  child: CustomTextField(
                    hintText: t.auth.confirm_password,
                    controller: _confirmPasswordController,
                    isPassword: _obscureConfirmPassword,
                    suffixIcon: IconButton(
                      tooltip: SemanticLabels.togglePasswordVisibility,
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword = !_obscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                ),
                Gap(AppSpacing.xl),
                GradientButton(
                  text: isLoading ? t.auth.loading : t.auth.continue_button,
                  isPrimary: true,
                  onTap: isLoading ? null : _handleContinue,
                ),
                Gap(20),
                Semantics(
                  button: true,
                  onTapHint: 'Navigate to login',
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 16,
                          color: Colors.white,
                        ),
                        children: [
                          TextSpan(text: t.auth.already_have_account),
                          TextSpan(
                            text: t.auth.login_button,
                            style: TextStyle(
                              color: Color(0xFFE28C37),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
