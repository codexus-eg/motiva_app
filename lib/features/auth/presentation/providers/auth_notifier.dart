import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/features/auth/data/exceptions/auth_exceptions.dart';
import 'package:app/features/auth/domain/entities/auth_result.dart';
import 'package:app/features/auth/domain/entities/user.dart';
import 'package:app/features/auth/presentation/providers/auth_providers.dart';
import 'package:app/features/auth/presentation/providers/auth_state.dart';

class AuthNotifier extends AsyncNotifier<AuthState> {
  @override
  AuthState build() {
    _checkAuthStatus();
    return const AuthChecking();
  }

  Future<void> _checkAuthStatus() async {
    state = const AsyncValue.loading();
    final result = await AsyncValue.guard(() async {
      final repo = ref.read(authRepositoryProvider);
      final user = await repo.validateTokenAndGetUser();
      if (user != null) {
        return AuthAuthenticated(user: user);
      }
      return const AuthUnauthenticated();
    });

    state = result;
  }

  Future<bool> sendOtp({
    required String phone,
    String userType = 'customer',
  }) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.sendOtp(phone: phone, userType: userType);
      state = const AsyncValue.data(AuthUnauthenticated());
      return true;
    } on AuthException catch (e, stackTrace) {
      AppLogger.error('sendOtp failed', error: e, stackTrace: stackTrace);
      state = AsyncValue.error(e, stackTrace);
      return false;
    }
  }

  Future<String?> verifyOtp({
    required String phone,
    required String code,
    String userType = 'customer',
  }) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final verificationToken = await repo.verifyOtp(
        phone: phone,
        code: code,
        userType: userType,
      );
      return verificationToken;
    } on AuthException catch (e, stackTrace) {
      AppLogger.error('verifyOtp failed', error: e, stackTrace: stackTrace);
      state = AsyncValue.error(e, stackTrace);
      return null;
    }
  }

  Future<bool> registerCustomer({
    required String verificationToken,
    required String phone,
    required String password,
    String? fullName,
    String? email,
  }) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final result = await repo.registerCustomer(
        verificationToken: verificationToken,
        phone: phone,
        password: password,
        fullName: fullName,
        email: email,
      );

      if (result is AuthSuccess) {
        state = AsyncValue.data(AuthAuthenticated(user: result.user));
        return true;
      } else {
        final failure = result as AuthFailure;
        state = AsyncValue.error(
          Exception(failure.message),
          StackTrace.current,
        );
        return false;
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        'registerCustomer failed',
        error: e,
        stackTrace: stackTrace,
      );
      state = AsyncValue.error(e, stackTrace);
      return false;
    }
  }

  Future<bool> registerVendor({
    required String verificationToken,
    required String phone,
    required String password,
    required String businessName,
    String? fullName,
    String? email,
    String? commercialLicenseNo,
    required String categoryId,
  }) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final result = await repo.registerVendor(
        verificationToken: verificationToken,
        phone: phone,
        password: password,
        businessName: businessName,
        fullName: fullName,
        email: email,
        commercialLicenseNo: commercialLicenseNo,
        categoryId: categoryId,
      );

      if (result is AuthSuccess) {
        state = AsyncValue.data(
          AuthAuthenticated(user: result.user, vendor: result.vendor),
        );
        return true;
      } else {
        final failure = result as AuthFailure;
        state = AsyncValue.error(
          Exception(failure.message),
          StackTrace.current,
        );
        return false;
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        'registerVendor failed',
        error: e,
        stackTrace: stackTrace,
      );
      state = AsyncValue.error(e, stackTrace);
      return false;
    }
  }

  Future<bool> login({required String phone, required String password}) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final result = await repo.login(phone: phone, password: password);

      if (result is AuthSuccess) {
        state = AsyncValue.data(AuthAuthenticated(user: result.user));
        return true;
      } else {
        final failure = result as AuthFailure;
        state = AsyncValue.error(
          Exception(failure.message),
          StackTrace.current,
        );
        return false;
      }
    } catch (e, stackTrace) {
      AppLogger.error('login failed', error: e, stackTrace: stackTrace);
      state = AsyncValue.error(e, stackTrace);
      return false;
    }
  }

  Future<void> logout() async {
    final repo = ref.read(authRepositoryProvider);
    final refreshToken = await ref
        .read(authLocalDataSourceProvider)
        .getRefreshToken();

    if (refreshToken != null) {
      await repo.logout(refreshToken: refreshToken);
    } else {
      await repo.clearSession();
    }

    state = const AsyncValue.data(AuthUnauthenticated());
  }

  Future<void> refreshSession() async {
    await _checkAuthStatus();
  }

  Future<User?> getCurrentUser() async {
    final repo = ref.read(authRepositoryProvider);
    return await repo.getCurrentUser();
  }

  Future<bool> isAuthenticated() async {
    final repo = ref.read(authRepositoryProvider);
    return await repo.isAuthenticated();
  }

  Future<bool> updateEmail({required String email}) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      final user = await repo.updateProfile(email: email);
      state = AsyncValue.data(AuthAuthenticated(user: user));
      return true;
    } on AuthException catch (e, stackTrace) {
      AppLogger.error('updateEmail failed', error: e, stackTrace: stackTrace);
      state = AsyncValue.error(e, stackTrace);
      return false;
    } catch (e, stackTrace) {
      AppLogger.error('updateEmail failed', error: e, stackTrace: stackTrace);
      state = AsyncValue.error(e, stackTrace);
      return false;
    }
  }

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
      state = const AsyncValue.data(AuthUnauthenticated());
      return true;
    } on AuthException catch (e, stackTrace) {
      AppLogger.error(
        'changePassword failed',
        error: e,
        stackTrace: stackTrace,
      );
      state = AsyncValue.error(e, stackTrace);
      return false;
    } catch (e, stackTrace) {
      AppLogger.error(
        'changePassword failed',
        error: e,
        stackTrace: stackTrace,
      );
      state = AsyncValue.error(e, stackTrace);
      return false;
    }
  }

  Future<bool> deleteAccount() async {
    state = const AsyncValue.loading();
    try {
      final repo = ref.read(authRepositoryProvider);
      await repo.deleteAccount();
      state = const AsyncValue.data(AuthUnauthenticated());
      return true;
    } on AuthException catch (e, stackTrace) {
      AppLogger.error('deleteAccount failed', error: e, stackTrace: stackTrace);
      state = AsyncValue.error(e, stackTrace);
      return false;
    } catch (e, stackTrace) {
      AppLogger.error('deleteAccount failed', error: e, stackTrace: stackTrace);
      state = AsyncValue.error(e, stackTrace);
      return false;
    }
  }
}

final authNotifierProvider = AsyncNotifierProvider<AuthNotifier, AuthState>(
  AuthNotifier.new,
);
