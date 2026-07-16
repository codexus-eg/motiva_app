import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/features/auth/presentation/providers/providers.dart';
import 'package:app/features/auth/presentation/screens/login/login_screen.dart';
import 'package:app/features/auth/presentation/widgets/auth_background.dart';
import 'package:app/features/auth/presentation/widgets/auth_card.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/inputs/otp_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class VerifyPhoneNumberScreen extends ConsumerStatefulWidget {
  final String phone;
  final String password;
  final String? fullName;
  final String? email;

  const VerifyPhoneNumberScreen({
    super.key,
    required this.phone,
    required this.password,
    this.fullName,
    this.email,
  });

  @override
  ConsumerState<VerifyPhoneNumberScreen> createState() =>
      _VerifyPhoneNumberScreenState();
}

class _VerifyPhoneNumberScreenState
    extends ConsumerState<VerifyPhoneNumberScreen> {
  String _otpCode = '';
  bool _isLoading = false;
  int _timer = 600;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted && _timer > 0) {
        setState(() {
          _timer--;
        });
        _startTimer();
      } else if (_timer <= 0) {
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  Future<void> _handleVerify() async {
    if (_otpCode.length != 5) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the complete OTP code')),
      );
      return;
    }

    setState(() => _isLoading = true);

    final verificationToken = await ref
        .read(authNotifierProvider.notifier)
        .verifyOtp(phone: widget.phone, code: _otpCode, userType: 'customer');

    setState(() => _isLoading = false);

    if (verificationToken != null && mounted) {
      final success = await ref
          .read(authNotifierProvider.notifier)
          .registerCustomer(
            verificationToken: verificationToken,
            phone: widget.phone,
            password: widget.password,
            fullName: widget.fullName,
            email: widget.email,
          );

      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registration successful! Please login.'),
          ),
        );
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
          (route) => false,
        );
      } else if (mounted) {
        final authState = ref.read(authNotifierProvider);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              authState.error?.toString() ??
                  'Registration failed. Please try again.',
            ),
          ),
        );
      }
    } else if (mounted) {
      final authState = ref.read(authNotifierProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authState.error?.toString() ??
                'OTP verification failed. Please try again.',
          ),
        ),
      );
    }
  }

  Future<void> _handleResend() async {
    if (!_canResend) return;

    setState(() {
      _timer = 600;
      _canResend = false;
      _otpCode = '';
    });

    final success = await ref
        .read(authNotifierProvider.notifier)
        .sendOtp(phone: widget.phone, userType: 'customer');

    if (success) {
      _startTimer();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('OTP sent successfully')));
      }
    } else if (mounted) {
      final authState = ref.read(authNotifierProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authState.error?.toString() ??
                'Failed to resend OTP. Please try again.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return PopScope(
      canPop: true,
      child: AuthBackground(
        child: AuthCard(
          child: Column(
            children: [
              Text(
                t.auth.verify.title,
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                  letterSpacing: 1.0,
                ),
                textAlign: TextAlign.center,
              ),
              Gap(AppSpacing.md),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: t.auth.verify.description,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                  children: [
                    TextSpan(
                      text: widget.phone,
                      style: const TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(30),
              Semantics(
                hint: SemanticLabels.otpField,
                textField: true,
                child: OtpFields(
                  onCompleted: (code) {
                    setState(() => _otpCode = code);
                  },
                ),
              ),
              Gap(AppSpacing.lg),
              GradientButton(
                text: _isLoading ? t.auth.verify.loading : t.auth.verify.button,
                isPrimary: true,
                onTap: _isLoading ? null : _handleVerify,
              ),
              const SizedBox(height: 20),
              Semantics(
                button: true,
                onTapHint: SemanticLabels.resendCodeButton,
                child: GestureDetector(
                  onTap: _canResend ? _handleResend : null,
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 16,
                        color: Colors.white,
                      ),
                      children: [
                        TextSpan(
                          text: _canResend
                              ? t.auth.verify.did_not_receive_code
                              : "${t.auth.verify.resend_in} "
                                    "${_timer ~/ 60}:"
                                    "${(_timer % 60).toString().padLeft(2, '0')}",
                        ),
                        if (_canResend)
                          TextSpan(
                            text: t.auth.verify.resend,
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
    );
  }
}
