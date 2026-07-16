import 'package:app/features/auth/domain/entities/user_role.dart';
import 'package:app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:app/features/auth/presentation/providers/auth_state.dart';
import 'package:app/features/auth/presentation/screens/login/login_screen.dart';
import 'package:app/features/home/presentation/screens/home/home_screen.dart';
import 'package:app/features/home/presentation/screens/operator_home_screen.dart';
import 'package:app/features/home/presentation/screens/vendor_home_screen.dart';
import 'package:app/features/vendor/presentation/providers/vendor_provider.dart';
import 'package:app/core/utils/app_logger.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class AuthSplashScreen extends ConsumerStatefulWidget {
  const AuthSplashScreen({super.key});

  @override
  ConsumerState<AuthSplashScreen> createState() => _AuthSplashScreenState();
}

class _AuthSplashScreenState extends ConsumerState<AuthSplashScreen> {
  String? _errorMessage;
  bool _vendorProfileCheckCompleted = false;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authNotifierProvider);
    final t = Translations.of(context);

    return authState.when(
      data: (state) {
        if (_errorMessage != null) {
          return LoginScreen(errorMessage: _errorMessage);
        }

        if (state is AuthChecking || state is AuthInitial) {
          return _buildSplashContent(t.auth.splash.initializing);
        }

        if (state is AuthLoading) {
          return _buildSplashContent(t.auth.splash.loading);
        }

        if (state is AuthAuthenticated) {
          final user = state.user;

          if ((user.role == UserRole.vendor || user.role == UserRole.admin) &&
              !_vendorProfileCheckCompleted) {
            return _VendorProfileCheckScreen(
              onProfileVerified: () {
                if (mounted) {
                  setState(() => _vendorProfileCheckCompleted = true);
                }
              },
              onProfileError: (error) {
                if (mounted) {
                  setState(() {
                    _errorMessage = error;
                  });
                }
              },
            );
          }

          if (user.role == UserRole.customer) {
            return const HomeScreen();
          }

          if (user.role == UserRole.operator) {
            return const OperatorHomeScreen();
          }

          return const VendorHomeScreen();
        }

        if (state is AuthUnauthenticated) {
          return const LoginScreen();
        }

        if (state is AuthError) {
          return LoginScreen(errorMessage: state.message);
        }

        return const LoginScreen();
      },
      loading: () => _buildSplashContent(t.auth.splash.checking_auth),
      error: (error, stack) {
        AppLogger.error(
          t.auth.splash.error.splash_failed,
          error: error,
          stackTrace: stack,
        );
        return LoginScreen(
          errorMessage: t.auth.splash.error.auth_failed,
        );
      },
    );
  }

  Widget _buildSplashContent(String message) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ShimmerSkeletons.screenSkeleton(),
              ),
              const Gap(AppSpacing.lg),
              Text(
                message,
                style: TextStyle(color: theme.onSurface, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _VendorProfileCheckScreen extends ConsumerStatefulWidget {
  final VoidCallback onProfileVerified;
  final void Function(String error) onProfileError;

  const _VendorProfileCheckScreen({
    required this.onProfileVerified,
    required this.onProfileError,
  });

  @override
  ConsumerState<_VendorProfileCheckScreen> createState() =>
      _VendorProfileCheckScreenState();
}

class _VendorProfileCheckScreenState
    extends ConsumerState<_VendorProfileCheckScreen> {
  String? _error;

  @override
  void initState() {
    super.initState();
    _verifyVendorProfile();
  }

  Future<void> _verifyVendorProfile() async {
    try {
      await ref.read(vendorProfileProvider.future);
      if (mounted) {
        widget.onProfileVerified();
      }
    } catch (e, stackTrace) {
      AppLogger.error(
        t.auth.splash.vendor.login_error,
        error: e,
        stackTrace: stackTrace,
      );

      if (mounted) {
        await ref.read(authNotifierProvider.notifier).logout();
        setState(() {
          _error = t.auth.splash.vendor.logout_error;
        });
        widget.onProfileError(_error!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return LoginScreen(errorMessage: _error);
    }

    final theme = Theme.of(context).colorScheme;
    final t = Translations.of(context);

    return Scaffold(
      backgroundColor: theme.surface,
      body: SafeArea(
        bottom: false,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: ShimmerSkeletons.screenSkeleton(),
              ),
              const Gap(AppSpacing.lg),
              Text(
                t.auth.splash.vendor.title,
                style: TextStyle(color: theme.onSurface, fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
