import 'package:app/features/auth/presentation/providers/providers.dart';
import 'package:app/features/auth/presentation/screens/register_as/register_as_screen.dart';
import 'package:app/features/auth/presentation/screens/splash/auth_splash_screen.dart';
import 'package:app/features/auth/presentation/widgets/auth_background.dart';
import 'package:app/features/auth/presentation/widgets/auth_card.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/inputs/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final String? errorMessage;

  const LoginScreen({super.key, this.errorMessage});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  String _fullPhoneNumber = '';

  @override
  void initState() {
    super.initState();
    // Show error message if provided
    if (widget.errorMessage != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _showErrorMessage(widget.errorMessage!);
        }
      });
    }

    // Remove leading zeros from phone number
    _phoneController.addListener(() {
      final text = _phoneController.text;
      if (text.startsWith('0')) {
        _phoneController.text = text.replaceFirst(RegExp(r'^0+'), '');
        _phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: _phoneController.text.length),
        );
      }
    });

    for (final c in [_phoneController, _passwordController]) {
      c.addListener(() => setState(() {}));
    }
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
    if (password.length < 6) return 'Password must be at least 6 characters';
    return null;
  }

  void _showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1F2128),
        title: const Text(
          'Registration Required',
          style: TextStyle(color: Colors.white),
        ),
        content: Text(message, style: const TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Color(0xFFE28C37))),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final phone = _phoneController.text.trim();
    final password = _passwordController.text;

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

    final success = await ref
        .read(authNotifierProvider.notifier)
        .login(phone: _fullPhoneNumber, password: password);

    if (success && mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const AuthSplashScreen()),
        (route) => false,
      );
    } else if (mounted) {
      final authState = ref.read(authNotifierProvider);
      final errorMessage =
          authState.error?.toString() ?? 'Login failed. Please try again.';

      String displayMessage = errorMessage;
      if (errorMessage.toLowerCase().contains('inactive') ||
          errorMessage.toLowerCase().contains('pending')) {
        displayMessage =
            'Your account is pending admin approval. Please contact support.';
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(displayMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final isLoading = authState.isLoading;
    final t = Translations.of(context);

    return AuthBackground(
      child: AuthCard(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              Text(
                t.auth.login.title.toUpperCase(),
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
                            textAlign:
                                Directionality.of(context) == TextDirection.rtl
                                ? TextAlign.right
                                : TextAlign.left,
                            dropdownIcon: const Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                            dropdownIconPosition: IconPosition.trailing,
                            flagsButtonPadding: EdgeInsets.zero,
                            flagsButtonMargin: EdgeInsets.zero,
                            dropdownTextStyle: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
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
                                _fullPhoneNumber =
                                    '+${country.dialCode}$phoneText';
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
              const SizedBox(height: 40),
              GradientButton(
                text: isLoading
                    ? t.auth.login.loading.toUpperCase()
                    : t.auth.login.title.toUpperCase(),
                isPrimary: true,
                onTap: isLoading ? () {} : _handleLogin,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterAsScreen(),
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
                      TextSpan(text: t.auth.login.do_not_have_account),
                      TextSpan(
                        text: t.auth.login.create_account,
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
    );
  }
}
