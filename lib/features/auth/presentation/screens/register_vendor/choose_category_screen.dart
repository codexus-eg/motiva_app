import 'package:app/features/auth/presentation/providers/providers.dart';
import 'package:app/features/auth/presentation/screens/login/login_screen.dart';
import 'package:app/features/auth/presentation/widgets/auth_background.dart';
import 'package:app/features/auth/presentation/widgets/auth_card.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/features/service-categories/presentation/providers/service_categories_provider.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/shimmer/shimmer_skeletons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class ChooseCategoryScreen extends ConsumerStatefulWidget {
  final String verificationToken;
  final String phone;
  final String password;
  final String businessName;
  final String? fullName;
  final String? email;
  final String? commercialLicenseNo;

  const ChooseCategoryScreen({
    super.key,
    required this.verificationToken,
    required this.phone,
    required this.password,
    required this.businessName,
    this.fullName,
    this.email,
    this.commercialLicenseNo,
  });

  @override
  ConsumerState<ChooseCategoryScreen> createState() =>
      _ChooseCategoryScreenState();
}

class _ChooseCategoryScreenState extends ConsumerState<ChooseCategoryScreen> {
  String? _selectedCategoryId;
  String? _selectedCategoryName;
  String? _categoryError;
  bool _isLoading = false;

  Future<void> _handleContinue() async {
    final t = Translations.of(context);

    if (_selectedCategoryId == null) {
      setState(() {
        _categoryError = t.auth.category.error.null_category;
      });
      return;
    }
    setState(() => _categoryError = null);

    setState(() => _isLoading = true);

    final success = await ref
        .read(authNotifierProvider.notifier)
        .registerVendor(
          verificationToken: widget.verificationToken,
          phone: widget.phone,
          password: widget.password,
          businessName: widget.businessName,
          fullName: widget.fullName,
          email: widget.email,
          commercialLicenseNo: widget.commercialLicenseNo,
          categoryId: _selectedCategoryId!,
        );

    setState(() => _isLoading = false);

    if (success && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.auth.category.registration_success),
          duration: Duration(seconds: 4),
        ),
      );
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (route) => false,
      );
    } else if (mounted) {
      final authState = ref.read(authNotifierProvider);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            authState.error?.toString() ??
                t.auth.category.error.registration_failed,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final categoriesAsync = ref.watch(serviceCategoriesProvider);
    final t = Translations.of(context);

    return AuthBackground(
      child: AuthCard(
        child: Column(
          children: [
            Text(
              t.auth.category.title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(AppSpacing.xl),
            categoriesAsync.when(
              data: (categories) {
                if (categories.isEmpty) {
                  return Text(
                    t.auth.category.error.no_categories,
                    style: TextStyle(color: Colors.white70),
                  );
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                        border: _categoryError != null
                            ? Border.all(color: Colors.redAccent)
                            : null,
                      ),
                      child: Theme(
                        data: Theme.of(
                          context,
                        ).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          key: const PageStorageKey('category_dropdown'),
                          collapsedIconColor: Colors.white,
                          iconColor: Colors.white,
                          title: Text(
                            _selectedCategoryName ??
                                t.auth.category.select_category,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              color: _selectedCategoryName == null
                                  ? Colors.white.withValues(alpha: 0.5)
                                  : Colors.white,
                            ),
                          ),
                          children: categories.map((category) {
                            return ListTile(
                              title: Text(
                                category.name,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onTap: () {
                                setState(() {
                                  _selectedCategoryId = category.id;
                                  _selectedCategoryName = category.name;
                                  _categoryError = null;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    if (_categoryError != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 4, top: 6),
                        child: Text(
                          _categoryError!,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 12,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                  ],
                );
              },
              loading: () => ShimmerSkeletons.cardSkeleton(),
              error: (error, stack) => Column(
                children: [
                  Text(
                    t.auth.category.error.failed_to_load,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.7),
                    ),
                  ),
                  const Gap(AppSpacing.md),
                  TextButton(
                    onPressed: () {
                      ref.invalidate(serviceCategoriesProvider);
                    },
                    child: Text(
                      t.auth.category.error.button,
                      style: TextStyle(color: Color(0xFFE28C37)),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.xl),
            GradientButton(
              text: _isLoading
                  ? t.auth.category.loading
                  : t.auth.continue_button,
              isPrimary: true,
              onTap: _isLoading ? null : _handleContinue,
            ),
            const Gap(AppSpacing.lg),
            GestureDetector(
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  children: [
                    TextSpan(text: t.auth.already_have_account),
                    TextSpan(
                      text: t.auth.login_button,
                      style: TextStyle(
                        color: Color(0xFFE28C37),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
