class AppConstants {
  static const String appName = 'Motive';

  static const double defaultPadding = 16.0;
  static const double defaultBorderRadius = 10.0;
  static const double defaultBorderRadiusLarge = 20.0;

  static const List<String> countryOptions = [
    'Egypt',
    'Kuwait',
    'Saudi Arabia',
    'UAE',
  ];
}

class ApiConstants {
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'https://motiva-api-last.tajera.net',
    // defaultValue: 'http://localhost:3000',
  );

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  static const String apiPrefix = '/api';
}

class StorageKeys {
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String userData = 'user_data';
  static const String appMode = 'app_mode';
}
