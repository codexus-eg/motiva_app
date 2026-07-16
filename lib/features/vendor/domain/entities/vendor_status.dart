enum VendorStatus {
  open,
  busy,
  closed;

  String get apiValue {
    switch (this) {
      case VendorStatus.open:
        return 'open';
      case VendorStatus.busy:
        return 'busy';
      case VendorStatus.closed:
        return 'closed';
    }
  }

  static VendorStatus fromApiValue(String? value) {
    switch (value?.toLowerCase()) {
      case 'open':
        return VendorStatus.open;
      case 'busy':
        return VendorStatus.busy;
      case 'closed':
        return VendorStatus.closed;
      default:
        return VendorStatus.open;
    }
  }
}
