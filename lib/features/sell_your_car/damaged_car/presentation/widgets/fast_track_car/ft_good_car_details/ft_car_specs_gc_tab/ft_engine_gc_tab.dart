import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:app/core/theme/spacing.dart';
import 'package:app/i18n/strings.g.dart';

class FtEngineGCTab extends StatefulWidget {
  final void Function(String engineSize) onEngineSelected;
  final VoidCallback onContinue;

  const FtEngineGCTab({
    super.key,
    required this.onEngineSelected,
    required this.onContinue,
  });

  @override
  State<FtEngineGCTab> createState() => _FtEngineGCTabState();
}

class _FtEngineGCTabState extends State<FtEngineGCTab> {
  String selectedEngine = '';

  final List<String> engines = const [
    "0 Cylinder",
    "3 Cylinder",
    "4 Cylinder",
    "5 Cylinder",
    "6 Cylinder",
    "8 Cylinder",
    "10 Cylinder",
    "12 Cylinder",
    "16 Cylinder",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            Translations.of(context).sell_your_car.engine_tab.title,
            style: TextStyle(
              color: theme.colorScheme.onSurface,
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
          ),
          Gap(AppSpacing.xl),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: engines.length,
              separatorBuilder: (_, _) => const Gap(AppSpacing.md),
              itemBuilder: (context, index) {
                final engine = engines[index];
                final isSelected = selectedEngine == engine;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedEngine = engine;
                    });

                    Future.delayed(const Duration(milliseconds: 150), () {
                      widget.onEngineSelected(engine);
                      widget.onContinue();
                    });
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFFB7791F)
                          : theme.colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Text(
                      engine,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
