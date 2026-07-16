import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:app/features/auth/data/exceptions/auth_exceptions.dart';
import 'package:app/features/auth/data/models/otp_request_model.dart';
import 'package:app/features/auth/data/models/user_model.dart';
import 'package:app/features/auth/data/models/vendor_model.dart';
import 'package:app/features/auth/domain/entities/auth_result.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/domain/entities/vendor.dart';
import 'package:app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;

  AuthRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<void> sendOtp({
    required String phone,
    String userType = 'customer',
  }) async {
    try {
      await _remoteDataSource.sendOtp(
        SendOtpRequest(phone: phone, userType: userType),
      );
    } on AuthException {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('sendOtp failed', error: e, stackTrace: stackTrace);
      throw AuthException.network(e.toString());
    }
  }

  @override
  Future<String> verifyOtp({
    required String phone,
    required String code,
    String userType = 'customer',
  }) async {
    try {
      final response = await _remoteDataSource.verifyOtp(
        VerifyOtpRequest(phone: phone, code: code, userType: userType),
      );
      return response.verificationToken;
    } on AuthException {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('verifyOtp failed', error: e, stackTrace: stackTrace);
      throw AuthException.network(e.toString());
    }
  }

  @override
  Future<AuthResult> registerCustomer({
    required String verificationToken,
    required String phone,
    required String password,
    String? fullName,
    String? email,
  }) async {
    try {
      final response = await _remoteDataSource.registerCustomer(
        RegisterCustomerRequest(
          verificationToken: verificationToken,
          phone: phone,
          password: password,
          fullName: fullName,
          email: email,
        ),
      );

      await _saveAuthData(
        response.accessToken,
        response.refreshToken,
        response.user,
      );

      return AuthSuccess(
        user: UserModel.fromJson(response.user).user,
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
    } on AuthException {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error(
        'registerCustomer failed',
        error: e,
        stackTrace: stackTrace,
      );
      return AuthFailure(message: e.toString());
    }
  }

  @override
  Future<AuthResult> registerVendor({
    required String verificationToken,
    required String phone,
    required String password,
    required String businessName,
    String? fullName,
    String? email,
    String? commercialLicenseNo,
    required String categoryId,
  }) async {
    try {
      final response = await _remoteDataSource.registerVendor(
        RegisterVendorRequest(
          verificationToken: verificationToken,
          phone: phone,
          password: password,
          businessName: businessName,
          categoryId: categoryId,
          fullName: fullName,
          email: email,
          commercialLicenseNo: commercialLicenseNo,
        ),
      );

      await _saveAuthData(
        response.accessToken,
        response.refreshToken,
        response.user,
      );

      Vendor? vendor;
      if (response.vendor != null) {
        vendor = VendorModel.fromJson(response.vendor!).vendor;
      }

      return AuthSuccess(
        user: UserModel.fromJson(response.user).user,
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
        vendor: vendor,
      );
    } on AuthException {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error(
        'registerVendor failed',
        error: e,
        stackTrace: stackTrace,
      );
      return AuthFailure(message: e.toString());
    }
  }

  @override
  Future<AuthResult> login({
    required String phone,
    required String password,
  }) async {
    try {
      final response = await _remoteDataSource.login(
        LoginRequest(phone: phone, password: password),
      );

      await _saveAuthData(
        response.accessToken,
        response.refreshToken,
        response.user,
      );

      return AuthSuccess(
        user: UserModel.fromJson(response.user).user,
        accessToken: response.accessToken,
        refreshToken: response.refreshToken,
      );
    } on AuthException {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('login failed', error: e, stackTrace: stackTrace);
      return AuthFailure(message: e.toString());
    }
  }

  @override
  Future<String> refreshAccessToken({required String refreshToken}) async {
    try {
      final response = await _remoteDataSource.refreshToken(
        RefreshTokenRequest(refreshToken: refreshToken),
      );

      await _localDataSource.saveTokens(
        accessToken: response.accessToken,
        refreshToken: refreshToken,
      );

      return response.accessToken;
    } on AuthException {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error(
        'refreshAccessToken failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw AuthException.network(e.toString());
    }
  }

  @override
  Future<void> logout({required String refreshToken}) async {
    try {
      await _remoteDataSource.logout(LogoutRequest(refreshToken: refreshToken));
      await _localDataSource.clearAll();
    } on AuthException {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('logout failed', error: e, stackTrace: stackTrace);
      throw AuthException.network(e.toString());
    }
  }

  @override
  Future<User?> getCurrentUser() async {
    try {
      final userModel = await _localDataSource.getUser();
      if (userModel != null) {
        return userModel.user;
      }

      final refreshToken = await _localDataSource.getRefreshToken();
      if (refreshToken == null) {
        return null;
      }

      final userJson = await _remoteDataSource.getCurrentUser();
      final user = UserModel.fromJson(userJson).user;
      await _localDataSource.saveUser(UserModel(user));

      return user;
    } catch (e, stackTrace) {
      AppLogger.error(
        'getCurrentUser failed',
        error: e,
        stackTrace: stackTrace,
      );
      return null;
    }
  }

  @override
  Future<bool> isAuthenticated() async {
    final accessToken = await _localDataSource.getAccessToken();
    return accessToken != null;
  }

  @override
  Future<User?> validateTokenAndGetUser() async {
    try {
      final accessToken = await _localDataSource.getAccessToken();
      if (accessToken == null) {
        return null;
      }

      final userJson = await _remoteDataSource.getCurrentUser();
      final user = UserModel.fromJson(userJson).user;
      await _localDataSource.saveUser(UserModel(user));
      return user;
    } catch (e, stackTrace) {
      AppLogger.error(
        'validateTokenAndGetUser failed - clearing session',
        error: e,
        stackTrace: stackTrace,
      );
      await _localDataSource.clearAll();
      return null;
    }
  }

  @override
  Future<void> clearSession() async {
    await _localDataSource.clearAll();
  }

  @override
  Future<User> updateProfile({String? email}) async {
    try {
      final userJson = await _remoteDataSource.updateProfile(email: email);
      final user = UserModel.fromJson(userJson).user;
      await _localDataSource.saveUser(UserModel(user));
      return user;
    } on AuthException {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('updateProfile failed', error: e, stackTrace: stackTrace);
      throw AuthException.network(e.toString());
    }
  }

  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _remoteDataSource.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } on AuthException {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error(
        'changePassword failed',
        error: e,
        stackTrace: stackTrace,
      );
      throw AuthException.network(e.toString());
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await _remoteDataSource.deleteAccount();
      await _localDataSource.clearAll();
    } on AuthException {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('deleteAccount failed', error: e, stackTrace: stackTrace);
      throw AuthException.network(e.toString());
    }
  }

  Future<void> _saveAuthData(
    String accessToken,
    String refreshToken,
    Map<String, dynamic> userJson,
  ) async {
    await _localDataSource.saveTokens(
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
    await _localDataSource.saveUser(UserModel.fromJson(userJson));
  }
}
