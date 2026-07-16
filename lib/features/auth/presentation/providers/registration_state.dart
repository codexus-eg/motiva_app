class RegistrationState {
  final int currentStep;
  final String userType;
  final String phone;
  final String password;
  final String fullName;
  final String email;
  final String businessName;
  final String commercialLicenseNo;
  final String categoryId;
  final String? verificationToken;
  final bool isLoading;
  final String? errorMessage;

  const RegistrationState({
    this.currentStep = 0,
    this.userType = 'customer',
    this.phone = '',
    this.password = '',
    this.fullName = '',
    this.email = '',
    this.businessName = '',
    this.commercialLicenseNo = '',
    this.categoryId = '',
    this.verificationToken,
    this.isLoading = false,
    this.errorMessage,
  });

  RegistrationState copyWith({
    int? currentStep,
    String? userType,
    String? phone,
    String? password,
    String? fullName,
    String? email,
    String? businessName,
    String? commercialLicenseNo,
    String? categoryId,
    String? verificationToken,
    bool? isLoading,
    String? errorMessage,
  }) {
    return RegistrationState(
      currentStep: currentStep ?? this.currentStep,
      userType: userType ?? this.userType,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      businessName: businessName ?? this.businessName,
      commercialLicenseNo: commercialLicenseNo ?? this.commercialLicenseNo,
      categoryId: categoryId ?? this.categoryId,
      verificationToken: verificationToken ?? this.verificationToken,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegistrationState &&
          runtimeType == other.runtimeType &&
          currentStep == other.currentStep &&
          userType == other.userType &&
          phone == other.phone &&
          password == other.password &&
          fullName == other.fullName &&
          email == other.email &&
          businessName == other.businessName &&
          commercialLicenseNo == other.commercialLicenseNo &&
          categoryId == other.categoryId &&
          verificationToken == other.verificationToken &&
          isLoading == other.isLoading &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode => Object.hash(
    currentStep,
    userType,
    phone,
    password,
    fullName,
    email,
    businessName,
    commercialLicenseNo,
    categoryId,
    verificationToken,
    isLoading,
    errorMessage,
  );
}
