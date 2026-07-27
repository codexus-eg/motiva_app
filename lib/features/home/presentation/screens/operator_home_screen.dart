import 'package:app/features/auth/presentation/providers/auth_notifier.dart';
import 'package:app/features/auth/presentation/providers/auth_state.dart';
import 'package:app/features/operator_dashboard/presentation/screens/operator_order_screen.dart';
import 'package:app/features/operator_dashboard/presentation/screens/operator_profile_screen.dart';
import 'package:app/shared/ui/navigation/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class OperatorHomeScreen extends ConsumerStatefulWidget {
  const OperatorHomeScreen({super.key});

  @override
  ConsumerState<OperatorHomeScreen> createState() => _OperatorHomeScreenState();
}

class _OperatorHomeScreenState extends ConsumerState<OperatorHomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            _buildBody(),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: BottomNavBar(
                selectedIndex: _selectedIndex,
                onTap: _onItemTapped,
                isOperator: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return IndexedStack(
      index: _selectedIndex,
      children: [
        _buildHomeContent(),
        const OperatorOrderScreen(isHomePage: true),
        const OperatorProfileScreen(),
      ],
    );
  }

  Widget _buildHomeContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 100, left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOperatorHeader(),
          const Gap(AppSpacing.xl),
          _buildServicesGrid(),
        ],
      ),
    );
  }

  Widget _buildOperatorHeader() {
    final theme = Theme.of(context).colorScheme;
    final authState = ref.watch(authNotifierProvider);

    String operatorName = 'Operator';
    String initial = 'O';

    if (authState.value != null && authState.value is AuthAuthenticated) {
      final user = (authState.value as AuthAuthenticated).user;
      if (user.fullName != null && user.fullName!.isNotEmpty) {
        operatorName = user.fullName!;
        initial = operatorName[0].toUpperCase();
      }
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundColor: Colors.orange,
              child: Text(
                initial,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Gap(AppSpacing.lg),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hi $operatorName!",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Poppins',
                    color: theme.onSurface,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/kuwait_flag.png',
                      height: 14.29,
                      width: 13.5,
                    ),
                    Gap(AppSpacing.md),
                    Text(
                      'Kuwait',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        color: theme.onSurface,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: GestureDetector(
            onTap: () {},
            child: SvgPicture.asset(
              'assets/icons/notification.svg',
              height: 28,
              width: 28,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServicesGrid() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 20,
      crossAxisSpacing: 10,
      childAspectRatio: 0.75,
      children: [
        _buildItem(
          context,
          'Incoming Requests',
          'assets/icons/home/incoming_request.png',
          () {},
        ),
        _buildItem(
          context,
          'Accepted Requests',
          'assets/icons/home/buy_car.png',
          () {},
        ),
        _buildItem(
          context,
          'Rides History',
          'assets/icons/home/road_assistance.png',
          () {},
        ),
      ],
    );
  }

  Widget _buildItem(
    BuildContext context,
    String label,
    String emoji,
    VoidCallback onTap,
  ) {
    final theme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                color: theme.primaryContainer,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Image.asset(emoji, width: 52, height: 52)),
            ),
          ),
          const Gap(AppSpacing.sm),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: theme.onSurface,
            ),
          ),
        ],
      ),
    );
  }
}
