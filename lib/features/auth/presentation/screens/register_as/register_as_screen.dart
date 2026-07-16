import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/features/auth/presentation/providers/providers.dart';
import 'package:app/features/auth/presentation/screens/register_customer/customer_info_screen.dart';
import 'package:app/features/auth/presentation/screens/register_vendor/business_info_screen.dart';
import 'package:app/features/auth/presentation/screens/login/login_screen.dart';
import 'package:app/features/auth/presentation/widgets/auth_background.dart';
import 'package:app/features/auth/presentation/widgets/auth_card.dart';
import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:app/shared/ui/inputs/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';

class RegisterAsScreen extends ConsumerStatefulWidget {
  const RegisterAsScreen({super.key});

  @override
  ConsumerState<RegisterAsScreen> createState() => _RegisterAsScreenState();
}

class _RegisterAsScreenState extends ConsumerState<RegisterAsScreen> {
  String? _selectedUserType;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final List<String> userTypes = [
      t.auth.register_as.business_owner,
      t.auth.register_as.customer,
      t.auth.register_as.driver,
    ];

    return AuthBackground(
      child: AuthCard(
        child: Column(
          children: [
            Text(
              t.auth.register_as.title,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: Colors.white,
                letterSpacing: 1.0,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Semantics(
              hint: SemanticLabels.selectCategoryButton,
              child: CustomDropdown<String>(
                hintText: t.auth.register_as.select_user_type,
                value: _selectedUserType,
                items: userTypes.map((type) {
                  return DropdownMenuItem(value: type, child: Text(type));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedUserType = value;
                  });
                  ref
                      .read(registrationNotifierProvider.notifier)
                      .setUserType(
                        value == t.auth.register_as.business_owner
                            ? 'vendor'
                            : value == t.auth.register_as.driver
                            ? 'driver'
                            : 'customer',
                      );
                },
              ),
            ),
            const Gap(AppSpacing.xl),
            GradientButton(
              text: t.auth.get_started,
              isPrimary: true,
              onTap: () {
                if (_selectedUserType == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please select a user type')),
                  );
                  return;
                }
                if (_selectedUserType == t.auth.register_as.business_owner) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const BusinessInfoScreen(),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CustomerInfoScreen(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
            Semantics(
              button: true,
              onTapHint: 'Navigate to login',
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
