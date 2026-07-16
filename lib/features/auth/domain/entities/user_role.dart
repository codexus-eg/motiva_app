enum UserRole {
  customer,
  vendor,
  admin,
  operator;

  String toJson() => name;

  static UserRole fromJson(String value) {
    return UserRole.values.firstWhere(
      (e) => e.name == value,
      orElse: () => UserRole.customer,
    );
  }
}
