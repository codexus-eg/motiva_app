class VoucherResponse {
  final double discountAmount;
  final double newTotal;
  final String message;

  const VoucherResponse({
    required this.discountAmount,
    required this.newTotal,
    required this.message,
  });
}
