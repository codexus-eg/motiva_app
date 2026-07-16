import 'dart:async';

import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/features/auth/presentation/providers/providers.dart';
import 'package:app/features/auth/presentation/widgets/auth_background.dart';
import 'package:app/features/auth/presentation/widgets/auth_card.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/inputs/otp_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class VerifyEmailOtpScreen extends ConsumerStatefulWidget {
  final String email;

  const VerifyEmailOtpScreen({super.key, required this.email});

  @override
  ConsumerState<VerifyEmailOtpScreen> createState() =>
      _VerifyEmailOtpScreenState();
}

class _VerifyEmailOtpScreenState extends ConsumerState<VerifyEmailOtpScreen> {
  String _otpCode = '';
  String? _otpError;
  bool _isLoading = false;
  int _timer = 600;
  bool _canResend = false;
  Timer? _countdownTimer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void dispose() {
    _countdownTimer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _countdownTimer?.cancel();
    _countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (_timer > 0) {
        setState(() {
          _timer--;
        });
      } else {
        timer.cancel();
        setState(() {
          _canResend = true;
        });
      }
    });
  }

  Future<void> _handleVerify() async {
    if (_otpCode.length != 5) {
      setState(
        () => _otpError = Translations.of(
          context,
        ).user_dashboard.settings.verify_email_otp.otp_error,
      );
      return;
    }
    setState(() {
      _otpError = null;
      _isLoading = true;
    });

    final success = await ref
        .read(authNotifierProvider.notifier)
        .updateEmail(email: widget.email);

    setState(() => _isLoading = false);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            Translations.of(
              context,
            ).user_dashboard.settings.change_email.success,
          ),
        ),
      );
      Navigator.popUntil(context, (route) => route.isFirst);
    } else if (mounted) {
      final authState = ref.read(authNotifierProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authState.error?.toString() ??
                Translations.of(
                  context,
                ).user_dashboard.settings.change_email.error,
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

    _startTimer();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            Translations.of(
              context,
            ).user_dashboard.settings.verify_email_otp.otp_sent,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      child: AuthCard(
        child: Column(
          children: [
            Text(
              Translations.of(
                context,
              ).user_dashboard.settings.verify_email_otp.title,
              style: const TextStyle(
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
                text: Translations.of(
                  context,
                ).user_dashboard.settings.verify_email_otp.sent_code,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white70,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: widget.email,
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(30),
            Semantics(
              hint: SemanticLabels.otpField,
              textField: true,
              child: OtpFields(
                onCompleted: (code) {
                  setState(() => _otpCode = code);
                },
              ),
            ),
            if (_otpError != null) ...[
              const Gap(AppSpacing.sm),
              Text(
                _otpError!,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: Colors.redAccent,
                ),
              ),
            ],
            Gap(AppSpacing.lg),
            GradientButton(
              text: _isLoading
                  ? Translations.of(context)
                        .user_dashboard
                        .settings
                        .verify_email_otp
                        .verify_button_loading
                  : Translations.of(
                      context,
                    ).user_dashboard.settings.verify_email_otp.verify_button,
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
                            ? Translations.of(context)
                                  .user_dashboard
                                  .settings
                                  .verify_email_otp
                                  .resend
                                  .did_not_receive
                            : Translations.of(context)
                                  .user_dashboard
                                  .settings
                                  .verify_email_otp
                                  .resend
                                  .resend_in
                                  .replaceAll(
                                    '{time}',
                                    '${_timer ~/ 60}:${(_timer % 60).toString().padLeft(2, '0')}',
                                  ),
                      ),
                      if (_canResend)
                        TextSpan(
                          text: Translations.of(context)
                              .user_dashboard
                              .settings
                              .verify_email_otp
                              .resend
                              .resend_button,
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
    );
  }
}
