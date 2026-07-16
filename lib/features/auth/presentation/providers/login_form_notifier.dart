import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'login_form_state.dart';

class LoginFormNotifier extends AutoDisposeNotifier<LoginFormState> {
  @override
  LoginFormState build() {
    return const LoginFormState();
  }

  void setPhone(String phone) {
    state = state.copyWith(phone: phone, isPhoneValid: _validatePhone(phone));
    _validateForm();
  }

  void setPassword(String password) {
    state = state.copyWith(
      password: password,
      isPasswordValid: _validatePassword(password),
    );
    _validateForm();
  }

  void togglePasswordVisibility() {
    state = state.copyWith(obscurePassword: !state.obscurePassword);
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setErrorMessage(String? message) {
    state = state.copyWith(errorMessage: message);
  }

  void reset() {
    state = const LoginFormState();
  }

  bool _validatePhone(String phone) {
    return phone.length >= 10;
  }

  bool _validatePassword(String password) {
    return password.length >= 8;
  }

  void _validateForm() {
    state = state.copyWith(
      isFormValid: state.isPhoneValid && state.isPasswordValid,
    );
  }
}

final loginFormNotifierProvider =
    AutoDisposeNotifierProvider<LoginFormNotifier, LoginFormState>(
      LoginFormNotifier.new,
    );
