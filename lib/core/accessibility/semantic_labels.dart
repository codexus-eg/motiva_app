/// Centralized semantic labels for accessibility across the app.
/// All labels are in English to ensure consistent screen-reader announcements.
class SemanticLabels {
  SemanticLabels._();

  // Navigation
  static const String backButton = 'Back';
  static const String backHomeButton = 'Back to Home';
  static const String closeButton = 'Close';
  static const String settingsButton = 'Settings';
  static const String menuButton = 'Menu';

  // Auth
  static const String phoneField = 'Phone number';
  static const String passwordField = 'Password';
  static const String togglePasswordVisibility = 'Toggle password visibility';
  static const String otpField = 'One time password code';
  static const String resendCodeButton = 'Resend code';

  // Images
  static const String serviceImage = 'Service image';
  static const String categoryIcon = 'Category icon';
  static const String userAvatar = 'User avatar';
  static const String servicePlaceholder = 'Service placeholder image';

  // Status
  static const String statusBadgePrefix = 'Order status:';
  static const String scheduledBadge = 'Scheduled order';
  static const String asapBadge = 'ASAP order';

  // Forms
  static const String searchField = 'Search';
  static const String uploadImageButton = 'Upload image';
  static const String selectCategoryButton = 'Select category';
  static const String addAttributeButton = 'Add attribute';

  // Operator / Vendor orders
  static const String orderListTab = 'Orders list';
  static const String filterOrdersButton = 'Filter orders';
  static const String orderActionsMenu = 'Order actions';

  // Service creation
  static const String serviceNameField = 'Service name';
  static const String serviceDescriptionField = 'Service description';
  static const String servicePriceField = 'Service price';
  static const String serviceDurationField = 'Service duration';
}
