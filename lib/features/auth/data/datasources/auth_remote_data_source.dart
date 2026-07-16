import 'package:app/core/network/dio_client.dart';
import 'package:app/core/network/dio_error_handler.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/auth/data/models/otp_request_model.dart';
import 'package:app/features/auth/data/exceptions/auth_exceptions.dart';
import 'package:dio/dio.dart';

abstract class AuthRemoteDataSource {
  Future<SendOtpResponse> sendOtp(SendOtpRequest request);
  Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest request);
  Future<AuthResponse> registerCustomer(RegisterCustomerRequest request);
  Future<AuthResponse> registerVendor(RegisterVendorRequest request);
  Future<AuthResponse> login(LoginRequest request);
  Future<RefreshTokenResponse> refreshToken(RefreshTokenRequest request);
  Future<void> logout(LogoutRequest request);
  Future<Map<String, dynamic>> getCurrentUser();
  Future<Map<String, dynamic>> updateProfile({String? email});
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });
  Future<void> deleteAccount();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final DioClient _dioClient;

  AuthRemoteDataSourceImpl(this._dioClient);

  @override
  Future<SendOtpResponse> sendOtp(SendOtpRequest request) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/auth/register/otp/send',
        data: request.toJson(),
      );
      return SendOtpResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('sendOtp failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('sendOtp failed', error: e, stackTrace: stackTrace);
      throw AuthException.unknown(e.toString());
    }
  }

  @override
  Future<VerifyOtpResponse> verifyOtp(VerifyOtpRequest request) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/auth/register/otp/verify',
        data: request.toJson(),
      );
      return VerifyOtpResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('verifyOtp failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('verifyOtp failed', error: e, stackTrace: stackTrace);
      throw AuthException.unknown(e.toString());
    }
  }

  @override
  Future<AuthResponse> registerCustomer(RegisterCustomerRequest request) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/auth/register/customer/complete',
        data: request.toJson(),
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'registerCustomer failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'registerCustomer failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw AuthException.unknown(e.toString());
    }
  }

  @override
  Future<AuthResponse> registerVendor(RegisterVendorRequest request) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/auth/register/vendor/complete',
        data: request.toJson(),
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'registerVendor failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'registerVendor failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw AuthException.unknown(e.toString());
    }
  }

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/auth/login',
        data: request.toJson(),
      );
      return AuthResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('login failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('login failed', error: e, stackTrace: stackTrace);
      throw AuthException.unknown(e.toString());
    }
  }

  @override
  Future<RefreshTokenResponse> refreshToken(RefreshTokenRequest request) async {
    try {
      final response = await _dioClient.dio.post(
        '/api/auth/refresh-token',
        data: request.toJson(),
      );
      return RefreshTokenResponse.fromJson(response.data);
    } on DioException catch (e, stackTrace) {
      AppLogger.error('refreshToken failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('refreshToken failed', error: e, stackTrace: stackTrace);
      throw AuthException.unknown(e.toString());
    }
  }

  @override
  Future<void> logout(LogoutRequest request) async {
    try {
      await _dioClient.dio.post('/api/auth/logout', data: request.toJson());
    } on DioException catch (e, stackTrace) {
      AppLogger.error('logout failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('logout failed', error: e, stackTrace: stackTrace);
      throw AuthException.unknown(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> getCurrentUser() async {
    try {
      final response = await _dioClient.dio.get('/api/users/profile');
      return response.data;
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'getCurrentUser failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'getCurrentUser failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw AuthException.unknown(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>> updateProfile({String? email}) async {
    try {
      final response = await _dioClient.dio.put(
        '/api/users/profile',
        data: {'email': email},
      );
      return response.data;
    } on DioException catch (e, stackTrace) {
      AppLogger.error('updateProfile failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('updateProfile failed', error: e, stackTrace: stackTrace);
      throw AuthException.unknown(e.toString());
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _dioClient.dio.patch(
        '/api/users/me/password',
        data: {'currentPassword': currentPassword, 'newPassword': newPassword},
      );
    } on DioException catch (e, stackTrace) {
      AppLogger.error(
        'changePassword failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error(
        'changePassword failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw AuthException.unknown(e.toString());
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await _dioClient.dio.delete('/api/users/profile');
    } on DioException catch (e, stackTrace) {
      AppLogger.error('deleteAccount failed', error: e, stackTrace: stackTrace);
      throw _handleDioError(e);
    } on Exception catch (e, stackTrace) {
      AppLogger.error('deleteAccount failed', error: e, stackTrace: stackTrace);
      throw AuthException.unknown(e.toString());
    }
  }

  AuthException _handleDioError(DioException e) {
    final errorInfo = DioErrorHandler.handle(e);
    final message = errorInfo.message;

    // Network errors
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.connectionError) {
      return AuthException.network('Connection timeout');
    }

    switch (errorInfo.statusCode) {
      case 401:
        if (message.toLowerCase().contains('inactive') ||
            message.toLowerCase().contains('pending')) {
          return AuthException.accountInactive(message);
        }
        return AuthException.unauthorized(message);
      case 409:
        return AuthException.phoneExists(message);
      case 429:
        return AuthException(message);
      case 400:
        return AuthException.validation(message);
      case 500:
        return AuthException.serverError(message);
      default:
        return AuthException.unknown(message);
    }
  }
}
