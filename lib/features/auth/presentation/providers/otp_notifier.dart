import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'otp_state.dart';

class OtpNotifier extends AutoDisposeNotifier<OtpState> {
  @override
  OtpState build() {
    return const OtpState(timer: 600);
  }

  void setCode(String code) {
    state = state.copyWith(code: code);
  }

  void setTimer(int seconds) {
    state = state.copyWith(timer: seconds, canResend: seconds <= 0);
  }

  void decrementTimer() {
    if (state.timer > 0) {
      state = state.copyWith(timer: state.timer - 1);
    } else {
      state = state.copyWith(canResend: true);
    }
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setVerified(bool verified) {
    state = state.copyWith(isVerified: verified);
  }

  void setErrorMessage(String? message) {
    state = state.copyWith(errorMessage: message);
  }

  void reset() {
    state = const OtpState(timer: 600);
  }

  void enableResend() {
    state = state.copyWith(canResend: true);
  }
}

final otpNotifierProvider = AutoDisposeNotifierProvider<OtpNotifier, OtpState>(
  OtpNotifier.new,
);
