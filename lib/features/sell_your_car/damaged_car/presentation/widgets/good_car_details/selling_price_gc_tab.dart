import 'package:app/features/auth/presentation/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class SellingPriceGCTab extends ConsumerStatefulWidget {
  final void Function(double price) onPriceEntered;

  const SellingPriceGCTab({super.key, required this.onPriceEntered});

  @override
  ConsumerState<SellingPriceGCTab> createState() => _SellingPriceGCTabState();
}

class _SellingPriceGCTabState extends ConsumerState<SellingPriceGCTab> {
  String sellingPrice = '';

  void _onKey(String value) {
    setState(() {
      if (value == '⌫') {
        if (sellingPrice.isNotEmpty) {
          sellingPrice = sellingPrice.substring(0, sellingPrice.length - 1);
        }
      } else {
        if (sellingPrice.length < 10) {
          sellingPrice += value;
        }
      }
    });
  }

  Widget _buildKey(String label, {String? sub}) {
    final isBackspace = label == '⌫';
    final theme = Theme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: () => _onKey(label),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isBackspace ? null : theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
            border: isBackspace
                ? null
                : Border.all(color: const Color(0xFF3A3A3A), width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isBackspace)
                Icon(
                  Icons.backspace_outlined,
                  color: theme.colorScheme.onSurface,
                  size: 20,
                )
              else
                Text(
                  label,
                  style: TextStyle(
                    color: theme.colorScheme.onSurface,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    height: 1,
                  ),
                ),
              if (sub != null && !isBackspace)
                Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: Text(
                    sub,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 9,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(List<Map<String, String?>> keys) {
    return SizedBox(
      height: 65,
      child: Row(
        children: keys
            .map((k) => _buildKey(k['label']!, sub: k['sub']))
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Translations.of(context).sell_your_car.selling_price_tab.title,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Gap(AppSpacing.md),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.white, width: 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      sellingPrice.isEmpty ? '0' : sellingPrice,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2,
                      ),
                    ),
                    Gap(AppSpacing.md),
                    Text(
                      Translations.of(
                        context,
                      ).sell_your_car.selling_price_tab.unit,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.colorScheme.onSurface,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: GradientButton(
            text: Translations.of(
              context,
            ).sell_your_car.selling_price_tab.kContinue,
            onTap: sellingPrice.isNotEmpty
                ? () => widget.onPriceEntered(double.parse(sellingPrice))
                : null,
          ),
        ),
        Gap(AppSpacing.lg),
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: Column(
            children: [
              _buildRow([
                {'label': '1', 'sub': null},
                {'label': '2', 'sub': 'ABC'},
                {'label': '3', 'sub': 'DEF'},
              ]),
              _buildRow([
                {'label': '4', 'sub': 'GHI'},
                {'label': '5', 'sub': 'JKL'},
                {'label': '6', 'sub': 'MNO'},
              ]),
              _buildRow([
                {'label': '7', 'sub': 'PQRS'},
                {'label': '8', 'sub': 'TUV'},
                {'label': '9', 'sub': 'WXYZ'},
              ]),
              SizedBox(
                height: 65,
                child: Row(
                  children: [
                    const Expanded(child: SizedBox()),
                    _buildKey('0'),
                    _buildKey('⌫'),
                  ],
                ),
              ),
            ],
          ),
        ),
        Gap(AppSpacing.md),
      ],
    );
  }
}
