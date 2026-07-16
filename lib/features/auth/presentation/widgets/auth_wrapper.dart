import 'package:app/features/auth/domain/entities/user_role.dart';
import 'package:app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:app/features/auth/presentation/providers/auth_state.dart';
import 'package:app/features/auth/presentation/screens/login/login_screen.dart';
import 'package:app/features/home/presentation/screens/home/home_screen.dart';
import 'package:app/features/home/presentation/screens/operator_home_screen.dart';
import 'package:app/features/vendor_dashboard/presentation/screens/vendor_profile_screen.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthWrapper extends ConsumerWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authNotifierProvider);

    return authState.when(
      data: (state) {
        if (state is AuthAuthenticated) {
          switch (state.user.role) {
            case UserRole.vendor:
              return const VendorProfileScreen();
            case UserRole.admin:
              return const VendorProfileScreen();
            case UserRole.customer:
              return const HomeScreen();
            case UserRole.operator:
              return const OperatorHomeScreen();
          }
        }

        if (state is AuthError) {
          return LoginScreen(errorMessage: state.message);
        }

        return const LoginScreen();
      },
      loading: () => Scaffold(
        body: ShimmerSkeletons.screenSkeleton(),
      ),
      error: (error, stack) => LoginScreen(
        errorMessage: 'Authentication error. Please login again.',
      ),
    );
  }
}
