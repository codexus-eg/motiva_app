// ignore_for_file: deprecated_member_use

import 'package:app/core/accessibility/semantic_labels.dart';
import 'package:app/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app/core/theme/spacing.dart';

class AccountInfoScreen extends StatefulWidget {
  const AccountInfoScreen({super.key});

  @override
  State<AccountInfoScreen> createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  static const Color _accentColor = Color(0xFFDC8735);

  String _selectedGender = 'female';
  bool _receiveOffers = true;
  bool _subscribeNewsletter = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const Gap(AppSpacing.lg),
              _buildFormFields(),
              const Gap(AppSpacing.lg),
              _buildGenderSection(),
              const Gap(AppSpacing.lg),
              _buildPreferenceToggles(),
              const Gap(AppSpacing.xl),
              _buildDeleteAccountButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        IconButton(
          tooltip: SemanticLabels.backButton,
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: _accentColor,
          onPressed: () => Navigator.pop(context),
          splashRadius: 18,
        ),
        const Gap(AppSpacing.md),
        Text(
          Translations.of(
            context,
          ).user_dashboard.settings.account_info.screen_title,
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: () {},
          child: Text(
            Translations.of(context).user_dashboard.settings.account_info.edit,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: _accentColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFormFields() {
    final theme = Theme.of(context);
    final t = Translations.of(
      context,
    ).user_dashboard.settings.account_info.fields;
    return Column(
      children: [
        _buildTextField(t.first_name),
        const Gap(AppSpacing.md),
        _buildTextField(t.last_name),
        const Gap(AppSpacing.md),
        _buildTextField(t.email),
        const Gap(AppSpacing.md),
        _buildTextField(
          t.date_of_birth,
          suffix: Icon(
            Icons.calendar_month_outlined,
            color: theme.colorScheme.onSurface.withOpacity(0.7),
            size: 22,
          ),
        ),
        const Gap(AppSpacing.md),
        _buildTextField(t.phone_number),
      ],
    );
  }

  Widget _buildGenderSection() {
    final theme = Theme.of(context);
    final t = Translations.of(
      context,
    ).user_dashboard.settings.account_info.gender;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.title,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const Gap(AppSpacing.md),
        Row(
          children: [
            _buildGenderOption('male', t.male),
            const Gap(AppSpacing.lg),
            _buildGenderOption('female', t.female),
          ],
        ),
      ],
    );
  }

  Widget _buildGenderOption(String value, String label) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Radio<String>(
          value: value,
          groupValue: _selectedGender,
          onChanged: (selected) {
            if (selected == null) return;
            setState(() => _selectedGender = selected);
          },
          activeColor: _accentColor,
          fillColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return _accentColor;
            }
            return theme.colorScheme.onSurface.withOpacity(0.5);
          }),
          visualDensity: VisualDensity.compact,
        ),
        const Gap(AppSpacing.xs),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildPreferenceToggles() {
    final t = Translations.of(
      context,
    ).user_dashboard.settings.account_info.preferences;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCheckbox(
          value: _receiveOffers,
          label: t.receive_offers,
          onChanged: (value) => setState(() => _receiveOffers = value ?? false),
        ),
        const Gap(AppSpacing.sm),
        _buildCheckbox(
          value: _subscribeNewsletter,
          label: t.newsletter,
          onChanged: (value) =>
              setState(() => _subscribeNewsletter = value ?? false),
        ),
      ],
    );
  }

  Widget _buildCheckbox({
    required bool value,
    required String label,
    required ValueChanged<bool?> onChanged,
  }) {
    final theme = Theme.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: value,
          onChanged: onChanged,
          checkColor: theme.colorScheme.surface,
          activeColor: theme.colorScheme.onSurface,
          side: BorderSide(color: theme.colorScheme.onSurface, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3)),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        const Gap(AppSpacing.md),
        Expanded(
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: theme.colorScheme.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDeleteAccountButton() {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: theme.colorScheme.primary, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.transparent,
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: Text(
        Translations.of(
          context,
        ).user_dashboard.settings.account_info.delete_account,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Pepsi',
          fontSize: 23,
          color: theme.colorScheme.primary,
          letterSpacing: 0.23,
        ),
      ),
    );
  }

  Widget _buildTextField(String hint, {Widget? suffix}) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 55,
      child: TextField(
        style: GoogleFonts.poppins(
          fontSize: 18,
          color: theme.colorScheme.onSurface,
        ),
        cursorColor: theme.colorScheme.onSurface,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(
            fontSize: 18,
            color: theme.colorScheme.onSurface.withOpacity(0.5),
          ),
          filled: true,
          fillColor: theme.colorScheme.primaryContainer,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 15,
          ),
          suffixIcon: suffix,
          suffixIconColor: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}
