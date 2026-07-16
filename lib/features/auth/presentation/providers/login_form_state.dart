class LoginFormState {
  final String phone;
  final String password;
  final bool isPhoneValid;
  final bool isPasswordValid;
  final bool obscurePassword;
  final bool isLoading;
  final bool isFormValid;
  final String? errorMessage;

  const LoginFormState({
    this.phone = '',
    this.password = '',
    this.isPhoneValid = false,
    this.isPasswordValid = false,
    this.obscurePassword = false,
    this.isLoading = false,
    this.isFormValid = false,
    this.errorMessage,
  });

  LoginFormState copyWith({
    String? phone,
    String? password,
    bool? isPhoneValid,
    bool? isPasswordValid,
    bool? obscurePassword,
    bool? isLoading,
    bool? isFormValid,
    String? errorMessage,
  }) {
    return LoginFormState(
      phone: phone ?? this.phone,
      password: password ?? this.password,
      isPhoneValid: isPhoneValid ?? this.isPhoneValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      isLoading: isLoading ?? this.isLoading,
      isFormValid: isFormValid ?? this.isFormValid,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginFormState &&
          runtimeType == other.runtimeType &&
          phone == other.phone &&
          password == other.password &&
          isPhoneValid == other.isPhoneValid &&
          isPasswordValid == other.isPasswordValid &&
          obscurePassword == other.obscurePassword &&
          isLoading == other.isLoading &&
          isFormValid == other.isFormValid &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hash(
    phone,
    password,
    isPhoneValid,
    isPasswordValid,
    obscurePassword,
    isLoading,
    isFormValid,
    errorMessage,
  );
}
