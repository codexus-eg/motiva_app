class OtpState {
  final String code;
  final int timer;
  final bool canResend;
  final bool isLoading;
  final bool isVerified;
  final String? errorMessage;

  const OtpState({
    this.code = '',
    this.timer = 0,
    this.canResend = false,
    this.isLoading = false,
    this.isVerified = false,
    this.errorMessage,
  });

  OtpState copyWith({
    String? code,
    int? timer,
    bool? canResend,
    bool? isLoading,
    bool? isVerified,
    String? errorMessage,
  }) {
    return OtpState(
      code: code ?? this.code,
      timer: timer ?? this.timer,
      canResend: canResend ?? this.canResend,
      isLoading: isLoading ?? this.isLoading,
      isVerified: isVerified ?? this.isVerified,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OtpState &&
          runtimeType == other.runtimeType &&
          code == other.code &&
          timer == other.timer &&
          canResend == other.canResend &&
          isLoading == other.isLoading &&
          isVerified == other.isVerified &&
          errorMessage == other.errorMessage;

  @override
  int get hashCode =>
      Object.hash(code, timer, canResend, isLoading, isVerified, errorMessage);
}
