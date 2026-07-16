import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'registration_state.dart';

class RegistrationNotifier extends AutoDisposeNotifier<RegistrationState> {
  @override
  RegistrationState build() {
    return const RegistrationState();
  }

  void setUserType(String userType) {
    state = state.copyWith(userType: userType);
  }

  void setPhone(String phone) {
    state = state.copyWith(phone: phone);
  }

  void setPassword(String password) {
    state = state.copyWith(password: password);
  }

  void setFullName(String fullName) {
    state = state.copyWith(fullName: fullName);
  }

  void setEmail(String email) {
    state = state.copyWith(email: email);
  }

  void setBusinessName(String businessName) {
    state = state.copyWith(businessName: businessName);
  }

  void setCommercialLicenseNo(String? commercialLicenseNo) {
    state = state.copyWith(commercialLicenseNo: commercialLicenseNo ?? '');
  }

  void setCategoryId(String categoryId) {
    state = state.copyWith(categoryId: categoryId);
  }

  void setVerificationToken(String? token) {
    state = state.copyWith(verificationToken: token);
  }

  void nextStep() {
    state = state.copyWith(currentStep: state.currentStep + 1);
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void setLoading(bool loading) {
    state = state.copyWith(isLoading: loading);
  }

  void setErrorMessage(String? message) {
    state = state.copyWith(errorMessage: message);
  }

  void reset() {
    state = const RegistrationState();
  }
}

final registrationNotifierProvider =
    AutoDisposeNotifierProvider<RegistrationNotifier, RegistrationState>(
      RegistrationNotifier.new,
    );
