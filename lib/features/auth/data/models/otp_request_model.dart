class SendOtpRequest {
  final String phone;
  final String userType;

  const SendOtpRequest({required this.phone, this.userType = 'customer'});

  Map<String, dynamic> toJson() => {'phone': phone, 'userType': userType};
}

class SendOtpResponse {
  final String message;
  final int expiresIn;

  const SendOtpResponse({required this.message, required this.expiresIn});

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpResponse(
      message: json['message'] as String,
      expiresIn: json['expiresIn'] as int,
    );
  }
}

class VerifyOtpRequest {
  final String phone;
  final String code;
  final String userType;

  const VerifyOtpRequest({
    required this.phone,
    required this.code,
    this.userType = 'customer',
  });

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'code': code,
    'userType': userType,
  };
}

class VerifyOtpResponse {
  final String message;
  final String verificationToken;

  const VerifyOtpResponse({
    required this.message,
    required this.verificationToken,
  });

  factory VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    return VerifyOtpResponse(
      message: json['message'] as String,
      verificationToken: json['verificationToken'] as String,
    );
  }
}

class RegisterCustomerRequest {
  final String verificationToken;
  final String phone;
  final String password;
  final String? fullName;
  final String? email;

  const RegisterCustomerRequest({
    required this.verificationToken,
    required this.phone,
    required this.password,
    this.fullName,
    this.email,
  });

  Map<String, dynamic> toJson() => {
    'verificationToken': verificationToken,
    'phone': phone,
    'password': password,
    if (fullName != null) 'fullName': fullName,
    if (email != null) 'email': email,
  };
}

class RegisterVendorRequest {
  final String verificationToken;
  final String phone;
  final String password;
  final String businessName;
  final String categoryId;
  final String? fullName;
  final String? email;
  final String? commercialLicenseNo;

  const RegisterVendorRequest({
    required this.verificationToken,
    required this.phone,
    required this.password,
    required this.businessName,
    required this.categoryId,
    this.fullName,
    this.email,
    this.commercialLicenseNo,
  });

  Map<String, dynamic> toJson() => {
    'verificationToken': verificationToken,
    'phone': phone,
    'password': password,
    'businessName': businessName,
    'categoryId': categoryId,
    if (fullName != null) 'fullName': fullName,
    if (email != null) 'email': email,
    if (commercialLicenseNo != null) 'commercialLicenseNo': commercialLicenseNo,
  };
}

class LoginRequest {
  final String phone;
  final String password;

  const LoginRequest({required this.phone, required this.password});

  Map<String, dynamic> toJson() => {'phone': phone, 'password': password};
}

class RefreshTokenRequest {
  final String refreshToken;

  const RefreshTokenRequest({required this.refreshToken});

  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};
}

class LogoutRequest {
  final String refreshToken;

  const LogoutRequest({required this.refreshToken});

  Map<String, dynamic> toJson() => {'refreshToken': refreshToken};
}

class AuthResponse {
  final String accessToken;
  final String refreshToken;
  final Map<String, dynamic> user;
  final Map<String, dynamic>? vendor;

  const AuthResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    this.vendor,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      accessToken: json['accessToken'] as String,
      refreshToken: json['refreshToken'] as String,
      user: json['user'] as Map<String, dynamic>,
      vendor: json['vendor'] as Map<String, dynamic>?,
    );
  }
}

class RefreshTokenResponse {
  final String accessToken;

  const RefreshTokenResponse({required this.accessToken});

  factory RefreshTokenResponse.fromJson(Map<String, dynamic> json) {
    return RefreshTokenResponse(accessToken: json['accessToken'] as String);
  }
}
