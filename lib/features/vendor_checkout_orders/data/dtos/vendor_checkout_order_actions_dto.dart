class UpdateCheckoutOrderStatusDto {
  final String status;

  const UpdateCheckoutOrderStatusDto({required this.status});

  Map<String, dynamic> toJson() => {'status': status};
}


