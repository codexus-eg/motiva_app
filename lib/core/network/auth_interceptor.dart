import 'package:dio/dio.dart';
import 'package:app/core/network/dio_client.dart';
import 'package:app/core/navigation/navigation_service.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:app/features/auth/presentation/screens/login/login_screen.dart';

class AuthInterceptor extends Interceptor {
  final AuthLocalDataSource _localDataSource;
  final DioClient _dioClient;

  AuthInterceptor(this._localDataSource, this._dioClient);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _localDataSource.getAccessToken();

    if (accessToken != null &&
        accessToken.isNotEmpty &&
        !_isPublicEndpoint(options.path)) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    final statusCode = err.response?.statusCode;

    if (statusCode == 401 && !_isPublicEndpoint(err.requestOptions.path)) {
      final refreshToken = await _localDataSource.getRefreshToken();

      if (refreshToken != null) {
        try {
          final newAccessToken = await _refreshToken(refreshToken);

          err.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';

          final response = await _dioClient.dio.fetch(err.requestOptions);
          handler.resolve(response);
          return;
        } catch (e, stackTrace) {
          AppLogger.error(
            'Token refresh in interceptor failed',
            error: e,
            stackTrace: stackTrace,
          );
        }
      }

      AppLogger.error(
        'Auth error - clearing session',
        error: err.message,
        stackTrace: StackTrace.current,
      );
      await _localDataSource.clearAll();
      _navigateToLogin();
      return;
    }

    handler.next(err);
  }

  void _navigateToLogin() {
    NavigationService.pushAndRemoveUntil(const LoginScreen());
  }

  Future<String> _refreshToken(String refreshToken) async {
    final response = await _dioClient.dio.post(
      '/api/auth/refresh-token',
      data: {'refreshToken': refreshToken},
    );

    final newAccessToken = response.data['accessToken'] as String?;
    if (newAccessToken == null) {
      throw Exception('Invalid token response: accessToken is null');
    }
    await _localDataSource.saveTokens(
      accessToken: newAccessToken,
      refreshToken: refreshToken,
    );

    return newAccessToken;
  }

  bool _isPublicEndpoint(String path) {
    const publicEndpoints = [
      '/api/auth/register/otp/send',
      '/api/auth/register/otp/verify',
      '/api/auth/register/customer/complete',
      '/api/auth/register/vendor/complete',
      '/api/auth/login',
      '/api/auth/admin/login',
      '/api/auth/refresh-token',
      '/api/public/',
    ];

    return publicEndpoints.any((endpoint) => path.contains(endpoint));
  }
}
