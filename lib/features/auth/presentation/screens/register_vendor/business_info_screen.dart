import 'package:app/features/auth/presentation/providers/providers.dart';
import 'package:app/features/auth/presentation/screens/login/login_screen.dart';
import 'package:app/features/auth/presentation/screens/register_vendor/verify_vendor_phone_screen.dart';
import 'package:app/features/auth/presentation/widgets/auth_background.dart';
import 'package:app/features/auth/presentation/widgets/auth_card.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/inputs/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class BusinessInfoScreen extends ConsumerStatefulWidget {
  const BusinessInfoScreen({super.key});

  @override
  ConsumerState<BusinessInfoScreen> createState() => _BusinessInfoScreenState();
}

class _BusinessInfoScreenState extends ConsumerState<BusinessInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _businessNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _representativeNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _commercialLicenseController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  String _fullPhoneNumber = '';

  @override
  void initState() {
    super.initState();
    for (final c in [
      _businessNameController,
      _phoneController,
      _passwordController,
      _confirmPasswordController,
    ]) {
      c.addListener(() => setState(() {}));
    }
  }

  @override
  void dispose() {
    _businessNameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _representativeNameController.dispose();
    _emailController.dispose();
    _commercialLicenseController.dispose();
    super.dispose();
  }

  String? _businessNameValidator(String? value) {
    if (value == null || value.trim().isEmpty) return 'Business name is required';
    return null;
  }

  String? _phoneValidator(String? value) {
    final phone = value?.trim() ?? '';
    if (phone.isEmpty) return 'Phone number is required';
    if (phone.length < 8) return 'Phone number must be at least 8 digits';
    return null;
  }

  String? _passwordValidator(String? value) {
    final password = value ?? '';
    if (password.isEmpty) return 'Password is required';
    if (password.length < 8) return 'Password must be at least 8 characters';
    return null;
  }

  String? _confirmPasswordValidator(String? value) {
    if (value != _passwordController.text) return 'Passwords do not match';
    return null;
  }

  String? _emailValidator(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return null;
    final emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w+$');
    if (!emailRegex.hasMatch(email)) return 'Please enter a valid email';
    return null;
  }

  Future<void> _handleContinue() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final businessName = _businessNameController.text.trim();
    final password = _passwordController.text;
    final representativeName = _representativeNameController.text.trim();
    final email = _emailController.text.trim();
    final commercialLicenseNo = _commercialLicenseController.text.trim();

    if (_fullPhoneNumber.isEmpty && _phoneController.text.trim().isNotEmpty) {
      final phoneText = _phoneController.text.trim();
      if (!phoneText.startsWith('+')) {
        _fullPhoneNumber = '+965$phoneText';
      } else {
        _fullPhoneNumber = phoneText;
      }
    }

    if (_fullPhoneNumber.isEmpty) {
      _formKey.currentState!.validate();
      return;
    }

    ref
        .read(registrationNotifierProvider.notifier)
        .setBusinessName(businessName);
    ref.read(registrationNotifierProvider.notifier).setPhone(_fullPhoneNumber);
    ref.read(registrationNotifierProvider.notifier).setPassword(password);
    if (representativeName.isNotEmpty) {
      ref
          .read(registrationNotifierProvider.notifier)
          .setFullName(representativeName);
    }
    if (email.isNotEmpty) {
      ref.read(registrationNotifierProvider.notifier).setEmail(email);
    }

    final success = await ref
        .read(authNotifierProvider.notifier)
        .sendOtp(phone: _fullPhoneNumber, userType: 'vendor');

    if (success && mounted) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VerifyVendorPhoneScreen(
            phone: _fullPhoneNumber,
            password: password,
            businessName: businessName,
            fullName: representativeName.isEmpty ? null : representativeName,
            email: email.isEmpty ? null : email,
            commercialLicenseNo: commercialLicenseNo.isEmpty
                ? null
                : commercialLicenseNo,
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

    return AuthBackground(
      child: AuthCard(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                const SizedBox(height: 40),
                CustomTextField(
                  hintText: t.auth.register_vendor.business_name,
                  controller: _businessNameController,
                  validator: _businessNameValidator,
                ),
                const SizedBox(height: 12),
                FormField<String>(
                  initialValue: '',
                  validator: (value) => _phoneValidator(_phoneController.text),
                  builder: (field) {
                    final hasError = field.hasError && field.errorText != null;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 55,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(10),
                            border: hasError
                                ? Border.all(color: Colors.redAccent)
                                : null,
                          ),
                          child: Center(
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
                              style: const TextStyle(
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
                                field.didChange(_phoneController.text);
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
                        if (hasError)
                          Padding(
                            padding: const EdgeInsets.only(left: 4, top: 6),
                            child: Text(
                              field.errorText!,
                              style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 12,
                                color: Colors.redAccent,
                              ),
                            ),
                          ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: t.auth.password,
                  controller: _passwordController,
                  isPassword: _obscurePassword,
                  validator: _passwordValidator,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: t.auth.confirm_password,
                  controller: _confirmPasswordController,
                  isPassword: _obscureConfirmPassword,
                  validator: _confirmPasswordValidator,
                  suffixIcon: IconButton(
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
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: t.auth.register_vendor.representative_name,
                  controller: _representativeNameController,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: t.auth.register_vendor.business_email,
                  controller: _emailController,
                  validator: _emailValidator,
                ),
                const SizedBox(height: 12),
                CustomTextField(
                  hintText: t.auth.register_vendor.commercial_license,
                  controller: _commercialLicenseController,
                ),
                const SizedBox(height: 40),
                GradientButton(
                  text: isLoading
                      ? t.auth.loading
                      : t.auth.continue_button,
                  isPrimary: true,
                  onTap: isLoading ? null : _handleContinue,
                ),
              const SizedBox(height: 20),
              GestureDetector(
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
            ],
          ),
        ),
      ),
    ));
  }
}
